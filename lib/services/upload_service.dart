// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:demo1/constants/error_handle.dart';
import 'package:demo1/services/auth_service.dart';
import 'package:demo1/utils/zdrawer.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:demo1/utils/utils.dart';
import 'package:demo1/models/wallpaper.dart';
import 'package:flutter/material.dart';

class UploadServices {
  void uploadWallpaper({
    required BuildContext context,
    required String uploadedBy,
    required String description,
    required File image,
    required String category,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('dw6j3yq8d', 'flmiqyoi');
      String imageUrl;

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: uploadedBy),
      );
      imageUrl = res.secureUrl;

      Wallpaper wallpaper = Wallpaper(
        uploadedBy: uploadedBy,
        description: description,
        images: imageUrl,
        category: category,
      );

      http.Response httpRes =
          await http.post(Uri.parse('$uri/api/upload-wallpaper'),
              headers: <String, String>{
                'Content-type': 'application/json; charset=UTF-8',
              },
              body: wallpaper.toJson());

      httpErrorHandle(
          res: httpRes,
          context: context,
          onSuccess: () {
            showSnackBar(
                context: context, tesxt: 'Wallpaper uploaded successfully!',title: 'Success!',contentType: ContentType.success);
          Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const ZDrawer()),
                      (route) => false);
          });
    } catch (e) {
      showSnackBar(context: context, tesxt: e.toString(),title: 'Oh Snap!',contentType: ContentType.failure);
    }
  }

  Future<List<Wallpaper>> fetchAllWallpapers(BuildContext context) async {
    List<Wallpaper> wallpapersList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-wallpapers'),
      );

      httpErrorHandle(
          res: res,
          context: context,
          onSuccess: () {
            for (int i = jsonDecode(res.body).length-1; i >= 0; i--) {
              wallpapersList.add(
                Wallpaper.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context: context, tesxt: e.toString(),title: 'Oh Snap!',contentType: ContentType.failure);
    }
    return wallpapersList;
  }
}
