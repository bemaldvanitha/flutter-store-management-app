import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier{
  String _token;
  DateTime _expiredDate;

  bool get isAuth{
    return _token != null;
  }

  String get token{
    if(_expiredDate != null && _expiredDate.isAfter(DateTime.now()) && _token != null){
      return _token;
    }
    return null;
  }

  Future<void> signUp(String email,String password) async {
    var url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDFtQ5SzXNRmD8mLvDtpHpviEzCF5aGJtA';

    try {
      final response = await http.post(url, body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }));
      final extractedBody = json.decode(response.body);

      if(extractedBody['error'] != null){
        throw HttpException(extractedBody['error']['message']);
      }
      _token = extractedBody['idToken'];
      _expiredDate = DateTime.now().add(Duration(seconds: int.parse(extractedBody['expiresIn'])));
      //print(extractedBody);
    }catch(err){
      throw err;
    }
  }

  Future<void> signIn(String email,String password) async {
    var url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDFtQ5SzXNRmD8mLvDtpHpviEzCF5aGJtA';

    try{
      final response = await http.post(url,body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }));
      final extractedBody = json.decode(response.body);

      if(extractedBody['error'] != null){
        throw HttpException(extractedBody['error']['message']);
      }
      _token = extractedBody['idToken'];
      _expiredDate = DateTime.now().add(Duration(seconds: int.parse(extractedBody['expiresIn'])));
      // print(extractedBody);
    }catch(err){
      throw err;
    }
  }
}