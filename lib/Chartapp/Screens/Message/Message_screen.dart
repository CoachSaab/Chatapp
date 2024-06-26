import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Message_Screen extends StatefulWidget {
  final String username;
  final String userImage;

  Message_Screen({required this.username, required this.userImage});

  @override
  State<Message_Screen> createState() => _Message_ScreenState();
}

class _Message_ScreenState extends State<Message_Screen> {
  bool _isBottomSheetExpanded = false;
  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username, style: TextStyle(color: Colors.black)),
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
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              backgroundImage: NetworkImage(widget.userImage),
            ),
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _isBottomSheetExpanded ? 150 : 85,
          width: 395,
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
                    ? Icon(Icons.send, color: Colors.white, size: 30)
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

                },
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () {

                },
              ),
            ],
          ),
        );
      },
    );
  }



}

