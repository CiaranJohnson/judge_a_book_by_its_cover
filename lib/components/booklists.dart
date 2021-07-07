import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'book.dart';

class Booklists extends ChangeNotifier {
  final Set<Book> _wishlist = <Book>{};
  final Set<Book> _reviewedBooks = <Book>{};
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
  String _currentSearchCategory = "adventure";
  String _refinedSearchQuery = "";

  int _index = -10;

  // Getter functions
  UnmodifiableListView<Book> get wishlist => UnmodifiableListView(_wishlist);
  UnmodifiableListView<Book> get reviewedList =>
      UnmodifiableListView(_reviewedBooks);
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

  // Function called when the user requests the next book in the browse list
  void browseNextBook() async {
    _currentBrowseList.removeAt(0);
    // If there are less than four books in the browse list request new books
    // from the API
    if (_currentBrowseList.length < 4) {
      bool booksFound = await _updateBrowseList();
      if (booksFound) {
        notifyListeners();
      }
    } else {
      // Update Browse Lift notifies listeners where as this does not
      notifyListeners();
    }
  }

  // Add book to the Browse list
  void addBookToBrowseList(Book book) {
    if (!_currentBrowseList.contains(book)) {
      _currentBrowseList.add(book);
      notifyListeners();
    }
  }

  // Add book to reviewed list - REVIEWED_LIST not used
  void addBookToReviewed(Book book) {
    if (!_reviewedBooks.contains(book)) {
      _reviewedBooks.add(book);
      notifyListeners();
    }
  }

  // Adds book to Wishlist
  void addBookToWishlist(Book book) {
    if (!_wishlist.contains(book)) {
      _wishlist.add(book);
      notifyListeners();
    }
  }

  // Removes the book from the Wishlist
  void removeBookFromWishlist(Book book) {
    if (_wishlist.contains(book)) {
      _wishlist.remove(book);
      notifyListeners();
    }
  }

  // The function called when initialising the browse list
  Future<bool> initialiseBrowseList() async {
    return await _updateBrowseList();
  }

  // The function called when the user makes a new search
  void newSearch(String category, String searchQuery) async {
    _changeSearchCategory(category);
    _refinedSearchText(searchQuery);
    _currentBrowseList = [];
    bool booksFound = await _updateBrowseList();
    if (booksFound) {
      notifyListeners();
    }
  }

  // Function used to update the category if it has been changed
  void _changeSearchCategory(String category) {
    if (kCategoryTypes.contains(category) &&
        "subject:$category" != _currentSearchCategory) {
      _currentSearchCategory = "subject:$category";
    }
    _index = -10;
  }

  // Text must be formatted as lowercase and words seperated by +
  // E.g. harry+potter+books+
  void _refinedSearchText(String searchQuery) {
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

  Future<bool> _updateBrowseList() async {
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
            // bookList.add(book);
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
