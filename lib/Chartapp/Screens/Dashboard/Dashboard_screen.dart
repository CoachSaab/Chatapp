import 'package:demo/Chartapp/Screens/Dashboard/Userinfo/Userinfo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Message/Message_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<User> users = [
    User(username: 'user1', description: 'This is user 1', img: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
    User(username: 'user2', description: 'This is user 2', img: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHVzZXJ8ZW58MHx8MHx8fDA%3D'),
    User(username: 'user3', description: 'This is user 3', img: 'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fHVzZXJ8ZW58MHx8MHx8fDA%3D'),
    User(username: 'user4', description: 'This is user 4', img: 'https://images.unsplash.com/photo-1619895862022-09114b41f16f?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHVzZXJ8ZW58MHx8MHx8fDA%3D'),
    User(username: 'user5', description: 'This is user 5', img: 'https://images.unsplash.com/flagged/photo-1573740144655-bbb6e88fb18a?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
    User(username: 'user6', description: 'This is user 6', img: 'https://plus.unsplash.com/premium_photo-1669882305273-674eff6567af?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
    User(username: 'user7', description: 'This is user 7', img: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
    User(username: 'user8', description: 'This is user 8', img: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
    User(username: 'user9', description: 'This is user 9', img: 'https://images.unsplash.com/photo-1546961329-78bef0414d7c?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHVzZXJ8ZW58MHx8MHx8fDA%3D'),
    User(username: 'user10', description: 'This is user 10', img: 'https://images.unsplash.com/photo-1484863137850-59afcfe05386?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHVzZXJ8ZW58MHx8MHx8fDA%3D'),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.grey.shade200,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => UserinfoScreen()));
            }, child: Icon(Icons.person)),
          )
        ],

      ),
      body: Center(
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Message_Screen( username: user.username, userImage: user.img) ));
                  },
                  child: ListTile(
                      title: Text(user.username),
                      subtitle: Text(user.description),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      leading: CircleAvatar(maxRadius: 30,backgroundColor: Colors.grey.shade400, backgroundImage: NetworkImage(user.img)),
                  ),
                ),
            Divider(),
            ],
            );

          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: "Users",
            content: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: users.map((user) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.off(Message_Screen(username: user.username, userImage: user.img));
                          },
                          child: ListTile(
                            title: Text(user.username),
                            subtitle: Text(user.description),
                            trailing: Icon(Icons.person_add_alt),
                            leading: CircleAvatar(maxRadius: 30, backgroundColor: Colors.grey.shade400, backgroundImage: NetworkImage(user.img)),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.blueGrey.shade200,
        child: Icon(Icons.add, color: Colors.grey.shade700, size: 30),
      ),
    );
  }
}

class User {
  final String username;
  final String description;
  final String img;

  User({required this.username, required this.description, required this.img});
}
