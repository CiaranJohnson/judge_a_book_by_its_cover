import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/book.dart';
import 'package:judge_a_book_by_its_cover/screens/book_info_screen.dart';

class BookCover extends StatefulWidget {
  Book book;
  BookCover({
    required this.book,
  });

  @override
  _BookCoverState createState() => _BookCoverState();
}

class _BookCoverState extends State<BookCover> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          BookInfoScreen.id,
          arguments: widget.book,
        );
      },
      child: widget.book.urlLink != null
          ? Image.network(
              widget.book.urlLink!,
              height: (MediaQuery.of(context).size.height * 6) / 10,
              width: (MediaQuery.of(context).size.width * 9) / 10,
              fit: BoxFit.fill,
              loadingBuilder: (context, child, progress) {
                return progress == null
                    ? child
                    : LinearProgressIndicator(
                        value: (progress.cumulativeBytesLoaded.toDouble() /
                            progress.expectedTotalBytes!.toDouble()),
                        backgroundColor: Colors.grey,
                      );
              },
            )
          : Image.asset('images/leaf.png'),
    );
  }
}
