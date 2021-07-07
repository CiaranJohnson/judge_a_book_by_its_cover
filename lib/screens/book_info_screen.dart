import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:judge_a_book_by_its_cover/components/booklists.dart';

import 'package:judge_a_book_by_its_cover/widgets/book_info_scaffold.dart';
import 'package:provider/provider.dart';

class BookInfoScreen extends StatefulWidget {
  static const String id = "book_info_screen";

  @override
  _BookInfoScreenState createState() => _BookInfoScreenState();
}

class _BookInfoScreenState extends State<BookInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Booklists>(
      builder: (context, booklists, child) => BookInfoScaffold(
        book: booklists.currentBook,
        isClickable: true,
      ),
    );
  }
}
