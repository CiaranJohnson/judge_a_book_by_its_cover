class Book {
  final String id;
  final String title;
  final String authors;

  String? publisher;
  List<dynamic>? categories;
  String? description;
  String urlLink;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.urlLink,
    this.publisher,
    this.categories,
    this.description = "NA",
  });

  String getTitle() {
    return this.title;
  }

  String getAuthors() {
    return this.authors;
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    String id = json["id"];
    Map<String, dynamic> volumeInfo = json["volumeInfo"];

    print(volumeInfo);

    String urlLink;

    if (volumeInfo.containsKey("imageLinks")) {
      Map<String, dynamic> imageMap = volumeInfo["imageLinks"];
      if (imageMap.containsKey("large")) {
        urlLink = imageMap["large"];
      } else if (imageMap.containsKey("medium")) {
        urlLink = imageMap["medium"];
      } else if (imageMap.containsKey("small")) {
        urlLink = imageMap["small"];
      } else if (imageMap.containsKey("thumbnail")) {
        urlLink = imageMap["thumbnail"];
      } else if (imageMap.containsKey("smallThumbnail")) {
        urlLink = imageMap["smallThumbnail"];
      } else {
        urlLink = 'images/leaf.png';
      }
    } else {
      urlLink = 'images/leaf.png';
    }

    String authors = "";
    List<dynamic> authorsDynamicList = volumeInfo["authors"];
    for (int i = 0; i < authorsDynamicList.length; i++) {
      if (i == 0) {
        authors = authorsDynamicList[0].toString();
      } else if (i > 0 && i < (authorsDynamicList.length - 1)) {
        authors += ", ${authorsDynamicList[i].toString()}";
      } else if (i == (authorsDynamicList.length - 1)) {
        authors += " and ${authorsDynamicList[i].toString()}";
      }
    }
    // authorsDynamicType.forEach((author) {
    //   print(author.toString());
    //   authorsStringType.add(author.toString());
    // });

    // print(authorsStringType);

    return Book(
        id: id,
        title: volumeInfo["title"],
        publisher: volumeInfo["publisher"],
        authors: authors,
        categories: volumeInfo["categories"],
        urlLink: urlLink);
  }
}
