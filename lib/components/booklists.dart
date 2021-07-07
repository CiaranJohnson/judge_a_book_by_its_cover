import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'book.dart';

// This class handles all of the booklists and requesting data from the API
// This class should be refactored to booklist and backend/api_handler
class Booklists extends ChangeNotifier {
  final Set<Book> _wishlist = <Book>{};
  List<Book> _currentBrowseList = <Book>[];

  // Add a default book as I don't want it to be nullable
  Book _wishlistBook = Book(
      id: kNotApplicable,
      title: 'No Wishlist Book Found',
      authors: 'Try Adding a different book',
      urlLink: 'images/leaf.png',
      description: kNotApplicable,
      categories: kNotApplicable);

  // Search information
  String _currentSearchCategory = "Cooking";
  String _refinedSearchQuery = "";

  int _index = -10;

  // Getter functions
  UnmodifiableListView<Book> get wishlist => UnmodifiableListView(_wishlist);
  UnmodifiableListView<Book> get currentBrowseList =>
      UnmodifiableListView(_currentBrowseList);

  String get currentSearchCategory => _currentSearchCategory;

  // If there is no book in the browse list, generate a book that hints the
  // User to try a new search
  Book get currentBook => _currentBrowseList.length > 0
      ? _currentBrowseList[0]
      : Book(
          id: kNotApplicable,
          title: 'No Results, Try Search',
          authors: 'Clicking the Search Button',
          urlLink: 'images/leaf.png',
          description: kNotApplicable,
          categories: kNotApplicable);

  Book get getWishlistBook => _wishlistBook;

  void setWishlistBook(Book book) => _wishlistBook = book;

  void browseNextBook() async {
    /**
     * Get the next book in the Browse List
     *
     * Remove the current book (book at index 0) being displayed to the user
     * from the Browse List, therefore there is a new current book (book at
     * index 0 of Browse List).
     *
     * If there is less than 4 books in the Browse List request more books
     * from Google Books API.
     *
     * :param _currentBrowseList (List<Book>): list of all the books currently
     *              in the Browse List.
     * :param booksFound (Bool): if new Books were added to the Browse List from
     *              the request
     */

    _currentBrowseList.removeAt(0);
    // If there are less than four books in the browse list request new books
    // from the API
    if (_currentBrowseList.length < 4) {
      bool booksFound = await _updateBrowseList();
    }
    notifyListeners();
  }

  void addBookToBrowseList(Book book) {
    /**
     * Adds the book to the Browse List
     *
     * Checks to see if the Browse List contains the book and then adds
     * the book to the Browse List if it is not already in it.
     *
     * :param book (Book): the book to be added to the wishlist
     * :param _currentBrowseList (List<Book>): list of all the books currently
     *              in the Browse List.
     */

    if (!_currentBrowseList.contains(book)) {
      _currentBrowseList.add(book);
      notifyListeners();
    }
  }

  void addBookToWishlist(Book book) {
    /**
     * Adds the book to the Wishlist
     *
     * Checks to see if the wishlist contains the book and then adds
     * the book to the wishlist if it is not already in it.
     *
     * :param book (Book): the book to be addded to the wishlist
     * :param _wishlist (List<Book>): list of all the books in the user's
     *                      wishlist
     */

    if (!_wishlist.contains(book)) {
      _wishlist.add(book);
      notifyListeners();
    }
  }

  void removeBookFromWishlist(Book book) {
    /**
     * Removes the book from the Wishlist
     *
     * Checks to see if the wishlist contains the book and then removes
     * the book from the wishlist if it is present.
     *
     * :param book (Book): the book to be removed from the wishlist
     * :param _wishlist (List<Book>): list of all the books in the user's
     *                      wishlist
     *
     * [Note] - this function is not used in the app currently
     */

    if (_wishlist.contains(book)) {
      _wishlist.remove(book);
      notifyListeners();
    }
  }

  Future<bool> initialiseBrowseList() async {
    /**
     * Initialises the Browse List
     *
     * This function is called once when the user Logs/Signs in and there are
     * no Books in the Browse List.
     *
     * :return (Future<bool>): if books where successfully added to the
     *                      Browse List
     */

    return await _updateBrowseList();
  }

  Future<bool> newSearch(String category, String searchQuery) async {
    /**
     * Change the search parameters
     *
     * Function that changes the search parameters used to request books from
     * Google Books API.
     *
     * :param category (String): this is the new users selected
     *                    option must be one of the kCategoryTypes found in the
     *                    constants.dart file
     * :param searchQuery (String): terms inputted by the user to
     *                    refine their search
     * :param _currentBrowseList  (List<Book>): list of all the books currently
     *              in the Browse List.
     *
     * :return (Future<bool>): whether there were books found during the new
     *                  search
     */

    _changeSearchCategory(category);
    _refinedSearchText(searchQuery);

    _currentBrowseList = [];
    bool booksFound = await _updateBrowseList();
    if (booksFound) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void _changeSearchCategory(String category) {
    /**
     * Update search category
     *
     * Function used to update the category if it has been changed
     *
     * :param _index (int): used to request the next books from the API
     * :param _currentSearchCategory (String): this is the users selected
     *                    option from the kCategoryTypes found in the
     *                    constants.dart file
     *
     *
     * [Note] - This function should be moved to backend/api_handler.dart
     */

    if (kCategoryTypes.contains(category) &&
        "subject:$category" != _currentSearchCategory) {
      _currentSearchCategory = "subject:$category";
    }
    _index = -10;
  }

  void _refinedSearchText(String searchQuery) {
    /**
     * Formatting the User's input search text
     *
     * In order to search Google Books API using terms, text must be formatted
     * as lowercase and words seperated by +
     *      E.g. harry+potter+books+
     * :param _index (int): used to request the next books from the API
     * :param _refinedSearchQuery (String): terms inputted by the user to
     *                    refine their search
     *
     * [Note] - this function should be moved to backend/api_handler.dart
     */

    // Simplistic approach as doesn't handle edge cases such as contractions
    List<String> queryList = searchQuery.toLowerCase().split(RegExp(r'\W+'));

    // Append + to each individual word
    _refinedSearchQuery = "";
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

  Future<bool> _updateBrowseList() async {
    /**
     * Updates the Browse List
     *
     * This function requests data from Google Books API using the set
     * category and provided terms used to refine the search.
     *
     * The API returns the 10 most relevant books to these search conditions.
     * More can be found at: https://developers.google.com/books/docs/v1/using
     *
     * :param _index (int): used to request the next books from the API
     * :param _refinedSearchQuery (String): terms inputted by the user to
     *                    refine their search
     * :param _currentSearchCategory (String): this is the users selected
     *                    option from the kCategoryTypes found in the
     *                    constants.dart file
     *
     * :return (bool): indicate whether new books have been successfully added
     *                  to the Browse List.
     *
     * [Note] - this function should be moved to backend/api_handler.dart
     */

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
      return false;
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
              addBookToBrowseList(book);
            }
          } on Exception catch (_) {
            print('Failed to create this book');
          }
        });
      } else {
        print("No items found during search");
        return false;
      }
    }
    return true;
  }
}
