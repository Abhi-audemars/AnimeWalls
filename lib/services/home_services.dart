// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:demo1/constants/error_handle.dart';
import 'package:demo1/utils/utils.dart';
import 'package:demo1/models/wallpaper.dart';
import 'package:demo1/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Wallpaper>> fetchCategoryWallpapers({
    required BuildContext context,
    required String category,
  }) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Wallpaper> categoryWallpaperList = [];

    try {
     http.Response res = await http.get(
        Uri.parse('$uri/api/wallpapers?category=$category'),
      );

      httpErrorHandle(
        res: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            categoryWallpaperList.add(
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
      debugPrint(e.toString());
      showSnackBar(context: context, tesxt:e.toString(),title: 'Oh Snap!',contentType: ContentType.failure);
    }
    return categoryWallpaperList;
  }
}
