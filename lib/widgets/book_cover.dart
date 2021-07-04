import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/book.dart';
import 'package:judge_a_book_by_its_cover/screens/book_info_screen.dart';

class BookCover extends StatelessWidget {
  final String bookCoverURL;
  final double height;
  final double width;

  BookCover({
    required this.bookCoverURL,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return bookCoverURL == 'images/leaf.png'
        ? Image.asset(
            'images/leaf.png',
            height: height,
            width: width,
          )
        : Image.network(
            bookCoverURL,
            height: height,
            width: width,
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
          );
  }
}
