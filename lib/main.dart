import 'package:flutter/material.dart';
import 'package:flash_chat/screens/authentication/welcome_screen.dart';
import 'package:flash_chat/screens/authentication/login_screen.dart';
import 'package:flash_chat/screens/authentication/registration_screen.dart';
//import 'package:flash_chat/screens/authentication/chat_screen.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/screens/account_screen.dart';
import 'package:flash_chat/screens/map_screen.dart';
import 'package:flash_chat/screens/feed_screen.dart';
import 'package:flash_chat/screens/notification_screen.dart';
import 'package:flash_chat/screens/newPost/upload_post_screen.dart';
import 'package:flash_chat/screens/newPost/upload_post_preview.dart';
import 'package:provider/provider.dart';
import 'package:flash_chat/utilities/global_data.dart';
import 'package:flash_chat/screens/messages_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GlobalData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          initialRoute: WelcomeScreen.id,
          routes: {
            WelcomeScreen.id: (context) => WelcomeScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            RegistrationScreen.id: (context) => RegistrationScreen(),

            ChatScreen.id: (context) => ChatScreen(),
            MessageScreen.id: (context) => MessageScreen(),
            //
            HomeScreen.id: (context) => HomeScreen(),
            //
            FeedScreen.id: (context) => FeedScreen(),
            MapScreen.id: (context) => MapScreen(),
            UploadPostScreen.id: (context) => UploadPostScreen(),
            UploadPostPreview.id: (context) => UploadPostPreview(),
            NotificationScreen.id: (context) => NotificationScreen(),
            AccountScreen.id: (context) => AccountScreen(),
          }),
    );
  }
}
