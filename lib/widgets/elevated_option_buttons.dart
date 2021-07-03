import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * This Wideget has been removed from the app though I have left it here
 * incase I want to add it back in later.
 */

class ElevatedOptionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            // _nextBook();
          },
          child: Icon(
            Icons.close_rounded,
            color: Colors.red,
            size: MediaQuery.of(context).size.width / 10,
          ),
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
              primary: Colors.white,
              side: BorderSide(
                width: 2.0,
                color: Colors.red,
              )),
        ),
        ElevatedButton(
          onPressed: () {
            // _nextBook();
          },
          child: Icon(
            Icons.bookmark_add,
            color: Colors.green,
            size: MediaQuery.of(context).size.width / 10,
          ),
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 100),
              primary: Colors.white,
              side: BorderSide(
                width: 2.0,
                color: Colors.green,
              )),
        ),
      ],
    );
  }
}
