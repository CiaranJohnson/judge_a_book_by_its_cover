import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:judge_a_book_by_its_cover/components/booklists.dart';
import 'package:judge_a_book_by_its_cover/constants.dart';

import 'package:judge_a_book_by_its_cover/screens/book_info_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/search_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/wishlist_screen.dart';
import 'package:judge_a_book_by_its_cover/widgets/add_remove_nav_bar.dart';
import 'package:judge_a_book_by_its_cover/widgets/book_cover.dart';
import 'package:judge_a_book_by_its_cover/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';

class BrowseScreen extends StatefulWidget {
  static const String id = 'browse_screen';

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  String searchCategory = "adventure";

  @override
  void initState() {
    if (Provider.of<Booklists>(context, listen: false)
            .currentBrowseList
            .length ==
        0) {
      Provider.of<Booklists>(context, listen: false)
          .changeSearchCategory(searchCategory);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Booklists>(
      builder: (context, booklists, child) => Scaffold(
        appBar: MyAppBar(
          leadingWidget: Image.asset('images/leaf.png'),
          searchFunction: () => Navigator.pushNamed(context, SearchScreen.id),
          wishlistFunction: () =>
              Navigator.pushNamed(context, WishlistScreen.id),
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
                  onTap: () => Navigator.pushNamed(context, BookInfoScreen.id),
                  child: BookCover(
                    bookCoverURL: booklists.currentBook.urlLink,
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
                  booklists.currentBook.title,
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
                  "$kBy ${booklists.currentBook.authors}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20.0, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AddRemoveNavBar(
          clickable: true,
        ),
      ),
    );
  }
}
