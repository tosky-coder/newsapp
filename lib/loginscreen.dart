import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myblog/homescreen.dart';
import 'package:myblog/registration_screen.dart';
import 'package:myblog/utils.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  int count = 1;
  goBack(){
    if(count > 2){
      SystemNavigator.pop();
    }else{
      count++;
    }
  }
  String error_msg = "";
  void login(){
    try{
      FirebaseAuth.instance.signInWithEmailAndPassword(email: emailCtrl.text, password: passwordCtrl.text);
      var route = MaterialPageRoute(builder: (BuildContext) => HomeScreen());
      Navigator.push(context, route);
    }catch (e) {
      setState(() {
        error_msg = e.toString();
      });

    }
  }

  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isloading = false;
  bool showPassword = false;
  void switchPassword(){
    if(showPassword){
      showPassword = false;
    }else{
      showPassword = true;
    } 
    setState(() {
      
    });

  }
    @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        goBack();
        showSnackBar(context, "Double tap to exit");

       return await false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: size.height/9),
                 child: Column(
                  children:[ Image.asset("assets/images/loginm2.jpg")]),
                ),
                SizedBox(
                  height: 15
                ),
                Container(
                  margin:EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailCtrl,
                    decoration: InputDecoration(
                      hintText: "Enter email",
                      labelText: "Email",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: Icon(Icons.email)
                    ),
                    validator: (value){
                      bool emailValid =RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                      if(!emailValid){
                        return "Invalid Email Address";
                      }
                    }
                  )
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:40),
                  child: TextFormField(
                    obscureText: !showPassword,
                    controller: passwordCtrl,
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      labelText: "Password",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          switchPassword();
                        },
                        icon: showPassword
                        ?Icon(Icons.remove_red_eye)
                        :Icon(Icons.visibility_off),
                      )
                    ),
                    validator: (value){
                      if(value!.trim().length < 6){
                        return "Password must be greater than 6 characters";
                      }
                    }
          
                ),
                ),
                SizedBox(height: 15),
                Visibility(
                  visible: isloading,
                  child: CircularProgressIndicator()),
                   Text(error_msg,style: TextStyle(color: Colors.red)),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: size.width/2,
                  child: MaterialButton(
                    onPressed: (){
                      if(_formkey.currentState!.validate()) {
                        login();
                        
    
                     } 
                     },
                    child: Text("login"),
                    color: Colors.blue,
                    elevation: 10,
                    textColor:Colors.white,
                    shape: StadiumBorder(),
                    ),
                ),
                SizedBox(height:15),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: Row(
          
                    children: [
                      Text("Don't have an account?",style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 90),
                      InkWell(
                        child: Text("Register", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)),
                        onTap: () {
                        var route = MaterialPageRoute(builder: (context) => RegistrationScreen());
                       Navigator.push(context, route);
                        },
                      )
                    ],
                  ),
                )           
                 ],
                  
              
        ),

      ),
    )
      ),
      );
  
    
  }
}