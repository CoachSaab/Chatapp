import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Chartapp/Screens/Auth/Login/Login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserinfoScreen extends StatefulWidget {
  const UserinfoScreen({super.key});

  @override
  State<UserinfoScreen> createState() => _UserinfoScreenState();
}

class _UserinfoScreenState extends State<UserinfoScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userphoneController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userData.exists) {
        final data = userData.data();
        if (data != null) {
          _usernameController.text = data['name'] ?? '';
          _userphoneController.text = data['email'] ?? '';
          _aboutController.text = data['about'] ?? '';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        backgroundColor: Colors.grey.shade200,
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAll(LoginScreen());
              },
              child: Text('Log-out')
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: InkWell(onTap: () => CustomImagePicker(),child: CircleAvatar(radius: 30)),
                      title: Text('Enter your name and add an optional profile picture'),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('Email Id'),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _userphoneController,
                            decoration: InputDecoration(
                              hintText: 'enter here',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('About'),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _aboutController,
                            decoration: InputDecoration(
                              hintText: 'enter here',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement save functionality here
                },
                child: Text('Save'),
              ),
            ],
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

}