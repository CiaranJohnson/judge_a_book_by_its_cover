import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/book.dart';

class BookInfoScreen extends StatefulWidget {
  static const String id = "book_info_screen";

  @override
  _BookInfoScreenState createState() => _BookInfoScreenState();
}

class _BookInfoScreenState extends State<BookInfoScreen> {
  String bookCoverURL =
      "https://firebasestorage.googleapis.com/v0/b/novela-bbd01.appspot.com/o/Library%2FBookCover%2FHarryPotter%2Fchamber_of_secrets.jpg?alt=media&token=08359d7d-31cd-43e3-ac23-d0f42ce691a7";

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)!.settings.arguments as Book;

    return Scaffold(
      appBar: AppBar(
        title: Text('Judge a Book'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, BookInfoScreen.id);
              },
              child: Image.network(
                bookCoverURL,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
