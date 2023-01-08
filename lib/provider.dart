import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_test/screens/model/contacts_model.dart';
import 'package:technical_test/screens/model/user_model.dart';
import 'dart:io';

import 'package:technical_test/widgets/show_snackbar.dart';

class ProviderClass extends ChangeNotifier {
  var contactList = <dynamic>[];
  String? token;
  String? userName;
  String? userName2;
  String? contactId;

  bool _error = false;
  String _errorMessage = '';

  bool get error => _error;

  String get errorMessage => _errorMessage;

  Future<void> sharedPreferences() async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    userName = await storage.getString('userName');
    notifyListeners();
  }

  late http.Response signUpResponse;

  Future<void> postRegister(Map<String, dynamic> payload) async {
    var url = Uri.parse('https://contact.dace.info/api/users');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };

    try {
      signUpResponse = await http.post(url,
          headers: requestHeaders, body: jsonEncode(payload));
      if (kDebugMode) {
        print('Response status: ${signUpResponse.statusCode}');
      }
      if (kDebugMode) {
        print('Response body: ${signUpResponse.body}');
      }
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
      }
      if (kDebugMode) {
        print(s);
      }
    }

    var signUpResponseDecoded = jsonDecode(signUpResponse.body);
    _errorMessage = signUpResponseDecoded.toString();
    notifyListeners();
    if (kDebugMode) {
      print('Response body 2: $signUpResponseDecoded');
    }
  }

  late http.Response postLoginResponse;

  Future<void> postLogin(Map<String, dynamic> payload) async {
    var url = Uri.parse('https://contact.dace.info/api/auth');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };
    try {
      postLoginResponse = await http.post(url,
          headers: requestHeaders, body: jsonEncode(payload));
      if (kDebugMode) {
        print('Login Response status: ${postLoginResponse.statusCode}');
      }
      if (postLoginResponse.statusCode == 200) {
        var postLoginResponseData = jsonDecode(postLoginResponse.body);
        print('Login Response body: $postLoginResponseData');
        final storage = await SharedPreferences.getInstance();
        //storage.setString('userName', postLoginResponseData['user']['name']);
        storage.setString('token', postLoginResponseData['token']);

      } else {
        _errorMessage = postLoginResponse.body.toString();
      }
      notifyListeners();
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
      }
      if (kDebugMode) {
        print(s);
      }
    }
  }

  // run shared preference before any app that needs token
  late http.Response getResponse;

  Future<void> get() async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'x-auth-token': '$token'
    };
    var url = Uri.parse('https://contact.dace.info/api/auth');
    getResponse = await http.get(url, headers: requestHeaders);
    print('get Response status: ${getResponse.statusCode}');
    if (getResponse.statusCode == 200) {
      try {
        var responsedata = getUserModelFromJson(getResponse.body);
        userName2 = responsedata.name;
        notifyListeners();
        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
      }
    } else {
      _error = true;
      _errorMessage = 'It could be your Internet Connection';
      print(_errorMessage);
    }
  }

  late http.Response getContactResponse;

  Future<void> getContact() async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'x-auth-token': '$token'
    };
    var url = Uri.parse('https://contact.dace.info/api/contact');
    getContactResponse = await http.get(url, headers: requestHeaders);
    print('getcontact Response status: ${getContactResponse.statusCode}');
    if (getContactResponse.statusCode == 200) {
      try {
        final contactResponse = jsonDecode(getContactResponse.body);
        contactList = contactResponse ?? [];
        notifyListeners();

        print('contact response: ${contactResponse}');
        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        print(_errorMessage);
      }
    } else {
      _error = true;
      _errorMessage = 'It could be your Internet Connection';
      print(_errorMessage);
    }
  }

  late http.Response getContactIdResponse;

  Future<void> getContactId(String str) async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'x-auth-token': '$token'
    };
    var url = Uri.parse('https://contact.dace.info/api/contact/$str');
    getContactIdResponse = await http.get(url, headers: requestHeaders);
    print('Response status: ${getContactIdResponse.statusCode}');
    if (getContactIdResponse.statusCode == 200) {
      try {
        var contactResponse = jsonDecode(getContactIdResponse.body);

        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        print(_errorMessage);
      }
    } else {
      _error = true;
      _errorMessage = 'It could be your Internet Connection';
      print(_errorMessage);
    }
  }

  late http.Response addContactResponse;

  Future<void> addContact(Map<String, dynamic> payload) async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();

    var url = Uri.parse('https://contact.dace.info/api/contact');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'x-auth-token': '$token',
    };

    try {
      addContactResponse = await http.post(url,
          headers: requestHeaders, body: jsonEncode(payload));
      if (kDebugMode) {
        print('Response status: ${addContactResponse.statusCode}');
      }
      if (kDebugMode) {
        print('Response body: ${addContactResponse.body}');
      }
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
      }
      if (kDebugMode) {
        print(s);
      }
    }
    var addContactResponseDecoded = jsonDecode(addContactResponse.body);
    print(addContactResponseDecoded);
    getContact();
    notifyListeners();
    if (kDebugMode) {
      print('Response body 2: $addContactResponseDecoded');
    }
  }

  late http.Response patchResponse;

  Future<void> update(String str, Map<String, dynamic> payload) async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'x-auth-token': '$token',
    };
    var url = Uri.parse('https://contact.dace.info/api/contact/$str');
    try {
      patchResponse = await http.patch(url,
          headers: requestHeaders, body: json.encode(payload));
      getContact();
      notifyListeners();
      print('Response status: ${patchResponse.statusCode}');
      notifyListeners();
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  late http.Response deleteResponse;
  Future<void> delete(String str) async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'x-auth-token': '$token',
    };
    var url = Uri.parse('https://contact.dace.info/api/contact/$str');
    var deleteResponse = await http.delete(url, headers: requestHeaders);
    print('Response status: ${deleteResponse.statusCode}');
    print('Response body: ${deleteResponse.body}');
    getContact();
    notifyListeners();
  }
}
