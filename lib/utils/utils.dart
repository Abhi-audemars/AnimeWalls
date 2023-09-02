// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

void showSnackBar({
  required BuildContext context,
  required String tesxt,
  required String title,
  required ContentType contentType,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: title,
        message: tesxt,
        contentType: contentType,
      ),
    ),
  );
}

Future<File?> pickImages(BuildContext context) async {
  // File image;
  try {
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (file != null && file.files.isNotEmpty) {
      File image = File(file.files.first.path!);
      return image;
    }
  } catch (e) {
    showSnackBar(
        context: context,
        tesxt: e.toString(),
        title: 'Oh Snap!',
        contentType: ContentType.failure);
  }
  return null;
}

Future<void> setHomeScreenWallPaper(String url, BuildContext context) async {
  try {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(url);
    var result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    if (result == true) {
      Navigator.pop(context);

      showSnackBar(
          context: context,
          tesxt: 'wallpaper set successfully',
          title: 'Success!',
          contentType: ContentType.success);
    } else {
      showSnackBar(
          context: context,
          tesxt: 'Some error occured!',
          title: 'Oh Snap!',
          contentType: ContentType.failure);
    }
  } on PlatformException catch (e) {
    showSnackBar(
        context: context,
        tesxt: e.toString(),
        title: 'Oh Snap!',
        contentType: ContentType.failure);
  }
}

Future<void> setLockScreenWallPaper(String url, BuildContext context) async {
  try {
    int location = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(url);
    var result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    if (result == true) {
      Navigator.pop(context);

      showSnackBar(
          context: context,
          tesxt: 'wallpaper set successfully',
          title: 'Success!',
          contentType: ContentType.success);
    } else {
      showSnackBar(
          context: context,
          tesxt: 'Some error occured!',
          title: 'Oh Snap!',
          contentType: ContentType.failure);
    }
  } on PlatformException catch (e) {
    showSnackBar(
        context: context,
        tesxt: e.toString(),
        title: 'Oh Snap!',
        contentType: ContentType.failure);
  }
}

Future<void> setBothWallPaper(String url, BuildContext context) async {
  try {
    int location = WallpaperManager.BOTH_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(url);
    var result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    if (result == true) {
      Navigator.pop(context);

      showSnackBar(
          context: context,
          tesxt: 'wallpaper set successfully',
          title: 'Success!',
          contentType: ContentType.success);
    } else {
      showSnackBar(
          context: context,
          tesxt: 'Some error occured!',
          title: 'Oh Snap!',
          contentType: ContentType.failure);
    }
  } on PlatformException catch (e) {
    showSnackBar(
        context: context,
        tesxt: e.toString(),
        title: 'Oh Snap!',
        contentType: ContentType.failure);
  }
}
