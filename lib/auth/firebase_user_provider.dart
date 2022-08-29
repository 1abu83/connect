import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class SeriusFirebaseUser {
  SeriusFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

SeriusFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<SeriusFirebaseUser> seriusFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<SeriusFirebaseUser>((user) => currentUser = SeriusFirebaseUser(user));
