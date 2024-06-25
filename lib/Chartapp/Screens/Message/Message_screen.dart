import 'package:demo/Chartapp/Screens/Message/Contactinfo/Contactinfo_screen.dart';
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
        title: Text(widget.username,style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blueGrey.shade100,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.call),
                SizedBox(width: 20,),
                Icon(Icons.video_call),
              ],
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: (){
             // Navigator.push(context, MaterialPageRoute(builder: (context) => ContactinfoScreen()));
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              backgroundImage: NetworkImage(widget.userImage),),
          ),
        ),

      ),
     bottomSheet: GestureDetector(
       onTap: () {

       },
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
                   width: double.infinity, // Ensures the TextField takes up all available width
                   decoration: BoxDecoration(
                     color: Colors.grey.shade600,
                     borderRadius: BorderRadius.circular(5),
                   ),
                   child: TextField(
                     maxLengthEnforcement: MaxLengthEnforcement.none,
                     decoration: InputDecoration(
                       suffixIcon: Icon(Icons.photo, color: Colors.white, size: 20),
                       enabledBorder: InputBorder.none,
                       focusedBorder: InputBorder.none,
                       hintText: 'Enter here',
                       hintStyle: TextStyle(color: Colors.white),
                       contentPadding: EdgeInsets.symmetric(horizontal: 10),
                     ),
                     cursorColor: Colors.white,
                     style: TextStyle(color: Colors.white),
                     textAlign: TextAlign.left,
                     minLines: 1, // Minimum number of lines the TextField should occupy
                     maxLines: null, // Maximum number of lines, null for unlimited
                     onChanged: (value) {
                       setState(() {
                         _isTyping = value.isNotEmpty;
                       });
                     },
                   ),
                 ),

               ),
               _isTyping
                   ? Icon(Icons.send, color: Colors.white, size: 30) // Send icon when typing
                   : Row(
                 children: [
                   Icon(Icons.camera_alt, color: Colors.white, size: 30),
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
}