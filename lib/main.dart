import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myblog/splashscreen.dart';
import 'package:flutter/foundation.dart';


class Config {
  static FirebaseOptions firbaseOptions = FirebaseOptions(
    apiKey: "AIzaSyCUEtMUgxy2IsvqceZAhUZgwy4GluvP9zA",
  authDomain: "tosky-project.firebaseapp.com",
  databaseURL: "https://tosky-project-default-rtdb.firebaseio.com",
  projectId: "tosky-project",
  storageBucket: "tosky-project.appspot.com",
  messagingSenderId: "508765870858",
  appId: "1:508765870858:web:19379939ab03181e36b8f3",
  measurementId: "G-S39VR7FW42"
  );
}

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb) {
    await Firebase.initializeApp(options: Config.firbaseOptions);
  }else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Blog',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home: splashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  
   @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 @override
  Widget build(BuildContext context) {
    return Scaffold(
   );
  }
}
