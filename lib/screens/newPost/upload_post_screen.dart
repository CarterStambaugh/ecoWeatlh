import 'dart:io';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/utilities/constants.dart';
import 'package:flash_chat/utilities/global_data.dart';
import 'package:flash_chat/screens/newPost/upload_post_preview.dart';
import 'package:flash_chat/screens/newPost/upload_post_screen.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class UploadPostScreen extends StatefulWidget {
  static const String id = 'upload_post_screen';

  @override
  _UploadPostScreenState createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

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

  File _imageFile;
  bool _uploaded = false;

  String title;
  String location;
  String price;
  String duration;
  String url;
  String description;

  StorageReference _reference =
      FirebaseStorage.instance.ref().child('${DateTime.now()}.jpg');

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _imageFile = image;
    });
  }

  Future uploadImage() async {
    StorageUploadTask uploadTask = _reference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    var downURL = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = downURL.toString();
    print("Download URL : $url");
    setState(() {
      _uploaded = true;
      url = downURL.toString();
    });
  }

  Future downloadImage() async {
    String downloadAddress = await _reference.getDownloadURL();

    setState(() {
      url = downloadAddress;
    });
  }

  void messageStream() async {
    await for (var snapshot in _firestore.collection('user').snapshots()) {
      for (var user in snapshot.documents) {
        print(user.data);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffE8F2FB),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Recents'),
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: Colors.white,
            size: 20.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          _imageFile == null
              ? Container(
                  height: 300,
                )
              : IconButton(
                  icon: Icon(
                    Icons.arrow_right,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    uploadImage();
                    messageTextController.clear();
                    // Navigator.pushNamed(context, UploadPostPreview.id);
                    downloadImage();
                    print('here?');
                    print(url);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadPostPreview(
                                  title: title,
                                  location: location,
                                  description: description,
                                  duration: duration,
                                  price: price,
                                  url: url,
                                )));
                    //Implement send functionality.
                  },
                ),
        ],
      ),
      body: Theme(
        data: new ThemeData(
          primaryColor: Colors.lightBlueAccent,
        ),
        child: ListView(
          children: <Widget>[
            Center(
              child: _imageFile == null
                  ? Container(
                      height: 300.0,
                    )
                  : Image.file(
                      _imageFile,
                      height: 300.0,
                      width: double.infinity,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'title'),
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Location'),
                    onChanged: (value) {
                      location = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'About'),
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Amount'),
                    onChanged: (value) {
                      price = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'duration of task'),
                    onChanged: (value) {
                      duration = value;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FlatButton(
            child: Text('Camera'),
            onPressed: () {
              getImage(true);
            },
          ),
          FlatButton(
            child: Text('Library'),
            onPressed: () {
              getImage(false);
            },
          ),
        ],
      )),
    );
  }
}

/*
_downloadURL == null
                ? Container()
                : Container(child: Image.network(_downloadURL)),
 Navigator.push(
                    //    context,
                    //    MaterialPageRoute(
                      //      builder: (context) => UploadPostPreview()));

*/

/*
  File _imageFile;
  Colors cameraButtonColor;

  Future<void> _PickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Recents'),
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: Colors.white,
            size: 20.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_right,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {

            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: Text(
                'Camera',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                _PickImage(ImageSource.camera);
              },
            ),
            FlatButton(
              child: Text(
                'Library',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                _PickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            if (_imageFile != null) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.file(_imageFile),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          'Crop',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          _cropImage();
                        },
                      ),
                      
                      FlatButton(
                          child: Icon(Icons.refresh),
                          onPressed: () {
                            _clear();
                          }),
                          
                      Uploader(file: _imageFile),
                    ],
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://flash-chat-68014.appspot.com");

  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_uploadTask.isComplete) Text('🎉🎉🎉'),

                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return FlatButton(
        child: Text(
          'Post',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        // icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}
*/
