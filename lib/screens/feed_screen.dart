import 'package:flash_chat/components/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
//Screens
import 'dart:io';
import 'package:flash_chat/utilities/animated_page_route.dart';
import 'package:flash_chat/screens/view_post_screen.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

//Components
import 'package:flash_chat/utilities/global_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = Firestore.instance;

enum PostView {
  normal,
  expanded,
}

PostView postView = PostView.normal;

class FeedScreen extends StatefulWidget {
  static const String id = 'account_screen';

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: new IconButton(
            icon: Icon(Icons.view_headline),
            iconSize: 30.0,
            color: Colors.black45,
            onPressed: () => print('IGTV'),
          ),
          actions: <Widget>[
            IconButton(
              icon: Image.asset(
                'assets/images/earth.png',
                width: 25,
                height: 25,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ],
          title: Text(
            'ecoWealth',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
              color: Colors.lightBlueAccent,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /*
                    Container(
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 100.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider.of<GlobalData>(context)
                                      .stories
                                      .length +
                                  1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == 0) {
                                  return SizedBox(width: 10.0);
                                }
                                return Container(
                                  margin: EdgeInsets.all(10.0),
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black45,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    child: ClipOval(
                                      child: Image(
                                        height: 60.0,
                                        width: 60.0,
                                        image: AssetImage(
                                            Provider.of<GlobalData>(context)
                                                .stories[index - 1]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),*/
              PostStream(),
            ],
          ),
        ),
      ),
    );
  }
}

class PostStream extends StatefulWidget {
  @override
  _PostStreamState createState() => _PostStreamState();
}

class _PostStreamState extends State<PostStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final messages = snapshot.data.documents.reversed;
          List<Post2> posts = [];
          for (var message in messages) {
            final user = message.data['email'];
            final title = message.data['title'];
            final taskPrice = message.data['taskPrice'];
            final location = message.data['location'];
            final durationOfTask = message.data['durationOfTask'];
            final downloadURL = message.data['imageURL'];
            final description = message.data['description'];

            final post = Post2(
              user: user,
              location: location,
              description: description,
              durationOfTask: durationOfTask,
              downloadURL: downloadURL,
              title: title,
              taskPrice: taskPrice,
            );
            posts.add(post);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              children: posts,
            ),
          );
        });
  }
}

class Post2 extends StatefulWidget {
  Post2(
      {this.title,
      this.user,
      this.description,
      this.downloadURL,
      this.location,
      this.durationOfTask,
      this.taskPrice});

  final String title;
  final String user;
  final String description;
  final String downloadURL;
  final String location;
  final String durationOfTask;
  final String taskPrice;

  @override
  _Post2State createState() => _Post2State();
}

class _Post2State extends State<Post2> {
  @override
  Widget build(BuildContext context) {
    bool value = false;

    Widget postView(bool value) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: 670.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(widget.user),
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 0),
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        value = true;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 0),
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      child: widget.downloadURL == null
                          ? Container()
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 0),
                                    blurRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Image.network(
                                widget.downloadURL,
                                scale: 1.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Goal: \$100.00',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
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
                        currentValue: 80,
                        displayText: '\$',
                        progressColor: Colors.lightBlueAccent,
                        borderRadius: 5,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //   Text(widget.location),
                      //  (Text(widget.description)),

                      FlatButton.icon(
                        icon: Icon(Icons.people_outline),
                        label: Text('Donate'),
                      ),
                      FlatButton.icon(
                        icon: Icon(Icons.credit_card),
                        label: Text('ecoWealth'),
                      ),
                    ],
                  ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //   Text(widget.location),
                      //  (Text(widget.description)),

                      FlatButton.icon(
                        icon: Icon(Icons.expand_more),
                        label: Text(widget.description),
                      ),
                      FlatButton.icon(
                        icon: Icon(Icons.timer),
                        label: Text(widget.durationOfTask),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //Container(height: 100, color: Colors.red);
  }
}

/*
Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 0),
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.lightBlueAccent,
                       
                        ),
                      ),
                    ), 
                  Container(
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 0),
                            blurRadius: 1.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(
                          downloadURL
                          ),
                          fit: BoxFit.fill,
                        ),
                    
                  ],  ),
                  ),
                
              ),
              */

/*Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: 620.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 0),
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                    //  child: CircleAvatar(
                     //   backgroundColor: Colors.blue,
                     //   child: ClipOval(
                     //     child: Image.network(
                      //     widget.downloadURL,
                      ////     fit: BoxFit.cover,
                      //   ),
                     // //  ),
                     // ),
                    ),
                   // title: Text(
                  //    widget.user,
                  //    style: TextStyle(
                  //      fontWeight: FontWeight.bold,
                  //    ),
                  //  ),
                   // subtitle: Text(widget.location),
                  ),
                  Container(
                    width: double.infinity,
                    height: 400.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 0),
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                     child: downloadURL == null ? Container() : Container(child: Image.network(downloadURL)),
  
                    
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                    child: Column(
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
                            currentValue: 80,
                            displayText: ' \$',
                            progressColor: Colors.lightBlueAccent,
                            borderRadius: 5,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Donate',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20.0),
                            Row(
                              children: <Widget>[],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
onTap: () {
                      setState(() {
                        postView = PostView.expanded;
                      });
                    },
                    */

/*
Widget _buildPost(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: 620.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 0),
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            height: 50.0,
                            width: 50.0,
                            image: AssetImage(
                              //posts[index].authorImageUrl,
                              Provider.of<GlobalData>(context)
                                  .posts[index]
                                  .imageList,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      Provider.of<GlobalData>(context).posts[index].authorName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        Provider.of<GlobalData>(context).posts[index].timeAgo),
                    trailing: IconButton(
                      icon: Icon(Icons.more_horiz),
                      color: Colors.black,
                      onPressed: () => print('More'),
                    ),
                  ),
                  GestureDetector(
                    onDoubleTap: () => print('Like post'),
                    onTap: () {
                      setState(() {
                        postView = PostView.expanded;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 0),
                            blurRadius: 1.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(
                            Provider.of<GlobalData>(context)
                                .posts[index]
                                .imageList,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                    child: Column(
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
                            currentValue: 80,
                            displayText: ' \$',
                            progressColor: Colors.lightBlueAccent,
                            borderRadius: 5,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.attach_money),
                                  iconSize: 17.0,
                                  onPressed: () => print('Like post'),
                                ),
                                Text(
                                  'Donate',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20.0),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.clear),
                                  iconSize: 20.0,
                                  onPressed: () {
                                    setState(() {
                                      postView = PostView.expanded;
                                    });
                                  },
                                ),
                                Text(
                                  '350',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          iconSize: 20.0,
                          onPressed: () => print('Save post'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
*/

/*
 Container(
                      margin: EdgeInsets.symmetric(vertical: 6.00,horizontal: 6.00),
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 0),
                            blurRadius: 1.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(posts[index].imageUrl),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),

*/
