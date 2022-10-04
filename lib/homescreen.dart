import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myblog/floating_action.dart';
import 'package:myblog/homepage.dart';
import 'package:myblog/models/UserModel.dart';
import 'package:myblog/profilepage.dart';
import 'package:myblog/repo/users_repo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  UserModel? userModel;
  UserRepo userRepo = UserRepo();
  initUser()async{
    var id = userRepo.checkUser(context);
    userModel = await userRepo.getUser(id);
  }

@override
  void initState() {
    initUser();
    // TODO: implement initState
    super.initState();

  }

   List<Widget> items = [HomePage(), ProfilePage()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel!.username!)),
      body: items[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        elevation: 10,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amber,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max_outlined), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var route = MaterialPageRoute(builder: (BuildContext) => floatingAction());
      Navigator.push(context, route);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}   


