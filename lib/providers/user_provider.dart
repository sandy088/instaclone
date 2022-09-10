import 'package:flutter/material.dart';
import 'package:instaclone/models/user.dart';
import 'package:instaclone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods authMethods = AuthMethods();
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await authMethods.getUserDetails();

    _user = user;
    notifyListeners();
  }
}
