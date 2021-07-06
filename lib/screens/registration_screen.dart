import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/screens/login_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/sign_up_screen.dart';

class RegistrationScreen extends StatelessWidget {
  static const String id = "registration_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/leaf.png"),
            Container(
              child: Text(
                'Judge a Book',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
            ),
            Text(
              "by it's Cover",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ],
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
              Icons.person_add_alt_1,
              color: Colors.blue,
            ),
            label: "Sign Up",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.login,
              color: Colors.blue,
            ),
            label: "Login",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            print('Sign up');
            Navigator.pushNamed(context, SignUpScreen.id);
          } else if (index == 1) {
            print("Login");
            Navigator.pushNamed(context, LoginScreen.id);
          }
        },
      ),
    );
  }
}
