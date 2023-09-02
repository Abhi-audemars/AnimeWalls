import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:demo1/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response res,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(
          context: context,
          tesxt: jsonDecode(res.body)['msg'],
          title: 'Oh Snap!',
          contentType: ContentType.failure);
      break;
    case 500:
      showSnackBar(
          context: context,
          tesxt: jsonDecode(res.body)['err'],
          title: 'Oh Snap!',
          contentType: ContentType.failure);
      break;
    default:
      showSnackBar(
          context: context,
          tesxt: jsonDecode(res.body)['err'],
          title: 'Oh Snap!',
          contentType: ContentType.failure);
  }
}
