import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo1/constants/loader.dart';
import 'package:demo1/models/wallpaper.dart';
import 'package:demo1/services/home_services.dart';
import 'package:demo1/views/image_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/neopop.dart';

class CategoryWiseView extends StatefulWidget {
  static const routeName = '/categorywall';
  final String category;
  const CategoryWiseView({super.key, required this.category});

  @override
  State<CategoryWiseView> createState() => _CategoryWiseViewState();
}

class _CategoryWiseViewState extends State<CategoryWiseView> {
  final HomeServices homeServices = HomeServices();

  List<Wallpaper>? wallpaperList = [];

  @override
  void initState() {
    super.initState();
    fetchCategoryWalls();
  }

  fetchCategoryWalls() async {
    wallpaperList = await homeServices.fetchCategoryWallpapers(
        context: context, category: widget.category);
    setState(() {});
  }

  var top = 0.0;
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
              widget.category,
              style: GoogleFonts.oswald(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'All ${widget.category} wallpapers',
              style: GoogleFonts.oswald(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: wallpaperList == null
          ? const Loader()
          : wallpaperList == null
              ? const Loader()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.55,
                      crossAxisCount: 2,
                    ),
                    // crossAxisCount: 3,
                    itemCount: wallpaperList!.length,
                    itemBuilder: (context, index) {
                      var doc = wallpaperList![index];
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
