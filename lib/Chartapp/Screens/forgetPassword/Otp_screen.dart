import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'PasswordChange_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = '';

  void emailVerification () {

    if(otp.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('field is empty')),
      );
      return;
    }


    try{
      bool result = EmailOTP.verifyOTP(otp: otp);

      if(result){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP verify successfully ')),
        );
        Get.to(() => PasswordchangeScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid OTP'),),
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP error: $e')),
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
                            'O T P',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),

                          OtpTextField(
                            numberOfFields: 5,
                            borderColor: Color(0xFF512DA8),
                            showFieldAsBox: true,
                            onCodeChanged: (String code) {},
                            onSubmit: (String verificationCode){
                              otp = verificationCode;
                            },
                          ),

                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              emailVerification();
                            },
                            child: Text('Next'),
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
