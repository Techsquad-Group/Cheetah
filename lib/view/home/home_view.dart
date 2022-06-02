import 'package:cheeta/view/auth/login_view.dart';
import 'package:cheeta/view/category/men_view.dart';
import 'package:cheeta/view/widgets/custom_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: const Text('Welcome', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          toolbarHeight: 80,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.black),
              onPressed: () {},
            ),
          ],
          //SearchBar
          title: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search',
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
        //Categories
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            CustomCard(
              text: "Electronics",
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => MenView(
                      product: [],
                    ));
              },
              child: CustomCard(
                text: "Men",
              ),
            ),
            CustomCard(
              text: "Women",
            ),
            CustomCard(
              text: "Kids",
            ),
            CustomCard(
              text: "Mobiles",
            ),
          ],
        ),
        //bottom navigation bar
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'More',
            ),
          ],
          currentIndex: 0,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          onTap: (int) {},
        ));
  }
}
