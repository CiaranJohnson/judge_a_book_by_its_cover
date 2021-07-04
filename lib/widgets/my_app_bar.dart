import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/screens/search_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/wishlist_screen.dart';

import '../constants.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leadingWidget;
  final VoidCallback searchFunction;
  final VoidCallback wishlistFunction;
  MyAppBar({
    required this.leadingWidget,
    required this.searchFunction,
    required this.wishlistFunction,
  });

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: leadingWidget,
      title: Text(
        kAppBarTitle,
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
              onPressed: wishlistFunction,
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
              onPressed: searchFunction,
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
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(58);
}
