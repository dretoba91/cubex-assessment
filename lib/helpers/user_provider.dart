// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String? _email;
  String? _password;
  String? _username;
  static const String _keyLogin = 'login';
  String? _phoneNumber;
  String? _token;

  get email => _email;
  get password => _password;
  get username => _username;
  get keyLogin => _keyLogin;
  get phoneNumber => _phoneNumber;
  get token => _token;

  Future<bool> setEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = value;
    prefs.setBool(_keyLogin, true);
    notifyListeners();
    return true;
  }

  Future<bool> setPassword(String value) async {
    _password = value;
    notifyListeners();
    return true;
  }

  Future<bool> setUsername(String value) async {
    _username = value;
    notifyListeners();
    return true;
  }

  Future<bool> setPhoneNumber(String value) async {
    _phoneNumber = value;
    notifyListeners();
    return true;
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = value;
    notifyListeners();
    return prefs.setString('token', value);
  }
}
