import 'package:demo1/views/categorywise_wallpapers.dart';
import 'package:demo1/views/home_screen.dart';
import 'package:demo1/views/image_view.dart';
import 'package:demo1/views/other_wallpapers.dart';
import 'package:demo1/views/search_view.dart';
import 'package:demo1/views/signup_view.dart';
import 'package:demo1/views/upload_wallpaper_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginSignupEmail.routeName:
      return MaterialPageRoute(builder: (context) => const LoginSignupEmail());
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
    case UploadWallpaperView.routeName:
      return MaterialPageRoute(
        builder: (_) => const UploadWallpaperView(),
      );
    case CategoryWiseView.routeName:
      var category = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => CategoryWiseView(
          category: category,
        ),
      );
    case OtherWallpapers.routeName:
      return MaterialPageRoute(
        builder: (_) => const OtherWallpapers(),
      );
    case ImageView.routeName:
      var imageUrl = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => ImageView(imageUrl: imageUrl),
      );
    case SearchView.routeName:
      return MaterialPageRoute(
        builder: (_) => const SearchView(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Text('Error page'),
        ),
      );
  }
}
