// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:demo1/models/random_wallpaer.dart';
import 'package:demo1/views/other_wallpapers.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class OtherWalls {
  Future<List<PhotosModel>> getWallPaper(int page, BuildContext context) async {
    http.Response res = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=80&page=$page"),
        headers: {
          "Authorization": apiKey,
        });

    if (res.statusCode == 200) {
      final jsonData = jsonDecode(res.body);
      return List<PhotosModel>.from(jsonData['photos']
          .map((image) => PhotosModel(url: image['src']['medium'])));
    } else {
      throw Exception('Failed to load images');
    }
  }
}
