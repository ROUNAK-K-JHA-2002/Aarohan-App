import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aarohan_app/services/auth_services.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  AuthService _authService;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;

  Status _status = Status.Uninitialized;

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Status get status => _status;
  User get user => _user;

  Future signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _authService.gSignIn();
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
    }
  }

  Future signOut() async {
    await _authService.gSignOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      // AuthService authService = AuthService();
      // await authService.storeUser(firebaseUser);
    }
    notifyListeners();
  }
}
