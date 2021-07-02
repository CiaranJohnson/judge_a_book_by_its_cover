import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/book.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:judge_a_book_by_its_cover/screens/book_info_screen.dart';

class BrowseScreen extends StatefulWidget {
  static const String id = 'browse_screen';

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int _counter = 0;
  List<Book> bookList = [];

  String title = "Title";
  String author = "Author";
  String bookCoverURL =
      "https://firebasestorage.googleapis.com/v0/b/novela-bbd01.appspot.com/o/Library%2FBookCover%2FHarryPotter%2Fchamber_of_secrets.jpg?alt=media&token=08359d7d-31cd-43e3-ac23-d0f42ce691a7";

  @override
  void initState() {
    _makeGetRequest();
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _makeGetRequest() async {
    http.Response response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=adventure&orderBy=newest'));
    final responseBody = json.decode(response.body);
    final List<dynamic> books = responseBody['items'];

    books.forEach((bookInfo) {
      try {
        Book book = Book.fromJson(bookInfo);
        bookList.add(book);
      } on Exception catch (_) {
        print('Failed to create this book');
      }
    });

    updateUI();
  }

  void updateUI() {
    setState(() {
      title = bookList[0].title;
      author = bookList[0].authors[0];
      bookCoverURL = bookList[0].urlLink ?? bookCoverURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Judge a Book'),
        // title: Row(
        //   children: [IconButton(onPressed:), icon: ],
        // ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, BookInfoScreen.id,
                    arguments: bookList[0]);
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
            Text(
              title,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              author,
              style: Theme.of(context).textTheme.headline6,
            ),
            // RawMaterialButton(
            //   onPressed: () {},
            //   fillColor: Colors.white,
            //   child: Icon(
            //     Icons.bookmark_add,
            //     color: Colors.green,
            //     size: MediaQuery.of(context).size.width / 10,
            //   ),
            //   padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
            //   shape: CircleBorder(),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    bookList.removeAt(0);
                    if (bookList.length < 3) {
                      _makeGetRequest();
                    } else {
                      updateUI();
                    }
                  },
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                    size: MediaQuery.of(context).size.width / 10,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 100),
                      primary: Colors.white,
                      side: BorderSide(
                        width: 2.0,
                        color: Colors.red,
                      )),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.bookmark_add,
                    color: Colors.green,
                    size: MediaQuery.of(context).size.width / 10,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 100),
                      primary: Colors.white,
                      side: BorderSide(
                        width: 2.0,
                        color: Colors.green,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
