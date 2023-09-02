import 'dart:io';

import 'package:demo1/utils/utils.dart';
import 'package:demo1/services/upload_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadWallpaperView extends StatefulWidget {
  static const String routeName = '/UploadW';
  const UploadWallpaperView({super.key});

  @override
  State<UploadWallpaperView> createState() => _UploadWallpaperViewState();
}

class _UploadWallpaperViewState extends State<UploadWallpaperView> {
  final _uploaderNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _uploaderNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  File? image;
  String decategory = 'Naruto';
  List<String> categories = [
    'Hot of the week',
    'Editors choice',
    'Naruto',
    'One Piece',
    'Dragon Ball Z',
    'Demon Slayer',
    'Jujutsu Kaisen',
    'Chainsaw Man',
    'Aoashi',
    'Tokyo Revengers',
    'SPYxFAMILY',
    'Black Clover',
    'Tokyo Ghoul',
    'One Punch Man',
    'Bleach',
  ];

  void selectImage() async {
    var res = await pickImages(context);
    setState(() {
      image = res;
    });
  }

  final _addWallKey = GlobalKey<FormState>();

  final UploadServices uploadServices = UploadServices();

  void uploadWallpaper() async {
    if (_addWallKey.currentState!.validate() && image != null) {
      uploadServices.uploadWallpaper(
        context: context,
        uploadedBy: _uploaderNameController.text,
        description: _descriptionController.text,
        image: image!,
        category: decategory,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addWallKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                image != null
                    ? Image.file(
                        image!,
                        fit: BoxFit.cover,
                        height: 300,
                      )
                    : GestureDetector(
                        onTap: selectImage,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          child: Container(
                            width: double.infinity,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.folder, size: 40),
                                const SizedBox(height: 15),
                                Text(
                                  'Select wallpaper',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                TextField(
                  controller: _uploaderNameController,
                  decoration: const InputDecoration(
                    hintText: 'Uploaded By',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                TextField(
                  maxLines: 10,
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    onChanged: (String? newVal) {
                      setState(() {
                        decategory = newVal!;
                      });
                    },
                    value: decategory,
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    items: categories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: uploadWallpaper,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 38),
                      backgroundColor: Colors.green[400],
                      side: const BorderSide()),
                  child: Text(
                    'Upload',
                    style: GoogleFonts.oswald(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
