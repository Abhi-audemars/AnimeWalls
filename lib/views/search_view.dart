import 'package:demo1/models/wallpaper.dart';
import 'package:demo1/services/search_service.dart';
import 'package:demo1/views/image_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/neopop.dart';

class SearchView extends StatefulWidget {
  static const String routeName = '/search-view';
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<Wallpaper>? wallpapers;
  final SearchServices searchServices = SearchServices();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  fetchSearchedWallpaper(String query) async {
    wallpapers = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: query);

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  // void navigateToSearchScreen(String query) {
  //   Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 100,
          centerTitle: false,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
          title: Container(
            height: 42,
            margin: const EdgeInsets.only(left: 15),
            child: Material(
              borderRadius: BorderRadius.circular(7),
              elevation: 1,
              child: TextFormField(
                controller: searchController,
                onFieldSubmitted: (value) {
                  if (value == '') {
                    wallpapers!.clear();
                    // return;
                  }
                  fetchSearchedWallpaper(value);
                },
                decoration: InputDecoration(
                  prefixIcon: InkWell(
                    onTap: () {
                      fetchSearchedWallpaper(searchController.text);
                      setState(() {});
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 6,
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 23,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.purple.shade100,
                  contentPadding: const EdgeInsets.only(top: 10),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black38,
                      width: 1,
                    ),
                  ),
                  hintText: 'Search wallpapers',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
      body: wallpapers == null || wallpapers!.isEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Lottie.asset('assets/sea.json', height: 400),
                  ),
                  const Text(
                    'Search results will appear here!',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.55,
                  crossAxisCount: 2,
                ),
                // crossAxisCount: 3,
                itemCount: wallpapers!.length,
                itemBuilder: (context, index) {
                  var doc = wallpapers![index];
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                        bottom: 5,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, ImageView.routeName,
                              arguments: doc.images),
                          child: Image.network(
                            doc.images,
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
