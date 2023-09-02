import 'package:demo1/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    token: '',
    type: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
