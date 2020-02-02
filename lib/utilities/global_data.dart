import 'package:flutter/foundation.dart';
import 'package:flash_chat/components/post_model.dart';
import 'package:flash_chat/screens/feed_screen.dart';
import 'package:flash_chat/screens/newPost/upload_post_screen.dart';

import 'package:flash_chat/utilities/post.dart';

class GlobalData extends ChangeNotifier {
  List<Post> posts = [
    Post(
        authorName: 'Sam Martin',
        authorImageUrl: 'assets/images/user0.png',
        timeAgo: '5 min',
        imageList: 'assets/images/post0.jpg'),
    Post(
        authorName: 'Sam Martin',
        authorImageUrl: 'assets/images/user0.png',
        timeAgo: '10 min',
        imageList: 'assets/images/post0.jpg'),
  ];

  List<String> stories = [
    'assets/images/user1.png',
    'assets/images/user2.png',
    'assets/images/user3.png',
    'assets/images/user4.png',
    'assets/images/user0.png',
    'assets/images/user1.png',
    'assets/images/user2.png',
    'assets/images/user3.png',
  ];

 String url;

    List<Post1> _posts = [
    
  ];

    void addPost(String newTaskTitle) {
    final task = Post1(title: newTaskTitle);
    _posts.add(task);
    notifyListeners();
  }

  List<Form> _form = [
    Form(title: ''),
    Form(location: ''),
    Form(duration: 1),
    Form(price: 10),
    Form(description: ''),
  ];

  void addTask(String title) {
    final form = Form(title: title);
    _form.add(form);
    notifyListeners();
  }
}

class Form {
  final String title;
  final String location;
  final int duration;
  final int price;
  final String description;

  Form(
      {this.title, this.location, this.duration, this.price, this.description});
}
