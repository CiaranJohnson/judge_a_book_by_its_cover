import 'dart:collection';

import 'package:flutter/cupertino.dart';

import 'book.dart';

class Wishlist extends ChangeNotifier {
  final Set<Book> _wishlist = <Book>{};

  UnmodifiableListView<Book> get wishlist => UnmodifiableListView(_wishlist);

  void addBook(Book book) {
    if (!_wishlist.contains(book)) {
      _wishlist.add(book);
      notifyListeners();
    }
  }

  void removeBook(Book book) {
    if (_wishlist.contains(book)) {
      _wishlist.remove(book);
    }
  }
}
