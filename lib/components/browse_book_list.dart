import 'dart:collection';

import 'package:flutter/material.dart';

import 'book.dart';

// This might not work as I want to be able to view the books in the wishlist
// Before adding new books to the list

class BrowseBookList extends ChangeNotifier {
  final Set<Book> _browseBookList = <Book>{};

  UnmodifiableListView<Book> get browseBookList =>
      UnmodifiableListView(_browseBookList);

  void addBook(Book book) {
    if (!_browseBookList.contains(book)) {
      _browseBookList.add(book);
      notifyListeners();
    }
  }

  void removeBook(Book book) {
    if (_browseBookList.contains(book)) {
      _browseBookList.remove(book);
    }
  }
}
