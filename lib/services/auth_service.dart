// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:demo1/constants/error_handle.dart';
import 'package:demo1/utils/utils.dart';
import 'package:demo1/models/user.dart';
import 'package:demo1/providers/user_provider.dart';
import 'package:demo1/utils/zdrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

String uri = 'https://animewallsbackend.onrender.com';

class AuthService {
  //sign up process

  void signUpUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        token: '',
        type: '',
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context: context,
                tesxt: 'Login with same credentials',
                title: 'Account created!',
                contentType: ContentType.success);
          });
    } catch (e) {
      showSnackBar(
          context: context,
          tesxt: e.toString(),
          title: 'Oh Snap!!',
          contentType: ContentType.failure);
    }
  }

  void signinUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          res: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ZDrawer()),
                (route) => false);
          });
    } catch (e) {
      showSnackBar(
          context: context,
          tesxt: e.toString(),
          title: 'Oh Snap!',
          contentType: ContentType.failure);
    }
  }

  void grtUserData({required BuildContext context}) async {
    try {
      SharedPreferences pres = await SharedPreferences.getInstance();
      String? token = pres.getString('x-auth-token');

      if (token == null) {
        pres.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes =
            await http.get(Uri.parse('$uri/'), headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      //  showSnackBar(context: context, tesxt: e.toString());
      debugPrint(e.toString());
    }
  }
}
