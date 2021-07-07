import 'package:judge_a_book_by_its_cover/constants.dart';

class Book {
  // All variables are final, once they have been set they can't be changed
  final String id;
  final String title;
  final String authors;
  final String categories;
  final String description;
  final String urlLink;

  // Don't do anything with publisher though this could be displayed in the
  // book_info_screen as well
  final String? publisher;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.urlLink,
    required this.description,
    required this.categories,
    this.publisher,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    /**
     * Factory constructor for Book object
     *
     * This constructor creates a book object from the JSON provided by
     * Google Books API: https://developers.google.com/books/docs/v1/using
     *
     * The relevant information is extracted and formatted appropriately for
     * use in the App.
     *
     * :param json (Map<String, dynamic>): the json for the book returned by
     *            Google Books API
     * :param volumeInfo (Map<String, dynamic>): the Books information
     *
     *
     * :param id (String): The Unique ID used to request the book from
     *              Google Books API
     * :param title (String): The title of the Book
     * :param urlLink (String): The best possible picture of the book to
     *              display to the user
     * :param authors (String): The names of the authors correctly formatted
     * :param categories (String): The categories the book belongs too
     * :param description (String): The books description
     * :param publisher (String): The publishers of the book
     *
     * :return (Book): the book object
     */
    // Find the books unique ID
    String id = json["id"];

    // volumeInfo stores all the info relating to book with ID = id
    Map<String, dynamic> volumeInfo = json["volumeInfo"];
    print(volumeInfo);

    // Find the best possible image url to request when showing the book cover
    String urlLink = 'images/leaf.png';
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

    // This function is used to to correctly format Authors & Category strings
    String _formatDynamicListAsString(List<dynamic> dynamicList) {
      String outputString = "";

      // Format the string as Item_1, Item_2, ..., Item_N-1 and Item_N
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

    // Correctly format the list of authors as a single string
    // e.g. Author 1, Author 2, ... and Author N
    String authors = kNotApplicable;
    if (volumeInfo.containsKey("authors")) {
      List<dynamic> authorsDynamicList = volumeInfo["authors"];
      authors = _formatDynamicListAsString(authorsDynamicList);
    }

    // Extract the books Categories from the
    String categories = kNotApplicable;
    if (volumeInfo.containsKey("categories")) {
      // Correctly format the list of categories as a single string
      // e.g. Category 1, Category 2, ... and Category N
      List<dynamic> categoriesDynamicList = volumeInfo["categories"];
      categories = _formatDynamicListAsString(categoriesDynamicList);
    }

    // Extract the book's description if it has one
    String title = volumeInfo["title"] ?? kNotApplicable;
    String description = volumeInfo['description'] ?? kNotApplicable;
    String publisher = volumeInfo["publisher"] ?? kNotApplicable;

    return Book(
        id: id,
        title: title,
        publisher: publisher,
        authors: authors,
        categories: categories,
        description: description,
        urlLink: urlLink);
  }
}
