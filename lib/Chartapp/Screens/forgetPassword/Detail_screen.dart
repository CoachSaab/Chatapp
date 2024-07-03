import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Otp_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _emailController = TextEditingController();



  Future<void> email_request () async {
    EmailOTP.config(
      appName: 'Chat App',
      appEmail: 'chat@gmail.com',
      otpLength: 5,
    );

    if(_emailController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('field is empty')),
      );
      return;
    }

    try{
     bool otpSent = await EmailOTP.sendOTP(email: _emailController.text);
     if(otpSent) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('OTP sent successfuly'))
       );
       Get.to(OtpScreen());
     }
    } catch (e){
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending OTP')),
      );
  }


  }

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
                            'User Details',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          ),

                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              email_request();
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
                            },
                            child: Text('Otp'),
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

