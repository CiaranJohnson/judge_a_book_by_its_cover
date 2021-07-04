import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/book.dart';
import 'package:judge_a_book_by_its_cover/components/booklists.dart';
import 'package:judge_a_book_by_its_cover/screens/browse_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/wishlist_screen.dart';
import 'package:judge_a_book_by_its_cover/widgets/book_cover.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class BookInfoScreen extends StatefulWidget {
  static const String id = "book_info_screen";

  @override
  _BookInfoScreenState createState() => _BookInfoScreenState();
}

class _BookInfoScreenState extends State<BookInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Booklists>(
      builder: (context, booklists, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blueGrey,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
        body: Scrollbar(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        BookCover(
                          bookCoverURL: booklists.currentBook.urlLink,
                          height: (MediaQuery.of(context).size.height * 2) / 10,
                          width:
                              (MediaQuery.of(context).size.height * 1.5) / 10,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 6 / 10,
                          height: MediaQuery.of(context).size.height * 2 / 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: kTitleColon,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: booklists.currentBook.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: kAuthorColon,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: booklists.currentBook.authors,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RichText(
                      text: TextSpan(
                        text: kCategoriesColon,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: booklists.currentBook.categories,
                              style: TextStyle(fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: RichText(
                      text: TextSpan(
                        text: kDescriptionColon,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: booklists.currentBook.description,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
          onTap: (index) {
            if (index == 0) {
              print('Not interested in ${booklists.currentBook.title}');
              booklists.browseNextBook();
            } else if (index == 1) {
              booklists.addBookToWishlist(booklists.currentBook);
              print('${booklists.currentBook.title} add to wishlist!');
              booklists.browseNextBook();
            }
          },
        ),
      ),
    );
  }
}
