class PhotosModel {
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  SrcModel? src;

  PhotosModel(
      { this.url,
       this.photographer,
       this.photographerId,
       this.photographerUrl,
       this.src});

  factory PhotosModel.fromMap(Map<String, dynamic> parsedJson) {
    return PhotosModel(
        url: parsedJson["url"],
        photographer: parsedJson["photographer"],
        photographerId: parsedJson["photographer_id"],
        photographerUrl: parsedJson["photographer_url"],
        src: SrcModel.fromMap(parsedJson["src"]));
  }
}

class SrcModel {
  String portrait;
  String large;
  String landscape;
  String medium;

  SrcModel({required this.portrait, required this.landscape, required this.large, required this.medium});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        large: srcJson["large"],
        landscape: srcJson["landscape"],
        medium: srcJson["medium"]);
  }
}
