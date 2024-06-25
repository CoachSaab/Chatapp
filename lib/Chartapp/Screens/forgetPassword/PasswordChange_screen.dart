import 'package:flutter/material.dart';

import '../Dashboard/Dashboard_screen.dart';

class PasswordchangeScreen extends StatefulWidget {
  const PasswordchangeScreen({super.key});

  @override
  State<PasswordchangeScreen> createState() => _PasswordchangeScreenState();
}

class _PasswordchangeScreenState extends State<PasswordchangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          fit: StackFit.expand,
          children:<Widget>[

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
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
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Change password',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),

                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'New password',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Confirm password',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),


                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
                            },
                            child: Text('Done'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.black,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }
}
