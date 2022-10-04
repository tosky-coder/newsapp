import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myblog/loginscreen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds:4), (){
var route = MaterialPageRoute(builder: (context) => loginScreen());
                    Navigator.push(context, route);
                    // TODO: implement initState
    super.initState();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Image.asset("assets/images/news logo.png"),
            SizedBox(height: 10),
            Text("Txsky Blog", style: TextStyle(fontFamily: "courier",fontSize: 20,fontWeight: FontWeight.bold),)
          ]
        
      ),


    )
    );
    
  }
}