import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/booklists.dart';
import 'package:judge_a_book_by_its_cover/screens/browse_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _updateCalled = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Booklists>(
      builder: (context, booklists, child) {
        if (booklists.currentBrowseList.length > 0) {
          // Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BrowseScreen(),
            ),
          );
        } else if (!_updateCalled) {
          _updateCalled = true;
          booklists.newSearch("adventure", "");
        }

        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Judge A Book',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 10,
                  ),
                ),
                Text(
                  "By it's Cover",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 15,
                  ),
                ),
              ],
            )),
          ),
        );
      },
    );
  }
}
