import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:judge_a_book_by_its_cover/components/book_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Book> bookList = [];

  String title = "Title";
  String author = "Author";
  String bookCoverURL =
      "https://firebasestorage.googleapis.com/v0/b/novela-bbd01.appspot.com/o/Library%2FBookCover%2FHarryPotter%2Fchamber_of_secrets.jpg?alt=media&token=08359d7d-31cd-43e3-ac23-d0f42ce691a7";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void makeGetRequest() async {
    http.Response response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=flowers&orderBy=newest'));
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
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(bookCoverURL),
            Text(
              title,
            ),
            Text(
              author,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: makeGetRequest,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
