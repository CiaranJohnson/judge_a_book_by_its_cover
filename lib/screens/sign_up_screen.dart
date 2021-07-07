import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/backend/email_password_checker.dart';
import 'package:judge_a_book_by_its_cover/components/booklists.dart';
import 'package:judge_a_book_by_its_cover/constants.dart';
import 'package:judge_a_book_by_its_cover/screens/browse_screen.dart';
import 'package:judge_a_book_by_its_cover/widgets/registration_text_field.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "sign_up_screen";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // This class is very similar to LoginScreen and therefore should be
  // refactored into a widget shared by the two.

  final myPasswordController = TextEditingController();
  final myEmailController = TextEditingController();

  String _email = "";
  String _password = "";

  Color emailErrorColor = Colors.white;
  Color passwordErrorColor = Colors.white;

  @override
  void initState() {
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
                  flex: 2,
                  child: Image.asset('images/leaf.png'),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      RegistrationTextField(
                        hintText: kEnterEmail,
                        isObscured: false,
                        controller: myEmailController,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RegistrationTextField(
                        hintText: kEnterPassword,
                        isObscured: true,
                        controller: myPasswordController,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: Text(
                          kValidEmailError,
                          style: TextStyle(
                            color: emailErrorColor,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          kValidPasswordError,
                          style: TextStyle(
                            color: passwordErrorColor,
                          ),
                        ),
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
              label: kBack,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_add_alt_1,
                color: Colors.blue,
              ),
              label: kSignUp,
            ),
          ],
          onTap: (index) async {
            if (index == 0) {
              print('Back');
              Navigator.pop(context);
            } else if (index == 1) {
              print("Sign Up");

              EmailPasswordChecker emailPasswordChecker =
                  EmailPasswordChecker(email: _email, password: _password);

              if (emailPasswordChecker.checkUserEmail() &&
                  emailPasswordChecker.checkPasswordLength()) {
                print('USER: $_email and $_password passed the checks');

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
              } else if (emailPasswordChecker.checkUserEmail()) {
                print('USER: Password did not pass the test');
                setState(() {
                  emailErrorColor = Colors.white;
                  passwordErrorColor = Colors.red;
                });
              } else if (emailPasswordChecker.checkPasswordLength()) {
                print('USER: Email did not pass the test');
                setState(() {
                  emailErrorColor = Colors.red;
                  passwordErrorColor = Colors.white;
                });
              } else {
                print('USER: Email and password did not pass the test');
                setState(() {
                  emailErrorColor = Colors.red;
                  passwordErrorColor = Colors.red;
                });
              }
            }
          },
        ),
      ),
    );
  }
}
