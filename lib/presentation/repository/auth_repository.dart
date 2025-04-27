import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shareed_todo/core/constants/constants.dart';
import '../model/user_detail.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, UserDetail>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Left("User cancelled Google sign-in");
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final firebaseUser = userCredential.user!;

      await _createUserInFirestore(firebaseUser);

      return Right(UserDetail(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: firebaseUser.displayName ?? 'No Name',
        photoUrl: firebaseUser.photoURL,
        source: 'google',
      ));
    } catch (e) {
      log('Error signing in with Google: $e');
      return Left("Error signing in with Google: $e");
    }
  }

  Either<String, UserDetail> isLoggedIn() {
    User? user = _auth.currentUser;
    if (user != null) {
      return Right(UserDetail(
        uid: user.uid,
        email: user.email!,
        name: user.displayName ?? '',
        photoUrl: user.photoURL,
        source: user.providerData[0].providerId,
      ));
    }
    return Left("User is not logged in");
  }

  Future<Either<String, UserDetail>> signUpWithEmailPassword(
      String email, String password, String name) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = userCredential.user!;
      await firebaseUser.updateDisplayName(name);

      await _createUserInFirestore(firebaseUser);

      return Right(UserDetail(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: firebaseUser.displayName ?? 'No Name',
        source: 'email',
      ));
    } catch (e) {
      log('Error signing up with email and password: $e');
      return Left("Error signing up with email and password: $e");
    }
  }

  Future<Either<String, UserDetail>> signInWithEmailPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = userCredential.user!;

      await _createUserInFirestore(firebaseUser);

      return Right(UserDetail(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: firebaseUser.displayName ?? 'No Name',
        source: 'email',
      ));
    } catch (e) {
      log('Error signing in with email and password: $e');
      return Left("Error signing in with email and password: $e");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> _createUserInFirestore(User firebaseUser) async {
    try {
      final userRef =
          _firestore.collection(Constants.users).doc(firebaseUser.uid);

      await userRef.set({
        'uid': firebaseUser.uid,
        'email': firebaseUser.email,
        'name': firebaseUser.displayName ?? 'No Name',
        'photoUrl': firebaseUser.photoURL ?? '',
        'source': firebaseUser.providerData[0].providerId,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      log("Error saving user data to Firestore: $e");
    }
  }
}
