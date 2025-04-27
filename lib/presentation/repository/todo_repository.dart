import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../model/todo.dart';
import '../model/user_detail.dart';

class TodoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Real-time listener for todos of a user
  Stream<List<Todo>> getUserTodosRealTime(String userId) {
    return _firestore
        .collection('todos')
        .where('ownerId', isEqualTo: userId)
        .snapshots()
        .map((todosQuerySnapshot) {
      return todosQuerySnapshot.docs.map((doc) {
        final data = doc.data();
        return Todo.fromJson(data);
      }).toList();
    });
  }

  Stream<List<Todo>> getSharedTodosRealTime(String userId) {
    return _firestore
        .collection('todos')
        .where('sharedWith', arrayContains: userId)
        .snapshots()
        .map((todosQuerySnapshot) {
      return todosQuerySnapshot.docs.map((doc) {
        final data = doc.data();
        return Todo.fromJson(data);
      }).toList();
    });
  }

  // Real-time listener for a specific todo by ID
  Stream<Todo> getTodoByIdRealTime(String todoId) {
    return _firestore
        .collection('todos')
        .doc(todoId)
        .snapshots()
        .map((todoDocSnapshot) {
      final data = todoDocSnapshot.data()!;
      return Todo.fromJson(data);
    });
  }

  Future<Either<String, Todo>> getTodoById(String todoId) async {
    try {
      final todoDocSnapshot =
          await _firestore.collection('todos').doc(todoId).get();

      if (!todoDocSnapshot.exists) {
        return Left("Todo not found");
      }

      final data = todoDocSnapshot.data()!;

      return Right(Todo.fromJson(data));
    } catch (e) {
      log('Error getting todo by ID: $e');
      return Left("Error getting todo by ID: $e");
    }
  }

  Future<Either<String, String>> createTodo(
      String userId, String title, String description) async {
    try {
      final newTodoRef = _firestore.collection('todos').doc();
      final todo = Todo(
        todoId: newTodoRef.id,
        title: title,
        description: description,
        ownerId: userId,
        sharedWith: [],
        timestamp: Timestamp.fromDate(DateTime.now()),
      );
      await newTodoRef.set(todo.toJson());

      return Right(newTodoRef.id);
    } catch (e) {
      log('Error creating todo: $e');
      return Left("Error creating todo: $e");
    }
  }

  Future<Either<String, String>> updateTodo(
      String todoId, String title, String description) async {
    try {
      final todoRef = _firestore.collection('todos').doc(todoId);

      await todoRef.update({
        'title': title,
        'description': description,
        'timestamp': FieldValue.serverTimestamp(),
      });

      return Right(todoId);
    } catch (e) {
      log('Error updating todo: $e');
      return Left("Error updating todo: $e");
    }
  }

  Future<Either<String, String>> deleteTodo(String todoId) async {
    try {
      await _firestore.collection('todos').doc(todoId).delete();
      return Right(todoId);
    } catch (e) {
      log('Error deleting todo: $e');
      return Left("Error deleting todo: $e");
    }
  }

  Future<Either<String, List<UserDetail>>> searchUsers(String query) async {
    try {
      final userQuerySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: query)
          // .where('name', isEqualTo: query)
          .get();

      if (userQuerySnapshot.docs.isEmpty) {
        return Left("No user found with this email");
      }

      final userDoc = userQuerySnapshot.docs;
      final userData = userDoc
          .map(
            (e) => UserDetail.fromJson(e.data()),
          )
          .toList();

      // Return the UserDetail instance wrapped in a Right
      return Right(userData);
    } catch (e) {
      print('Error fetching user by email: $e');
      return Left("Error fetching user details: $e");
    }
  }

  Future<Either<String, String>> shareTodo(String todoId, String userId) async {
    try {
      final todoRef = _firestore.collection('todos').doc(todoId);
      final todoDocSnapshot = await todoRef.get();

      if (!todoDocSnapshot.exists) {
        return Left("Todo not found");
      }

      final todoData = todoDocSnapshot.data()!;
      final todo = Todo.fromJson(todoData);
      final sharedWith = List<String>.from(todo.sharedWith ?? []);

      final existingShare = sharedWith.firstWhere(
        (user) => user == userId,
        orElse: () => '',
      );

      if (existingShare.isNotEmpty) {
        return Left("User is already shared with this todo");
      }

      // Add user to sharedWith as a SharedWithUser object
      sharedWith.add(userId);
      await todoRef.update({'sharedWith': sharedWith});

      return Right("Todo shared successfully");
    } catch (e) {
      log('Error sharing todo: $e');
      return Left("Error sharing todo: $e");
    }
  }

  Future<Either<String, void>> removeSharedUser(
      String todoId, String userId) async {
    try {
      final todoRef = _firestore.collection('todos').doc(todoId);
      final todoDocSnapshot = await todoRef.get();

      if (!todoDocSnapshot.exists) {
        return Left("Todo not found");
      }

      final todoData = todoDocSnapshot.data()!;
      final todo = Todo.fromJson(todoData);
      final sharedWith = List<String>.from(todo.sharedWith ?? []);

      final existingShare = sharedWith.firstWhere(
        (user) => user == userId,
        orElse: () => '',
      );

      if (existingShare.isEmpty) {
        return Left("User is not shared with this todo");
      }

      // Remove user from sharedWith
      sharedWith.removeWhere((user) => user == userId);
      await todoRef.update({'sharedWith': sharedWith});

      return Right(null);
    } catch (e) {
      log('Error removing shared user: $e');
      return Left("Error removing shared user: $e");
    }
  }

  Future<Either<String, List<UserDetail>>> getUsersByIds(
      List<String> userIds) async {
    try {
      if (userIds.isEmpty) {
        return Left("No user IDs provided");
      }

      // Firestore whereIn query
      final userQuerySnapshot = await _firestore
          .collection('users')
          .where(FieldPath.documentId, whereIn: userIds)
          .get();

      if (userQuerySnapshot.docs.isEmpty) {
        return Left("No users found for provided IDs");
      }

      final users = userQuerySnapshot.docs
          .map((doc) => UserDetail.fromJson(doc.data()))
          .toList();

      return Right(users);
    } catch (e) {
      log('Error fetching users by IDs: $e');
      return Left("Error fetching users by IDs: $e");
    }
  }
}
