import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo1/constants/categories.dart';
import 'package:demo1/constants/loader.dart';
import 'package:demo1/models/wallpaper.dart';
import 'package:demo1/services/home_services.dart';
import 'package:demo1/services/upload_service.dart';
import 'package:demo1/utils/initial_loading.dart';
import 'package:demo1/views/categorywise_wallpapers.dart';
import 'package:demo1/views/image_view.dart';
import 'package:demo1/views/recently_more.dart';
import 'package:demo1/views/other_wallpapers.dart';
import 'package:demo1/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/neopop.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final _aaa = TextEditingController();

  List<String> images = [
    'https://w0.peakpx.com/wallpaper/844/654/HD-wallpaper-anime-anime-boy-umbrella.jpg',
    'https://w0.peakpx.com/wallpaper/738/298/HD-wallpaper-anime-boy-anime-anime-boy-books-library-reading-sun.jpg',
    'https://w0.peakpx.com/wallpaper/899/731/HD-wallpaper-anime-boys-anime-in-naruto-anime.jpg',
    'https://w0.peakpx.com/wallpaper/13/561/HD-wallpaper-anime-anime-waifu.jpg',
    'https://w0.peakpx.com/wallpaper/773/889/HD-wallpaper-sad-anime-boy-anime-boy-anime-boys-depressed-glitch-lonely-sad-anime-boy-sad-anime-boys.jpg',
  ];
  List<String> naruto = [
    'https://w0.peakpx.com/wallpaper/137/427/HD-wallpaper-minato-namikaze-hokage-anime-naruto-shippuden-naruto-4to-hokage.jpg',
    'https://w0.peakpx.com/wallpaper/948/162/HD-wallpaper-minato-anime-naruto-hokage.jpg',
    'https://w0.peakpx.com/wallpaper/137/462/HD-wallpaper-naruto-neon-black-simple-anime.jpg',
    'https://w0.peakpx.com/wallpaper/186/834/HD-wallpaper-naruto-minato-anime-naruto-shippuden-minato-namikaze-naruto-uzumaki-uzumaki-naruto-amoled-led-black.jpg',
  ];
  final UploadServices uploadServices = UploadServices();
  final HomeServices homeServices = HomeServices();

  List<Wallpaper>? wallpapers;
  List<Wallpaper>? categoryWalls;
  List<Wallpaper>? editorsChoiceWalls;
  List<String>? newLis;
  bool isOpen = false;

  fetchAllwallpapers() async {
    wallpapers = await uploadServices.fetchAllWallpapers(context);
    // print(wallpapers![1].images);
    setState(() {});
  }

  fetchCategoryWallpapers() async {
    categoryWalls = await homeServices.fetchCategoryWallpapers(
        context: context, category: 'Hot of the week');
    setState(() {});
  }

  Future<List<String>> editorsChoiceWallpapers() async {
    final List<String> imageurls = [];

    editorsChoiceWalls = await homeServices.fetchCategoryWallpapers(
        context: context, category: 'Editors choice');
    for (var walls in editorsChoiceWalls!) {
      imageurls.add(walls.images);
    }
    return imageurls;
  }

  List<String> newList = [];
  abc() async {
    newList = await editorsChoiceWallpapers();
    newLis = [...naruto, ...newList];
    setState(() {});
  }

  @override
  void initState() {
    fetchAllwallpapers();
    fetchCategoryWallpapers();
    editorsChoiceWallpapers();
    abc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return wallpapers == null
        ? const InitialLoader()
        : wallpapers!.isEmpty
            ? const Center(
                child: Text(
                  'Good things deseves wait!',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )
            : SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(80),
                    child: AppBar(
                      title: Text(
                        'AnimeWalls',
                        style: GoogleFonts.zcoolKuaiLe(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 13),
                          child: NeoPopButton(
                            color: Colors.purple[100]!,
                            bottomShadowColor: Colors.grey,
                            rightShadowColor: Colors.grey,
                            onTapUp: () => Navigator.pushNamed(
                                context, SearchView.routeName),
                            border: Border.all(
                                color: Colors.purple[100]!, width: 2),
                            child: const Center(
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 13),
                          child: NeoPopButton(
                            color: Colors.purple.shade100,
                            bottomShadowColor: Colors.grey,
                            rightShadowColor: Colors.grey,
                            onTapUp: () {
                              ZoomDrawer.of(context)!.toggle();
                            },
                            border: Border.all(
                                color: Colors.purple.shade100, width: 2),
                            child: const Center(
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 2),
                          Text(
                            'Featured Anime',
                            style: GoogleFonts.oswald(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.purple.shade300,
                                borderRadius: BorderRadius.circular(24)),
                            child: const Categories(),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recently uploaded🔥',
                                style: GoogleFonts.oswald(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RecentlyUploadedMore(),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.purple.shade300,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 7,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ImageView(
                                                imageUrl:
                                                    wallpapers![index].images),
                                          ),
                                        ),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              Container(
                                            color: Colors.grey[100],
                                          ),
                                          imageUrl: wallpapers![index].images,
                                          height: 200,
                                          width: 150,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Hot of the week 🔥',
                                style: GoogleFonts.oswald(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CategoryWiseView(
                                            category: 'Hot of the week'),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.purple.shade300,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          categoryWalls == null || categoryWalls!.isEmpty
                              ? const Loader()
                              : SizedBox(
                                  height: 250,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: categoryWalls!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageView(
                                                          imageUrl:
                                                              categoryWalls![
                                                                      index]
                                                                  .images),
                                                ),
                                              ),
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    Container(
                                                  color: Colors.grey[100],
                                                ),
                                                imageUrl: categoryWalls![index]
                                                    .images,
                                                height: 200,
                                                width: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Editor's choice 🔥",
                                style: GoogleFonts.oswald(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CategoryWiseView(
                                            category: 'Editors choice'),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.purple.shade300,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          newLis == null || newLis!.isEmpty
                              ? const Loader()
                              : SizedBox(
                                  height: 250,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: newLis!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageView(
                                                          imageUrl:
                                                              newLis![index]),
                                                ),
                                              ),
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    Container(
                                                  color: Colors.grey[100],
                                                ),
                                                imageUrl: newLis![index],
                                                height: 200,
                                                width: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                          const SizedBox(height: 20),
                          Container(
                            height: 5,
                            color: Colors.black12,
                          ),
                          const SizedBox(height: 20),
                          AnimatedTextKit(
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'Want more wallpapers ?',
                                textStyle: GoogleFonts.oswald(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                                colors: [
                                  Colors.purple,
                                  Colors.blue,
                                  Colors.yellow,
                                ],
                              ),
                            ],
                            repeatForever: true,
                            // isRepeatingAnimation: true,
                            pause: const Duration(seconds: 0),
                          ),
                          const SizedBox(height: 10),
                          NeoPopButton(
                            color: const Color.fromARGB(255, 57, 52, 52),
                            bottomShadowColor: Colors.green,
                            rightShadowColor: Colors.red,
                            onTapUp: () => Navigator.pushNamed(
                                context, OtherWallpapers.routeName),
                            border: Border.all(color: Colors.yellow, width: 2),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: NeoPopShimmer(
                                shimmerColor: Colors.yellow,
                                child: Text(
                                  'Click here',
                                  style: GoogleFonts.oswald(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              );
  }
}
