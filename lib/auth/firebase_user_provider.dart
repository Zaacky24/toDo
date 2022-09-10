import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TOdOFirebaseUser {
  TOdOFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

TOdOFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TOdOFirebaseUser> tOdOFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<TOdOFirebaseUser>((user) => currentUser = TOdOFirebaseUser(user));
