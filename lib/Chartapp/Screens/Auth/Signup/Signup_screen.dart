import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/Chartapp/Screens/Auth/Login/Login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';

Future<User?> createAccount(String name, String email, String password, String phone) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print('Account created successfully');
    Get.off(LoginScreen());

    userCredential.user!.updateDisplayName(name);

    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      "name": name,
      "email": email,
      "status": "Unavailable",
      "uid": _auth.currentUser!.uid,
      "phone": phone,
    });

    return userCredential.user;
  } catch (e) {
    print(e);
    Get.defaultDialog(
      title: 'Error',
      content: Text('$e'),
      textConfirm: 'ok',
      onConfirm: () => Get.back(),
    );

    return null;
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool isLoading = false;

  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;


  void _validateInputs() {
    setState(() {
      _usernameError = _usernameController.text.isEmpty ? 'Username is required' : null;
      _emailError = !_isValidEmail(_emailController.text) ? 'Invalid email' : null;
      _passwordError = _passwordController.text.isEmpty ? 'Password is required' : null;
      _confirmPasswordError = _passwordController.text != _confirmPasswordController.text ? 'Passwords do not match' : null;
    });

    if (_usernameError == null && _emailError == null && _passwordError == null && _confirmPasswordError == null) {
      // All inputs are valid, proceed with creating an account
      setState(() {
        isLoading = true;
      });
      _createAccount();
    }
  }

  void _createAccount() async {
    User? user = await createAccount(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
      _phoneController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (user != null) {
      // Account creation successful, navigate to another screen
      print('Account creation successful');
    } else {
      // Account creation failed, show an error message
      print('Account creation failed');
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Card(
                color: Colors.white,
                shadowColor: Colors.blue.shade300,
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'User Register',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          errorText: _usernameError,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: _emailError,
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone (optional)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: _passwordError,
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          errorText: _confirmPasswordError,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: _validateInputs,
                          child: Text('Sign in'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ),
                      Divider(),
                      TextButton(
                        onPressed: () async {
                          // Add Google Sign-In functionality here
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage('https://imgs.search.brave.com/vTCwcACTcg2o4L_XU9oOIfkA6VLpBo1CJ618ShAOhSI/rs:fit:860:0:0/g:ce/aHR0cHM6Ly8xMDAw/bG9nb3MubmV0L3dw/LWNvbnRlbnQvdXBs/b2Fkcy8yMDE2LzEx/L05ldy1Hb29nbGUt/TG9nby00OTd4NTAw/LmpwZw'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Text('Sign in with Google'),
                          ],
                        ),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
