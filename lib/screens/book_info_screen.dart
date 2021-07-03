import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/book.dart';
import 'package:judge_a_book_by_its_cover/screens/browse_screen.dart';
import 'package:judge_a_book_by_its_cover/widgets/book_cover.dart';

class BookInfoScreen extends StatefulWidget {
  static const String id = "book_info_screen";

  @override
  _BookInfoScreenState createState() => _BookInfoScreenState();
}

class _BookInfoScreenState extends State<BookInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)!.settings.arguments as Book;

    return Scaffold(
      appBar: AppBar(
        title: Text('Judge a Book'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, BrowseScreen.id);
              },
              child: BookCover(
                bookCoverURL: book.urlLink,
                height: (MediaQuery.of(context).size.height * 2) / 10,
                width: (MediaQuery.of(context).size.height * 1.5) / 10,
              ),
            ),
            Text('Title: ${book.title}'),
            Text('Authors: ${book.authors}'),
          ],
        ),
      ),
    );
  }
}
