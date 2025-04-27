import 'package:flutter/material.dart';
import 'package:shareed_todo/presentation/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../model/user_detail.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._authService);
  final AuthRepository _authService;
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  UserDetail? _userDetail;

  UserDetail? get userDetail => _userDetail;

  bool isLogin() {
    final data = _authService.isLoggedIn();
    return data.fold((l) => false, (r) {
      _userDetail = r;
      notifyListeners();
      return true;
    });
  }

  Future<Either<String, UserDetail>> signInWithGoogle() async {
    setLoading(true);
    final result = await _authService.signInWithGoogle();
    setLoading(false);
    return result.fold(
      (failure) {
        _userDetail = null;
        notifyListeners();
        print(failure);
        return Left(failure);
      },
      (user) {
        _userDetail = user;
        notifyListeners();
        return Right(user);
      },
    );
  }

  Future<Either<String, UserDetail>> signUpWithEmailPassword(
      String email, String password, String name) async {
    final result = await _authService.signUpWithEmailPassword(
      email,
      password,
      name,
    );
    return result.fold(
      (failure) {
        _userDetail = null;
        notifyListeners();
        return Left(failure);
      },
      (user) {
        _userDetail = user;
        notifyListeners();
        return Right(user);
      },
    );
  }

  Future<Either<String, UserDetail>> signInWithEmailPassword(
      String email, String password) async {
    final result = await _authService.signInWithEmailPassword(
      email,
      password,
    );
    return result.fold(
      (failure) {
        _userDetail = null;
        notifyListeners();
        return Left(failure);
      },
      (user) {
        _userDetail = user;
        notifyListeners();
        return Right(user);
      },
    );
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _userDetail = null;
    notifyListeners();
  }
}
