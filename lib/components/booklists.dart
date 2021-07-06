import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'book.dart';

class Booklists extends ChangeNotifier {
  final Set<Book> _wishlist = <Book>{};
  final Set<Book> _reviewedBooks = <Book>{};
  List<Book> _currentBrowseList = <Book>[];

  int _index = -10;
  String _currentSearchCategory = "adventure";
  String _refinedSearchQuery = "";

  UnmodifiableListView<Book> get wishlist => UnmodifiableListView(_wishlist);
  UnmodifiableListView<Book> get reviewedList =>
      UnmodifiableListView(_reviewedBooks);
  UnmodifiableListView<Book> get currentBrowseList =>
      UnmodifiableListView(_currentBrowseList);

  String get currentSearchCategory => _currentSearchCategory;

  Book get currentBook => _currentBrowseList.length > 0
      ? _currentBrowseList[0]
      : Book(
          id: 'N/A',
          title: 'No Results, Try Search',
          authors: 'Clicking the Search Button',
          urlLink: 'images/leaf.png',
          description: 'N/A',
          categories: 'N/A');

  void browseNextBook() async {
    _currentBrowseList.removeAt(0);
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

  void addBookToBrowseList(Book book) {
    if (!_currentBrowseList.contains(book)) {
      _currentBrowseList.add(book);
      notifyListeners();
    }
  }

  void addBookToReviewed(Book book) {
    if (!_reviewedBooks.contains(book)) {
      _reviewedBooks.add(book);
      notifyListeners();
    }
  }

  void addBookToWishlist(Book book) {
    if (!_wishlist.contains(book)) {
      _wishlist.add(book);
      notifyListeners();
    }
  }

  void removeBookFromWishlist(Book book) {
    if (_wishlist.contains(book)) {
      _wishlist.remove(book);
      notifyListeners();
    }
  }

  Future<bool> initialiseBrowseList() async {
    return await _updateBrowseList();
  }

  void newSearch(String category, String searchQuery) async {
    _changeSearchCategory(category);
    _refinedSearchText(searchQuery);
    _currentBrowseList = [];
    bool booksFound = await _updateBrowseList();
    if (booksFound) {
      notifyListeners();
    }
  }

  void _changeSearchCategory(String category) {
    if (kCategoryTypes.contains(category) &&
        category != _currentSearchCategory) {
      if (category == "N/A") {
        _currentSearchCategory = "";
      } else {
        _currentSearchCategory = "subject:$category";
      }
      _index = -10;
    }
  }

  void _refinedSearchText(String searchQuery) {
    List<String> queryList = searchQuery.split(RegExp(r'\W+'));
    _refinedSearchQuery = "";
    queryList.forEach((element) {
      if (element.length > 0) {
        _refinedSearchQuery += "$element+";
      }
    });
    print("Refining text: $_refinedSearchQuery");
    if (_refinedSearchQuery.length > 0) {
      _index = -10;
    }
  }

  Future<bool> _updateBrowseList() async {
    _index += 10;
    String searchString =
        'https://www.googleapis.com/books/v1/volumes?q=$_refinedSearchQuery$_currentSearchCategory&startIndex=${_index.toString()}&orderBy=relevance';
    print(searchString);
    http.Response response = await http.get(Uri.parse(searchString));
    if (response.statusCode != 200) {
      print('Status Code: ${response.statusCode}');
      return false;
    } else {
      final responseBody = json.decode(response.body);
      if (responseBody.containsKey('items')) {
        final List<dynamic> books = responseBody['items'];

        books.forEach((bookInfo) {
          try {
            if (bookInfo != null) {
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
