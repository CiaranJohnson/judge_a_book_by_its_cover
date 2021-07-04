import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/book.dart';
import 'package:judge_a_book_by_its_cover/components/booklists.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  static const String id = "wishlist_screen";
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Booklists>(
      builder: (context, booklists, child) => Scaffold(
        appBar: AppBar(
          title: Text('Your Wishlist'),
        ),
        body: Container(
          child: Text(booklists.currentBook.title),
        ),
      ),
    );
  }
}
