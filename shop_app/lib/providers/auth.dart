import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSeegment) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:$urlSeegment?key=AIzaSyBtWkQEd1uDPRw1c-LsMWTBCcXenDCJ8DI',
    );
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(json.decode(response.body));
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signin(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
