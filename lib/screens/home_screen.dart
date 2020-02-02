import 'package:flutter/material.dart';
//BackEnd
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/post_model.dart';
//Packages
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
//Screens
import 'package:flash_chat/screens/feed_screen.dart';
import 'package:flash_chat/screens/messages_screen.dart';
import 'package:flash_chat/screens/map_screen.dart';
import 'package:flash_chat/screens/newPost/upload_post_screen.dart';
import 'package:flash_chat/screens/notification_screen.dart';
import 'package:flash_chat/screens/account_screen.dart';
//Components
import 'package:flash_chat/utilities/animated_page_route.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  AnimationController animationController;
  Animation animation;
  String messageText;
  int _currentIndex = 0;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();

    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    animationController.forward();

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  final List<Widget> _children = [
    FeedScreen(),
    MapScreen(),
    UploadPostScreen(),
    MessageScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            elevation: 5,
            backgroundColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: onTappedBar,
            selectedItemColor: Colors.lightBlueAccent,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 20.0,
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.map,
                  size: 20.0,
                  //color: Colors.grey,
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Container(
                    height: 35,
                    width: double.infinity,
                    // padding: EdgeInsets.symmetric(vertical: 10.0),
                    decoration: new BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadPostScreen()));
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  size: 20.0,
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                  size: 20.0,
                ),
                title: Text(''),
              ),
            ],
          ),
        ));
  }
}

/*
  ,*/
