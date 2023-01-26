class Category {
  static String sportsId = "sports";
  static String moviesId = "movies";
  static String musicId = "music";
  String id;
  late String name;
  late String image;

  Category(this.id, this.name, this.image);
  Category.fromId(this.id){
    name = id;
    image = "assets/images/$id.jpeg";
  }
  static List<Category> getCategories() {
    return [
      Category.fromId(sportsId),
      Category.fromId(musicId),
      Category.fromId(moviesId),
    ];
  }
}


