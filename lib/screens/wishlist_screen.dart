import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/book.dart';
import 'package:judge_a_book_by_its_cover/components/booklists.dart';
import 'package:judge_a_book_by_its_cover/screens/search_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/wishlist_book_info_screen.dart';
import 'package:judge_a_book_by_its_cover/widgets/book_cover.dart';
import 'package:judge_a_book_by_its_cover/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class WishlistScreen extends StatefulWidget {
  static const String id = "wishlist_screen";
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<ListTile> getWishlistTiles(Booklists booklist) {
    List<Book> wishlist = booklist.wishlist;
    List<ListTile> wishlistTiles = [];
    wishlist.forEach(
      (Book book) {
        wishlistTiles.add(
          ListTile(
            leading: BookCover(
              height: 100,
              width: 50,
              bookCoverURL: book.urlLink,
            ),
            title: Text(
              book.title,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              book.authors,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              booklist.setWishlistBook(book);
              Navigator.pushNamed(
                context,
                WishlistBookInfoScreen.id,
              );
            },
          ),
        );
      },
    );
    return wishlistTiles;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Booklists>(
      builder: (context, booklists, child) => Scaffold(
        appBar: MyAppBar(
          leadingWidget: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.blueGrey,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          wishlistFunction: () => print("Already in Wishlist"),
          searchFunction: () => Navigator.pushNamed(context, SearchScreen.id),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: ListView(
            children: getWishlistTiles(booklists).length > 0
                ? getWishlistTiles(booklists)
                : [
                    Container(
                      padding: EdgeInsets.all(40.0),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: kNoBookWishlist,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                            children: [
                              TextSpan(
                                text: kAdd,
                                style: TextStyle(color: Colors.green),
                              ),
                              WidgetSpan(
                                child: Icon(
                                  Icons.bookmark_add,
                                  color: Colors.green,
                                ),
                              ),
                              TextSpan(
                                text: kAddToWishlist,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
