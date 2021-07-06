import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/booklists.dart';
import 'package:judge_a_book_by_its_cover/screens/browse_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/registration_screen.dart';
import 'package:judge_a_book_by_its_cover/widgets/registration_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final myPasswordController = TextEditingController();
  final myEmailController = TextEditingController();

  String _email = "";
  String _password = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myEmailController.addListener(_getInputText);
    myPasswordController.addListener(_getInputText);
  }

  @override
  void dispose() {
    myEmailController.dispose();
    myPasswordController.dispose();
    super.dispose();
  }

  void _getInputText() {
    _email = myEmailController.text;
    _password = myPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Booklists>(
      builder: (context, booklists, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Image.asset('images/leaf.png'),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      RegistrationTextField(
                        hintText: 'Enter email...',
                        isObscured: false,
                        controller: myEmailController,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RegistrationTextField(
                        controller: myPasswordController,
                        hintText: 'Enter password...',
                        isObscured: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue,
          selectedFontSize: MediaQuery.of(context).size.height / 55,
          unselectedFontSize: MediaQuery.of(context).size.height / 55,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.blue,
              ),
              label: "Back",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.login,
                color: Colors.blue,
              ),
              label: "Login",
            ),
          ],
          onTap: (index) async {
            if (index == 0) {
              print('Back');
              Navigator.pop(context);
            } else if (index == 1) {
              print("Login");
              bool initialisedBrowse = await booklists.initialiseBrowseList();
              if (initialisedBrowse) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrowseScreen(),
                  ),
                );
              } else {
                print('Failed to initialise browse list');
              }
            }
          },
        ),
      ),
    );
  }
}