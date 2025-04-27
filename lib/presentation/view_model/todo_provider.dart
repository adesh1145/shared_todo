import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shareed_todo/presentation/model/todo.dart';
import 'package:shareed_todo/presentation/model/user_detail.dart';
import 'package:shareed_todo/presentation/view_model/auth_provider.dart';

import '../repository/todo_repository.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider(this._todoRepository, this._authProvider);
  final TodoRepository _todoRepository;
  final AuthProvider _authProvider;
  List<UserDetail> searchedUsers = [];
  List<UserDetail> sharedUsers = [];
  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Stream<List<Todo>> getTodos() {
    return _todoRepository.getUserTodosRealTime(_authProvider.userDetail!.uid!);
  }

  Stream<Todo> getTodoByIdRealtime(String todoId) {
    return _todoRepository.getTodoByIdRealTime(todoId);
  }

  Future<Either<String, String>> createTodo(String title, String description) {
    setLoading(true);
    return _todoRepository
        .createTodo(_authProvider.userDetail!.uid!, title, description)
        .then((result) {
      return result.fold((l) {
        return Left(l);
      }, (r) {
        setLoading(false);
        return Right(r);
      });
    });
  }

  Future<Either<String, void>> deleteTodo(String todoId) {
    setLoading(true);
    return _todoRepository.deleteTodo(todoId).then((result) {
      return result.fold((l) {
        setLoading(false);
        return Left(l);
      }, (r) {
        setLoading(false);

        return Right(null);
      });
    });
  }

  Future<Either<String, void>> removeSharedUser(
      String todoId, UserDetail userDetail) {
    sharedUsers.remove(userDetail);
    setLoading(true);
    return _todoRepository
        .removeSharedUser(todoId, userDetail.uid!)
        .then((result) {
      return result.fold((l) {
        setLoading(false);
        return Left(l);
      }, (r) {
        setLoading(false);
        return Right(null);
      });
    });
  }

  Future<Either<String, void>> updateTodo(
      String todoId, String title, String description) {
    setLoading(true);
    return _todoRepository
        .updateTodo(todoId, title, description)
        .then((result) {
      return result.fold((l) {
        setLoading(false);
        return Left(l);
      }, (r) {
        setLoading(false);
        return Right(null);
      });
    });
  }

  Future<Either<String, List<UserDetail>>> searchUsers(String query) {
    setLoading(true);
    return _todoRepository.searchUsers(query).then((result) {
      return result.fold((l) {
        setLoading(false);
        searchedUsers = [];
        return Left(l);
      }, (r) {
        searchedUsers = r;
        setLoading(false);
        return Right(r);
      });
    });
  }

  Future<Either<String, void>> shareTodo(
      String todoId, UserDetail userDetail, String permission) async {
    if (sharedUsers.contains(userDetail)) {
      return Right(null);
    }
    sharedUsers.add(userDetail);
    setLoading(true);
    return _todoRepository
        .shareTodo(todoId, userDetail.uid!, permission)
        .then((result) {
      return result.fold((l) {
        setLoading(false);
        return Left(l);
      }, (r) {
        setLoading(false);
        return Right(null);
      });
    });
  }

  Future<Either<String, List<UserDetail>>> getUsersByIds(List<String> userIds) {
    sharedUsers = [];
    setLoading(true);
    return _todoRepository.getUsersByIds(userIds).then((result) {
      return result.fold((l) {
        sharedUsers = [];
        setLoading(false);
        return Left(l);
      }, (r) {
        sharedUsers = r;
        setLoading(false);
        return Right(r);
      });
    });
  }
}
