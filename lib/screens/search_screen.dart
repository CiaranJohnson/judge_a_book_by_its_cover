import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:judge_a_book_by_its_cover/components/booklists.dart';
import 'package:judge_a_book_by_its_cover/components/search_parameters.dart';
import 'package:judge_a_book_by_its_cover/screens/browse_screen.dart';
import 'package:judge_a_book_by_its_cover/screens/wishlist_screen.dart';
import 'package:judge_a_book_by_its_cover/widgets/add_remove_nav_bar.dart';
import 'package:judge_a_book_by_its_cover/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SearchScreen extends StatefulWidget {
  static const String id = "search_screen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  String categoryValue = "Adventure";
  String searchQuery = "";

  @override
  void initState() {
    _controller.addListener(_getInputText);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getInputText() {
    searchQuery = _controller.text;
  }

  void performSearch(Booklists booklists) async {
    bool booksFound = await booklists.newSearch(
      categoryValue,
      searchQuery,
    );
    Navigator.pushNamed(context, BrowseScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Booklists>(
      builder: (context, booklists, child) => Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 8.5 / 10),
          child: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.blueGrey,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
                    onPressed: () =>
                        Navigator.pushNamed(context, WishlistScreen.id),
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
                    onPressed: () => performSearch(booklists),
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
            flexibleSpace: Container(
              padding: EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                top: 100.0,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      kSearchByCategories,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButton<String>(
                      value: categoryValue,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 25,
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 20.0,
                      ),
                      underline: Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blue,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          categoryValue = newValue!;
                        });
                      },
                      items: kCategoryTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Divider(
                    height: 20.0,
                    thickness: 1.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      kRefineSearch,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: kEnterTextHere,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () => performSearch(booklists),
                    child: Text(
                      'Search',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: AddRemoveNavBar(
          clickable: false,
        ),
      ),
    );
  }
}
