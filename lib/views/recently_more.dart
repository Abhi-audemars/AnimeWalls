import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo1/models/wallpaper.dart';
import 'package:demo1/services/upload_service.dart';
import 'package:demo1/views/image_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

import '../constants/loader.dart';

class RecentlyUploadedMore extends StatefulWidget {
  const RecentlyUploadedMore({super.key});

  @override
  State<RecentlyUploadedMore> createState() => _RecentlyUploadedMoreState();
}

class _RecentlyUploadedMoreState extends State<RecentlyUploadedMore> {
  List<Wallpaper>? allWallpapers = [];

  frcthAllWallPapers() async {
    allWallpapers = await UploadServices().fetchAllWallpapers(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    frcthAllWallPapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
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
        title: Column(
          children: [
            Text(
              'Recent Wallpapers',
              style: GoogleFonts.oswald(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'All recently uploaded wallpapers',
              style: GoogleFonts.oswald(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: allWallpapers == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.55,
                  crossAxisCount: 2,
                ),
                // crossAxisCount: 3,
                itemCount: allWallpapers!.length,
                itemBuilder: (context, index) {
                  var doc = allWallpapers![index];
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                        bottom: 5,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, ImageView.routeName,
                              arguments: doc.images),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              color: Colors.grey[100],
                            ),
                            imageUrl: doc.images,
                            fit: BoxFit.cover,
                            // height: 350,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
