// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:demo1/constants/error_handle.dart';
import 'package:demo1/models/wallpaper.dart';
import 'package:demo1/providers/user_provider.dart';
import 'package:demo1/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Wallpaper>> fetchSearchedProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Wallpaper> wallpaperList = [];
    try {
      
      http.Response res = await http.get(
        Uri.parse('$uri/api/wallpapers/search/$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        res: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            wallpaperList.add(
              Wallpaper.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      // showSnackBar(
      //     context: context,
      //     title: 'Oh Snap!',
      //     tesxt: e.toString(),
      //     contentType: ContentType.failure);
      debugPrint(e.toString());
    }
    return wallpaperList;
  }
}
