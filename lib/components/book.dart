class Book {
  final String id;
  final String title;
  final String authors;

  String? publisher;
  String categories;
  String description;
  String urlLink;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.urlLink,
    required this.description,
    required this.categories,
    this.publisher,
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

    String _formatDynamicListAsString(List<dynamic> dynamicList) {
      String outputString = "";
      for (int i = 0; i < dynamicList.length; i++) {
        if (i == 0) {
          outputString = dynamicList[0].toString();
        } else if (i > 0 && i < (dynamicList.length - 1)) {
          outputString += ", ${dynamicList[i].toString()}";
        } else if (i == (dynamicList.length - 1)) {
          outputString += " and ${dynamicList[i].toString()}";
        }
      }
      return outputString;
    }

    List<dynamic> authorsDynamicList = volumeInfo["authors"];
    String authors = _formatDynamicListAsString(authorsDynamicList);

    String categories = "NA";
    if (volumeInfo.containsKey("categories")) {
      List<dynamic> categoriesDynamicList = volumeInfo["categories"];
      categories = _formatDynamicListAsString(categoriesDynamicList);
    }

    String description = volumeInfo['description'] ?? "NA";

    return Book(
        id: id,
        title: volumeInfo["title"],
        publisher: volumeInfo["publisher"],
        authors: authors,
        categories: categories,
        description: description,
        urlLink: urlLink);
  }
}
