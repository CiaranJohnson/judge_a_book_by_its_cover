import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  static const String id = "wishlist_screen";
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Wishlist'),
      ),
      body: Container(
        child: Text('Wishlist Screen'),
      ),
    );
  }
}
