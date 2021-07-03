import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/book.dart';

import 'package:http/http.dart' as http;
import 'package:judge_a_book_by_its_cover/components/wishlist.dart';
import 'package:judge_a_book_by_its_cover/constants.dart';
import 'dart:convert';

import 'package:judge_a_book_by_its_cover/screens/book_info_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/wishlist_screen.dart';
import 'package:judge_a_book_by_its_cover/widgets/book_cover.dart';
import 'package:provider/provider.dart';

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
  String bookCoverURL = 'images/leaf.png';

  String searchCategory = "adventure";

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
        'https://www.googleapis.com/books/v1/volumes?q=$searchCategory+subject&orderBy=newest'));
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

    _updateUI();
  }

  void _updateUI() {
    setState(() {
      title = bookList[0].title;
      author = bookList[0].authors;
      bookCoverURL = bookList[0].urlLink;
    });
  }

  void _nextBook() {
    bookList.removeAt(0);
    if (bookList.length < 3) {
      _makeGetRequest();
    } else {
      _updateUI();
    }
  }

  void _optionSelected(int index) {
    if (index == 0) {
      print('Not interested in $title');
      _nextBook();
    } else if (index == 1) {
      print('$title add to wishlist!');
      _nextBook();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Wishlist(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Image.asset('images/leaf.png'),
          title: Text(
            kAppBarTitle,
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () =>
                    Navigator.pushNamed(context, WishlistScreen.id),
                color: Colors.blue,
                textColor: Colors.white,
                child: Icon(
                  Icons.bookmark,
                  size: 30.0,
                ),
                padding: EdgeInsets.all(2.0),
                shape: CircleBorder(),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      BookInfoScreen.id,
                      arguments: bookList[0],
                    );
                  },
                  onPanUpdate: (details) {
                    if (details.delta.dx > 0) {
                      _nextBook();
                    } else if (details.delta.dx < 0) {
                      _nextBook();
                    }
                  },
                  child: BookCover(
                    bookCoverURL: bookCoverURL,
                    height: (MediaQuery.of(context).size.height * 5) / 10,
                    width: (MediaQuery.of(context).size.width * 7) / 10,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "$kBy $author",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20.0, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.green,
          selectedFontSize: MediaQuery.of(context).size.height / 55,
          unselectedFontSize: MediaQuery.of(context).size.height / 55,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.close_rounded,
                color: Colors.red,
              ),
              label: kRemove,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark_add,
                color: Colors.green,
              ),
              label: kAdd,
            ),
          ],
          onTap: _optionSelected,
        ),
      ),
    );
  }
}
