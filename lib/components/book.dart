class Book {
  final String id;
  final String title;
  final List<String> authors;

  String? publisher;
  List<dynamic>? categories;
  String? description;
  String? urlLink;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    this.publisher,
    this.categories,
    this.urlLink,
    this.description = "NA",
  });

  String getTitle() {
    return this.title;
  }

  List<dynamic> getAuthors() {
    return this.authors;
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    String id = json["id"];
    Map<String, dynamic> volumeInfo = json["volumeInfo"];

    print(volumeInfo);

    String? urlLink;

    if (volumeInfo.containsKey("imageLinks")) {
      if (volumeInfo["imageLinks"].containsKey("thumbnail")) {
        urlLink = volumeInfo["imageLinks"]["thumbnail"];
      } else if (volumeInfo["imageLinks"].contains("smallThumbnail")) {
        urlLink = volumeInfo["imageLinks"]["smallThumbnail"];
      } else {
        urlLink = null;
      }
    } else {
      urlLink = null;
    }

    List<String> authorsStringType = [];
    List<dynamic> authorsDynamicType = volumeInfo["authors"];
    authorsDynamicType.forEach((author) {
      print(author.toString());
      authorsStringType.add(author.toString());
    });

    print(authorsStringType);

    return Book(
        id: id,
        title: volumeInfo["title"],
        publisher: volumeInfo["publisher"],
        authors: authorsStringType,
        categories: volumeInfo["categories"],
        urlLink: urlLink);
  }
}
