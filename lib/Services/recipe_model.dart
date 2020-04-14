class RecipeModel {
  String lable;
  String image;
  String source;
  String url;

  RecipeModel({this.url, this.image, this.lable, this.source});

  factory RecipeModel.fromMap(Map<String, dynamic> parsedJson) {
    return RecipeModel(
      url: parsedJson['url'],
      image: parsedJson['image'],
      source: parsedJson['source'],
      lable: parsedJson['label'],
    );
  }
}
