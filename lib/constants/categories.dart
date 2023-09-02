import 'package:demo1/constants/global_varialble.dart';
import 'package:demo1/views/categorywise_wallpapers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  void navigatetoCategory(String category) {
    Navigator.pushNamed(
      context,
      CategoryWiseView.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: GlobalVariables.categoryImages.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => navigatetoCategory(
                  GlobalVariables.categoryImages[index]['title']!),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple[100],
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          GlobalVariables.categoryImages[index]['image']!,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 8),
                        child: Text(
                          GlobalVariables.categoryImages[index]['title']!,
                          style: GoogleFonts.zcoolKuaiLe(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
