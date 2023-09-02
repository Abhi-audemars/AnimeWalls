import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Wallpaper {
  final String uploadedBy;
  final String description;
  final String images;
  final String category;
  final String? id;
  final SrcModel? src;
  Wallpaper({
    required this.uploadedBy,
    required this.description,
    required this.images,
    required this.category,
    this.id,
    this.src,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uploadedBy': uploadedBy,
      'description': description,
      'images': images,
      'category': category,
      'id': id,
    };
  }

  factory Wallpaper.fromMap(Map<String, dynamic> map) {
    return Wallpaper(
      uploadedBy: map['uploadedBy'] as String,
      description: map['description'] as String,
      images: map['images'] as String,
      category: map['category'] as String,
      id: map['id'] != null ? map['id'] as String : null,
      src: map['src'] != null ? SrcModel.fromMap(map['src'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallpaper.fromJson(String source) =>
      Wallpaper.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SrcModel {
  String portrait;
  String large;
  String landscape;
  String medium;

  SrcModel(
      {required this.portrait,
      required this.landscape,
      required this.large,
      required this.medium});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        large: srcJson["large"],
        landscape: srcJson["landscape"],
        medium: srcJson["medium"]);
  }
}
