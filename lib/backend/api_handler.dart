import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:judge_a_book_by_its_cover/components/book.dart';

import '../constants.dart';

// [NOTE] - This class was not incorporated, the corresponding functions that
// are used in the app can be found in booklists.dart. Though it should be
// refactored to here

class ApiHandler {
  // Search information
  String _currentSearchCategory = "adventure";
  String _refinedSearchQuery = "";

  int _index = -10;

  String get currentSearchCategory => _currentSearchCategory;

  // Function used to update the category if it has been changed
  void changeSearchCategory(String category) {
    if (kCategoryTypes.contains(category) &&
        "subject:$category" != _currentSearchCategory) {
      _currentSearchCategory = "subject:$category";
    }
    _index = -10;
  }

  // Text must be formatted as lowercase and words seperated by +
  // E.g. harry+potter+books+
  void refinedSearchText(String searchQuery) {
    // Simplistic approach as doesn't handle edge cases such as contractions
    List<String> queryList = searchQuery.toLowerCase().split(RegExp(r'\W+'));
    _refinedSearchQuery = "";

    // Append + to each individual word
    queryList.forEach((element) {
      if (element.length > 0) {
        _refinedSearchQuery += "$element+";
      }
    });

    // If they haven't changed the category and no text do not reset the index
    if (_refinedSearchQuery.length > 0) {
      _index = -10;
    }
  }

  Future<List<Book>> updateBrowseList() async {
    List<Book> bookList = [];
    // increase the index by 10 as the default number of books returned is 10
    _index += 10;

    // format the request URL using categories and search terms
    String searchString =
        'https://www.googleapis.com/books/v1/volumes?q=$_refinedSearchQuery$_currentSearchCategory&startIndex=${_index.toString()}&orderBy=relevance';
    print(searchString);

    // Make request to Google Books and wait for the response
    http.Response response = await http.get(Uri.parse(searchString));

    // If the Status Code is not 200, the request was unsuccessful
    if (response.statusCode != 200) {
      print('Status Code: ${response.statusCode}');
      return bookList;
    } else {
      // If the Status code is 200 get the response body
      final responseBody = json.decode(response.body);

      // Ensure that the response contains items (Books)
      if (responseBody.containsKey('items')) {
        final List<dynamic> books = responseBody['items'];

        // For all the books returned from the API
        books.forEach((bookInfo) {
          try {
            if (bookInfo != null) {
              // Create book object and add it to the BrowseList
              Book book = Book.fromJson(bookInfo);
              bookList.add(book);
            }
            // bookList.add(book);
          } on Exception catch (_) {
            print('Failed to create this book');
          }
        });
      } else {
        print("No items found during search");
        return bookList;
      }
    }
    return bookList;
  }
}
