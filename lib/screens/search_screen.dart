import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/screens/wishlist_screen.dart';
import 'package:judge_a_book_by_its_cover/widgets/add_remove_nav_bar.dart';
import 'package:judge_a_book_by_its_cover/widgets/my_app_bar.dart';

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
        child: MyAppBar(
          leadingWidget: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.blueGrey,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          wishlistFunction: () =>
              Navigator.pushNamed(context, WishlistScreen.id),
          searchFunction: () => print('Searching...'),
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
