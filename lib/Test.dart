import 'package:flutter/material.dart';

class demo extends StatefulWidget {
  const demo({super.key});

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
             decoration: BoxDecoration(
               color: Colors.grey,
               shape: BoxShape.circle,
               image: DecorationImage(
                 image: NetworkImage('https://imgs.search.brave.com/NDX8FIj2ONpgBOM6tyVK8rZiKsnNBsFqoJiTJy0MQiM/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE3/MTAyNzA4MjIxMjUt/NjYxNGJkNjYzMTFm/P3E9ODAmdz0xMDAw/JmF1dG89Zm9ybWF0/JmZpdD1jcm9wJml4/bGliPXJiLTQuMC4z/Jml4aWQ9TTN3eE1q/QTNmREI4TUh4bGVI/QnNiM0psTFdabFpX/UjhOSHg4ZkdWdWZE/QjhmSHg4ZkE9PQ.jpeg'),
                 fit: BoxFit.cover,
               ),
             ),
            ),
            Text('jsfcjs'),
            IconButton(onPressed: (){}, icon: Icon(Icons.account_circle,size: 30,)),
            Icon(Icons.add_a_photo,color: Colors.red, ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(children: [
                ElevatedButton(onPressed: (){}, child: Text('click')),
                SizedBox(width: 190,),
                ElevatedButton(onPressed: (){}, child: Text('send')),

              ],),
            )
          ],
        ),
      ),
    );
  }
}

