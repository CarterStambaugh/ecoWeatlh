import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flash_chat/screens/feed_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


ProgressDialog pr;
final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class UploadPostPreview extends StatefulWidget {
  UploadPostPreview(
      {this.title,
      this.location,
      this.price,
      this.duration,
      this.url,
      this.imageFunction,
      this.description});
  final String title;
  final Function imageFunction;
  final String location;
  final String price;
  final String duration;
  final String url;
  final String description;

  static const String id = 'upload_post_preview';

  @override
  _UploadPostPreviewState createState() => _UploadPostPreviewState(this.title,
      this.location, this.url, this.price, this.duration, this.description);
}

class _UploadPostPreviewState extends State<UploadPostPreview> {
  _UploadPostPreviewState(this.title, this.location, this.url, this.price,
      this.duration, this.description);
  String title;
  String location;
  String price;
  String duration;
  String url;
  String description;
  final messageTextController = TextEditingController();
  double percentage = 0.0;
  final _auth = FirebaseAuth.instance;
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

  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(''),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Post',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
//when pressed, store new post into the firebase cloud, then go back to feed screen

              messageTextController.clear();
              _firestore.collection('user').add({
                'title': this.title,
                'taskPrice': this.price,
                'description': this.description,
                'durationOfTask': this.duration,
                'imageURL': this.url,
                'email': loggedInUser.email,
                'location': this.location,
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xffE8F2FB),
            // color: Colors.red,
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              url == null
                  ?   Container()
                  : Container(
                      child: Image.network(
                      url,
                      scale: 1.0,
                    )),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      '${this.title}\n'
                      'User: ${loggedInUser.email}\n'
                      'Location: ${this.location}\n'
                      'Duration of Task: ${this.duration}\n'
                      'Reward Money: ${this.price}\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.00),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '\$ 100.00',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 0),
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      child: FAProgressBar(
                        currentValue: 0,
                        displayText: '\$',
                        progressColor: Colors.lightBlueAccent,
                        borderRadius: 5,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
            // child: Text('${Provder.of}'),
          ),
        ),
      ),
    );
  }
}
