import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/booklists.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AddRemoveNavBar extends StatelessWidget {
  final bool clickable;
  late final Color _addColor;
  late final Color _removeColor;

  AddRemoveNavBar({required this.clickable}) {
    _addColor = clickable ? Colors.green : Colors.grey;
    _removeColor = clickable ? Colors.red : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Booklists>(
      builder: (context, booklists, child) => BottomNavigationBar(
        selectedItemColor: _removeColor,
        unselectedItemColor: _addColor,
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
          if (clickable) {
            if (index == 0) {
              print('Not interested in ${booklists.currentBook.title}');
              booklists.browseNextBook();
              // _nextBook();
            } else if (index == 1) {
              booklists.addBookToWishlist(booklists.currentBook);
              print('${booklists.currentBook.title} add to wishlist!');
              booklists.browseNextBook();
              // _nextBook();
            }
          }
        },
      ),
    );
  }
}
