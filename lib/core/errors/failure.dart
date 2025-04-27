// failures.dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class FirestoreFailure extends Failure {
  const FirestoreFailure(super.message);
}

class TodoFailure extends Failure {
  const TodoFailure(super.message);
}

class UserFailure extends Failure {
  const UserFailure(super.message);
}
