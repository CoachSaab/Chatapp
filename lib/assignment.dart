import 'package:flutter/material.dart';

class assiggnment extends StatefulWidget {
  const assiggnment({super.key});

  @override
  State<assiggnment> createState() => _assiggnmentState();
}

class _assiggnmentState extends State<assiggnment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
       child: Container(
         height: 500,
         width: 360,
         decoration: BoxDecoration(
           color: Colors.lightBlue.shade100,
           border: Border.all(width: 2),
         ),
         child: Center(
           child: Column(
             children: [
               SizedBox(height: 100,),
               Center(child: Text('Flutter Architecture',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),

               SizedBox(height: 20,),
               Container(
                 height: 200,
                 width: 350,
                 decoration: BoxDecoration(
                   border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(25),
                   color: Color(0xFFFFCDD2),

                 ),
                 child: Column(
                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                   // crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     SizedBox(height: 25,),
                     Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 110),
                           child: Container(width: 110, height: 20,
                               decoration: BoxDecoration(
                                 border: Border.all(width: 1),
                                 borderRadius: BorderRadius.circular(5),
                                color: Colors.deepPurpleAccent.shade100,

                               ),
                               child: Center(child: Text('Material')),),
                         ),
                         SizedBox(width: 10,),
                         Container(width: 112, height: 20,
                           decoration: BoxDecoration(
                             border: Border.all(width: 1),
                             borderRadius: BorderRadius.circular(5),
                             color: Colors.deepPurpleAccent.shade100,

                           ),
                           child: Center(child: Text('Cupertino')),),
                       ],
                     ),
                     SizedBox(height: 10,),

                     /*padding: const EdgeInsets.only(left: 110),
                           child: Container(width: 233, height: 20,*/
                     Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 110),
                           child: Container(width: 233, height: 20,
                             decoration: BoxDecoration(
                               border: Border.all(width: 1),
                               borderRadius: BorderRadius.circular(5),
                               color: Colors.deepPurpleAccent.shade100,

                             ),
                             child: Center(child: Text('Widgets')),),
                         ),
                       ],
                     ),
                     Row(
                       children: [
                         Text("  Framework\n   (Dart)",style: TextStyle(fontWeight: FontWeight.bold),),
                         SizedBox(width: 20,),
                         Container(width: 235, height: 20,
                           decoration: BoxDecoration(
                             border: Border.all(width: 1),
                             borderRadius: BorderRadius.circular(5),
                             color: Colors.deepPurpleAccent.shade100,
                           ),
                           child: Center(child: Text('Rendering')),),
                       ],
                     ),

                     Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 108),
                           child: Container(width: 73, height: 20,
                             decoration: BoxDecoration(
                               border: Border.all(width: 1),
                               borderRadius: BorderRadius.circular(5),
                               color: Colors.deepPurpleAccent.shade100,

                             ),
                             child: Center(child: Text('Animation')),),
                         ),
                         SizedBox(width: 5,),
                         Container(width: 76, height: 20,
                           decoration: BoxDecoration(
                             border: Border.all(width: 1),
                             borderRadius: BorderRadius.circular(5),
                             color: Colors.deepPurpleAccent.shade100,

                           ),
                           child: Center(child: Text('Painting')),),
                         SizedBox(width: 5,),
                         Container(width: 76, height: 20,
                           decoration: BoxDecoration(
                             border: Border.all(width: 1),
                             borderRadius: BorderRadius.circular(5),
                             color: Colors.deepPurpleAccent.shade100,

                           ),
                           child: Center(child: Text('Gestures')),),
                       ],
                     ),
                     SizedBox(height:10 ),

                     Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 110),
                           child: Container(width: 233, height: 20,
                             decoration: BoxDecoration(
                               border: Border.all(width: 1),
                               color: Colors.deepPurpleAccent.shade100,
                               borderRadius: BorderRadius.circular(5),

                             ),
                             child: Center(child: Text('Foundation')),),
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
               SizedBox(height: 30),

               Container(
                 height: 100,
                 width: 350,
                 decoration: BoxDecoration(
                   border: Border.all(width: 1),
                   borderRadius: BorderRadius.circular(25),
                   color: Colors.pinkAccent.shade100,
                 ),
                 child:  Row(
                   children: [
                     Text("   \Engine\n   (C++)",style: TextStyle(fontWeight: FontWeight.bold),),
                     SizedBox(width: 30,),
                     Container(width: 70, height: 20,
                       decoration: BoxDecoration(
                         border: Border.all(width: 1),
                         borderRadius: BorderRadius.circular(5),
                         color: Colors.orange.shade300,
                       ),
                       child: Center(child: Text('Skia')),),
                     SizedBox(width: 10),

                     Container(width: 70, height: 20,
                       decoration: BoxDecoration(
                         border: Border.all(width: 1),
                         borderRadius: BorderRadius.circular(5),
                         color: Colors.orange.shade300,
                       ),
                       child: Center(child: Text('Dart')),),
                     SizedBox(width: 10),

                     Container(width: 70, height: 20,
                       decoration: BoxDecoration(
                         border: Border.all(width: 1),
                         borderRadius: BorderRadius.circular(5),
                         color: Colors.orange.shade300,
                       ),
                       child: Center(child: Text('Text')),),
                   ],
                 ),
               ),

             ],
           ),
         ),
       ),
     ),
    );
  }
}

