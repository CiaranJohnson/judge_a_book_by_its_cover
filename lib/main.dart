import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/book.dart';
import 'package:judge_a_book_by_its_cover/screens/book_info_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/browse_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/wishlist_screen.dart';
import 'package:provider/provider.dart';

import 'components/wishlist.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Wishlist(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: BrowseScreen.id,
      routes: {
        BrowseScreen.id: (context) => BrowseScreen(),
        BookInfoScreen.id: (context) => BookInfoScreen(),
        WishlistScreen.id: (context) => WishlistScreen(),
      },
    );
  }
}
