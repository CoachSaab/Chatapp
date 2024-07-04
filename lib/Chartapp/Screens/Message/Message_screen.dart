import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';


class Message_Screen extends StatefulWidget {

  final String chatRoomId;
  final Map<String, dynamic> userMap;

  Message_Screen({required this.chatRoomId, required this.userMap});

  @override
  State<Message_Screen> createState() => _Message_ScreenState();
}

class _Message_ScreenState extends State<Message_Screen> {

  bool _isBottomSheetExpanded = false;
  bool _isTyping = false;
  ScrollController _scrollController = ScrollController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        // Handle the selected image
        print('Image picked: ${pickedFile.path}');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future uploadImage() async{

    String fileName = Uuid().v1();
    var ref  = FirebaseStorage.instance.ref().child('image').child('$fileName.jpg');
    var uploadTask = await ref.putFile(imageFile!);

    String ImageUrl = await uploadTask.ref.getDownloadURL() as String;
  }



  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream:  _firestore.collection('users').doc(widget.userMap['uid']).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.data != null){
              return Container(
                child: Column(
                  children: [
                    Text(widget.userMap['name']),
                    Text(snapshot.data?['status'],style: TextStyle(color: Colors.grey.shade500,fontSize: 15),),
                  ],
                ),
              );
            }else{
              return Container();
            }
          },
        ),
        backgroundColor: Colors.blueGrey.shade100,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.call),
                SizedBox(width: 20),
                Icon(Icons.video_call),
              ],
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              backgroundImage: NetworkImage(''),
            ),
          ),
        ),
      ),


      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.8,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('chatroom')
                      .doc(widget.chatRoomId)
                      .collection('chats')
                      .orderBy('time', descending: false)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: snapshot.data?.docs.length ?? 0,
                        itemBuilder: (context, index) {
                          Map<String, dynamic>? map = snapshot.data?.docs[index].data() as Map<String, dynamic>?;
                          if (map != null) {
                            return messages(MediaQuery.of(context).size, map);
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),




        bottomSheet: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 100,
          width: 430,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: _message,
                      maxLengthEnforcement: MaxLengthEnforcement.none,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Enter here',
                        hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                      minLines: 1,
                      maxLines: null,
                      onChanged: (value) {
                        setState(() {
                          _isTyping = value.isNotEmpty;
                        });
                      },
                    ),
                  ),
                ),
                _isTyping
                    ? IconButton(
                  icon: Icon(Icons.send, color: Colors.white, size: 30),
                  onPressed: () {
                    onSendMessage();
                  },
                )
                    : Row(
                  children: [
                    InkWell(
                      onTap: () {
                        CustomImagePicker();
                      },
                      child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
                    ),
                    Icon(Icons.mic, color: Colors.white, size: 30),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget messages(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment: map['sendby'] == _auth.currentUser?.displayName
          ? Alignment.topRight
          : Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: map['sendby'] == _auth.currentUser?.displayName
              ?Colors.blueGrey.shade500
              : Colors.white,
        ),
        child: Text(
          map['message'],
          style: TextStyle(
            color: map['sendby'] == _auth.currentUser?.displayName
                ? Colors.grey.shade300
                : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void CustomImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }



}

