// ignore_for_file: use_build_context_synchronously, unused_element

import 'dart:io';
import 'dart:ui';
import 'package:demo1/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/neopop.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class ImageView extends StatefulWidget {
  static const String routeName = '/imageView';
  final String imageUrl;
  const ImageView({super.key, required this.imageUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  // var filePath;

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  _save() async {
    askPermission() async {
      if (Platform.isAndroid) {
        await Permission.storage.request().isGranted;
      }
    }

    await askPermission();
    var response = await Dio().get(widget.imageUrl,
        options: Options(responseType: ResponseType.bytes));

    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    showSnackBar(
        context: context,
        tesxt: 'wallpaper will be saved in gallery!',
        title: 'Downloading...',
        contentType: ContentType.success);
    Navigator.pop(context);
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                border: Border.all(color: Colors.yellow),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeoPopButton(
                    color: Colors.transparent,
                    bottomShadowColor: Colors.green,
                    rightShadowColor: Colors.red,
                    onTapUp: () =>
                        setHomeScreenWallPaper(widget.imageUrl, context),
                    border: Border.all(color: Colors.yellow, width: 2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: SizedBox(
                        height: 20,
                        child: Text(
                          'Set as Home Screen wallpaper',
                          style: GoogleFonts.oswald(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  NeoPopButton(
                    color: Colors.transparent,
                    bottomShadowColor: Colors.green,
                    rightShadowColor: Colors.red,
                    onTapUp: () =>
                        setLockScreenWallPaper(widget.imageUrl, context),
                    border: Border.all(color: Colors.yellow, width: 2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: SizedBox(
                        height: 20,
                        child: Text(
                          'Set as Lock Screen wallpaper',
                          style: GoogleFonts.oswald(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  NeoPopButton(
                    color: Colors.transparent,
                    bottomShadowColor: Colors.green,
                    rightShadowColor: Colors.red,
                    onTapUp: () => setBothWallPaper(widget.imageUrl, context),
                    border: Border.all(color: Colors.yellow, width: 2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Center(
                          child: Text(
                            'Set as both',
                            style: GoogleFonts.oswald(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Hero(
            tag: widget.imageUrl,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                placeholder: (context, url) => Container(
                  color: Colors.white,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NeoPopButton(
                color: Colors.transparent,
                bottomShadowColor: Colors.green,
                rightShadowColor: Colors.red,
                onTapUp: () {
                  _save();
                },
                border: Border.all(color: Colors.yellow, width: 2),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: NeoPopShimmer(
                    shimmerColor: Colors.grey,
                    child: SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Download Wallpaper',
                            style: GoogleFonts.oswald(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Lottie.asset('assets/b.json', height: 25, width: 25),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              NeoPopButton(
                color: Colors.transparent,
                bottomShadowColor: Colors.green,
                rightShadowColor: Colors.red,
                onTapUp: () => openBottomSheet(context),
                border: Border.all(color: Colors.yellow, width: 2),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: NeoPopShimmer(
                    shimmerColor: Colors.grey,
                    child: SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Set Wallpaper',
                            style: GoogleFonts.oswald(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.yellow,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          )
        ],
      ),
    );
  }
}
