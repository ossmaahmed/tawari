import 'package:flutter/material.dart';
import 'package:tawari/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: "",
    phone: "",
    name: "",
    longitude: "",
    latitude: "",
    nationalID: "",
    password: "",
    profileImage: "",
    token: "",
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
