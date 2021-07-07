import 'dart:collection';

import 'package:flutter/material.dart';

import 'book.dart';

// [TODO] THIS CLASS IS NO LONGER IMPLEMENTED

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
