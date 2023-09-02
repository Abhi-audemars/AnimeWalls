// ignore_for_file: use_build_context_synchronously, unused_element

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo1/constants/error_handle.dart';
import 'package:demo1/constants/loader.dart';
import 'package:demo1/models/random_wallpaer.dart';
import 'package:demo1/views/image_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:neopop/neopop.dart';
import 'package:url_launcher/url_launcher.dart';

String apiKey = 'zT0PHleClpRiCNYWHH8iwciqpHoKjTxrEG2Q0BZSDUiDxlnqmqM5062c';

class OtherWallpapers extends StatefulWidget {
  static const String routeName = '/other-wallpapers';
  const OtherWallpapers({super.key});

  @override
  State<OtherWallpapers> createState() => _OtherWallpapersState();
}

class _OtherWallpapersState extends State<OtherWallpapers> {
  List<PhotosModel>? photos = [];
  int page = 1;
  getWallPaper() async {
    http.Response res = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=80&page=$page"),
        headers: {
          "Authorization": apiKey,
        });

    httpErrorHandle(
        res: res,
        context: context,
        onSuccess: () {
          var jsonData = jsonDecode(res.body);
          jsonData['photos'].forEach((element) {
            photos!.add(PhotosModel.fromMap(element));
          });

          setState(() {
            page++;
          });
        });
  }

  Future<void> refrsh() async {
    photos!.clear();
    await getWallPaper();
  }

  @override
  void initState() {
    super.initState();
    getWallPaper();
  }

  _launchuRL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 26),
          child: NeoPopButton(
            color: Colors.white,
            bottomShadowColor: Colors.grey,
            rightShadowColor: Colors.grey,
            onTapUp: () => Navigator.pop(context),
            border: Border.all(color: Colors.black, width: 2),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
        elevation: 0,
        title: Text(
          'Other Random Wallpapers',
          style: GoogleFonts.oswald(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: photos == null
          ? const Loader()
          : LiquidPullToRefresh(
              animSpeedFactor: 2,
              color: Colors.yellow,
              backgroundColor: Colors.black,
              borderWidth: 1.2,
              height: 60,
              showChildOpacityTransition: false,
              onRefresh: () => refrsh(),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(4),
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    children: photos!.map((PhotosModel wallpaper) {
                      return GridTile(
                          child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ImageView(imageUrl: wallpaper.src!.portrait),
                          ),
                        ),
                        child: Hero(
                            tag: wallpaper.src!.portrait,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: wallpaper.src!.portrait,
                                placeholder: (context, url) => NeoPopShimmer(
                                  shimmerColor: Colors.yellow,
                                  duration: const Duration(microseconds: 1),
                                  child: Container(
                                    color: Colors.grey[100],
                                  ),
                                ),
                                fit: BoxFit.cover,
                              ),
                            )),
                      ));
                    }).toList(),
                  ),
                ),
              ),
            ),
    );
  }
}
