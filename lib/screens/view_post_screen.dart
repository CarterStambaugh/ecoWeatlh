import 'package:flash_chat/screens/feed_screen.dart';
import 'package:flutter/material.dart';
//Screens
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/utilities/animated_page_route.dart';
import 'package:flash_chat/screens/map_screen.dart';
import 'package:flash_chat/screens/newPost/upload_post_screen.dart';
import 'package:flash_chat/screens/notification_screen.dart';
import 'package:flash_chat/screens/account_screen.dart';
//Components
import 'package:flash_chat/components/comment_button.dart';
import 'package:flash_chat/components/post_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



/*
//import 'package:flash_chat/screens/login_screen.dart'

class ViewPostScreen extends StatefulWidget {
  //final String post;
//  final PostView postView;

 // ViewPostScreen({this.post, this.postView});

  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  //PostView postView;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Widget _buildComment(int index) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
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
                height: 50.0,
                width: 50.0,
                image: AssetImage(comments[index].authorImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(
          comments[index].authorName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(comments[index].text),
        trailing: IconButton(
          icon: Icon(
            Icons.favorite_border,
          ),
          color: Colors.grey,
          onPressed: () => print('Like comment'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            Navigator.pushNamed(context, HomeScreen.id);
          });
        },
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
          child: Text(''),
        ),
      ),
    );
  }
}

/*
Scaffold(
      backgroundColor: Color(0xffE8F2FB),
      // backgroundColor: Colors.red,

      body: Scaffold(
        //backgroundColor: Colors.red,
        backgroundColor: Color(0xffE8F2FB),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xffE8F2FB),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: double.infinity,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Container(
                          padding: EdgeInsets.only(top: 30.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: ListTile(
                                            leading: Container(
                                              width: 50.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black45,
                                                    // color: Colors.lightBlueAccent,
                                                    offset: Offset(0, 2),
                                                    blurRadius: 6.0,
                                                  ),
                                                ],
                                              ),
                                              child: CircleAvatar(
                                                child: ClipOval(
                                                  child: Image(
                                                    height: 50.0,
                                                    width: 50.0,
                                                    image: AssetImage(widget
                                                        .post.authorImageUrl),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              widget.post.authorName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(widget.post.timeAgo),
                                            trailing: IconButton(
                                              icon: Icon(Icons.more_horiz),
                                              color: Colors.black,
                                              onPressed: () => print('More'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onDoubleTap: () => print('Like post'),
                                      child: Container(
                                        margin: EdgeInsets.all(10.0),
                                        width: double.infinity,
                                        height: 300.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black45,
                                              //  color: Colors.lightBlueAccent,
                                              offset: Offset(0, 0),
                                              blurRadius: 1.0,
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: AssetImage(
                                                widget.post.imageUrl),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons.favorite_border),
                                                    iconSize: 30.0,
                                                    onPressed: () =>
                                                        print('Like post'),
                                                  ),
                                                  Text(
                                                    '2,515',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 20.0),
                                              Row(
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Icon(Icons.chat),
                                                    iconSize: 30.0,
                                                    onPressed: () {
                                                      print('Chat');
                                                    },
                                                  ),
                                                  Text(
                                                    '350',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.bookmark_border),
                                            iconSize: 30.0,
                                            onPressed: () => print('Save post'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10.0),
                                width: double.infinity,
                                //height: 600.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    _buildComment(0),
                                    _buildComment(1),
                                    _buildComment(2),
                                    _buildComment(3),
                                    _buildComment(4),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                              icon: Icon(
                  Icons.home,
                  size: 20.0,
                  color: Colors.grey,
                ),
                onPressed: (){
                    Navigator.pushNamed(context, HomeScreen.id);
                },
              ),
              title: Text(''),
            
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                              icon: Icon(
                  Icons.map,
                  size: 20.0,
                  color: Colors.grey,
                ),
                onPressed: (){

                },
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.lightBlueAccent,
                  onPressed: () => print('Upload photo'),
                  child: Icon(
                    Icons.add,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(
                  Icons.message,
                  size: 20.0,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(
                  Icons.person_outline,
                  size: 20.0,
                  color: Colors.grey,
                ),
                onPressed: () {
                   Navigator.pushNamed(context, AccountScreen.id);
                },
              ),
              title: Text(''),
            ),
          ],
        ),
      ),
    );
*/
*/