import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/screens/wishlist_screen.dart';
import 'package:judge_a_book_by_its_cover/widgets/add_remove_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  static const String id = "search_screen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 8.5 / 10),
        child: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.blueGrey,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Judge a Book',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 17,
                width: MediaQuery.of(context).size.height / 17,
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
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 8.0,
                right: 20.0,
                bottom: 8.0,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 17,
                width: MediaQuery.of(context).size.height / 17,
                child: MaterialButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, SearchScreen.id),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.search,
                    size: 25.0,
                  ),
                  padding: EdgeInsets.all(2.0),
                  shape: CircleBorder(),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
        ),
      ),
      body: Container(
        child: Text(
          'Search Screen',
        ),
      ),
      bottomNavigationBar: AddRemoveNavBar(
        clickable: false,
      ),
    );
  }
}
