import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(color: Colors.deepPurple,width: 100,height: 100,),
                Container(color: Colors.black, width: 50,height: 50,),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(color: Colors.deepPurple,width:400,height: 500,),
                Container(color: Colors.purpleAccent, width: 400,height: 50,),
              ],
            )

          ],
        ),
      )


      /* Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(color: Colors.deepPurple,width: 100,height: 100,),
            Container(color: Colors.blue, width: 50,height: 50,),
          ]
      )
       */
    );
  }
}


