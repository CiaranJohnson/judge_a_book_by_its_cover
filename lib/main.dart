import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/screens/book_info_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/browse_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/login_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/registration_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/search_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/sign_up_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/wishlist_book_info_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/wishlist_screen.dart';
import 'package:provider/provider.dart';

import 'components/booklists.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Booklists(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Judge a Book',
      initialRoute: RegistrationScreen.id,
      routes: {
        RegistrationScreen.id: (context) => RegistrationScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        BrowseScreen.id: (context) => BrowseScreen(),
        BookInfoScreen.id: (context) => BookInfoScreen(),
        WishlistScreen.id: (context) => WishlistScreen(),
        WishlistBookInfoScreen.id: (context) => WishlistBookInfoScreen(),
        SearchScreen.id: (context) => SearchScreen(),
      },
    );
  }
}
