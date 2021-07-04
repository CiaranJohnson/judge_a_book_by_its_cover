import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'book.dart';

class Booklists extends ChangeNotifier {
  final Set<Book> _wishlist = <Book>{};
  final Set<Book> _reviewedBooks = <Book>{};
  final List<Book> _currentBrowseList = <Book>[];

  int _index = -10;
  String _currentSearchCategory = "N/A";

  UnmodifiableListView<Book> get wishlist => UnmodifiableListView(_wishlist);
  UnmodifiableListView<Book> get reviewedList =>
      UnmodifiableListView(_reviewedBooks);
  UnmodifiableListView<Book> get currentBrowseList =>
      UnmodifiableListView(_currentBrowseList);

  Book get currentBook => _currentBrowseList.length > 0
      ? _currentBrowseList[0]
      : Book(
          id: 'N/A',
          title: 'Title',
          authors: 'Authors',
          urlLink: 'images/leaf.png',
          description: 'N/A',
          categories: 'N/A');

  void browseNextBook() {
    if (_currentBrowseList.length < 4) {
      _updateBrowseList();
    }
    _currentBrowseList.removeAt(0);
    notifyListeners();
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

  void changeSearchCategory(String newSearchCategory) {
    if (newSearchCategory != _currentSearchCategory) {
      _index = -10;
      _currentSearchCategory = newSearchCategory;
      _updateBrowseList();
    }
  }

  void _updateBrowseList() async {
    _index += 10;
    http.Response response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$_currentSearchCategory+subject&startIndex=${_index.toString()}&orderBy=newest'));
    final responseBody = json.decode(response.body);
    final List<dynamic> books = responseBody['items'];

    books.forEach((bookInfo) {
      try {
        Book book = Book.fromJson(bookInfo);
        addBookToBrowseList(book);
        // bookList.add(book);
      } on Exception catch (_) {
        print('Failed to create this book');
      }
    });
  }
}
