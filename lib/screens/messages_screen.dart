import 'package:flutter/material.dart';
import 'package:flash_chat/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class MessageScreen extends StatefulWidget {
  static const String id = 'message_screen';
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title:  Text('Messages',textAlign: TextAlign.left,
       ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                  Icons.message,
               color:Colors.white,
              ),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],

        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Slidable(
              actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: ConversationsStream(),
            ),
          ],
        ),
      ),
    );
  }
}

class ConversationsStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final users = snapshot.data.documents.reversed;


        List<Conversations> conversations = [];
        for (var user in users) {
          print(user.data['username']);
          if (user.data['username'] == loggedInUser.email) {
            print("here");
            final otherUsers = user.data['peopleChattedWith'];
            for (var otherUser in otherUsers) {
              final newConversation = Conversations(name: otherUser);
              conversations.add(newConversation);
            }
          }
        }

        return Expanded(
         child: ListView(
           reverse: false,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: conversations,
          ),
        );
      },
    );
  }
}

class Conversations extends StatelessWidget {
  Conversations({this.name});

  final String name;

  //
 // String mystring = 'Hello World';

  //print('${mystring[0]}');



  @override
  Widget build(BuildContext context) {
    String initial;
    initial = name[0];
    return
      GestureDetector(
        onTap: (){
          Navigator.push(context,  MaterialPageRoute( builder: (context) => ChatScreen(otherUser: name)));
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.lightBlueAccent,
            child: Text(initial,

            style: TextStyle(color: Colors.white,
              fontSize: 20,

              fontWeight: FontWeight.bold,

            ),),

          ),
          title: Text(name),


    ),
      );
  }
}


      /*

      GestureDetector(
      onTap: (){

        Navigator.push(context,  MaterialPageRoute( builder: (context) => ChatScreen(otherUser: name)
        ),
        );},

      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment:
           CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              elevation: 5.0,
              color:  Colors.lightBlueAccent,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
