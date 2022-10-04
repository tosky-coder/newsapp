import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var userNameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  bool isloading = false;
  String error_msg = "";
  bool showPassword = false;
  
  void switchPassword(){
    if(showPassword){
      showPassword = false;
    }else{
      showPassword = true;
    }
    setState(() {
      
    }
    );
  }
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: size.height / 6),
                alignment: Alignment.topCenter,
                child: CircleAvatar(backgroundColor: Colors.blue,
                radius: 80,
                child: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),

        Container(
         margin: EdgeInsets.symmetric(horizontal: 30),
          child: TextFormField(
          keyboardType: TextInputType.emailAddress,
           controller: emailCtrl,
           decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter your Email", 
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              prefixIcon: Icon(Icons.email),
              ),
                validator: (value) {
                bool emailValid =RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                   if(!emailValid){
                    return "Invalid Email Address";
                     }
                   },
                    ),
                    ),
 SizedBox(height: 20),
     Container( 
      margin:EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
        controller: userNameCtrl,
        keyboardType: TextInputType.name,
         decoration: InputDecoration(
        labelText: "Username",
        hintText: "Enter you email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: Icon(Icons.person),
       ),
          validator: (value) {
         if(value!.trim().length < 3){
     return "username must be greater than 3 characters";
       } 
        },
        ),
         ),
   SizedBox(height: 20),
     Container(
      margin:EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
      controller: passwordCtrl,
      obscureText: !showPassword,
      decoration: InputDecoration(
        labelText: "password",
         hintText: "Enter your password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
           onPressed: () {
            switchPassword();
             },
             icon: showPassword
              ?Icon(Icons.remove_red_eye) :Icon(Icons.visibility_off),
                )
                ),
               validator: (value) {
               if(value!.trim().length < 6){
                   return "password must be greater than 6 characters";
                      }
                     },

                   ),
                  ),
                     SizedBox(height: 20),
                        Visibility(
                          visible: isloading,
                          child:CircularProgressIndicator()),
                          Text(error_msg,style: TextStyle(color: Colors.red)),

         Container(
          margin: EdgeInsets.only(top: 10),
         width: size.width/2,
           child: MaterialButton(
           onPressed: (){
          if(_formkey.currentState!.validate()) {
         //update();
          }
          },
           child:Text("Update"),
           color: Colors.blue,
          minWidth: 200,
         height:50,
         elevation: 10,
         textColor:Colors.white,
        shape: StadiumBorder(),
        )
         ),

            ]
          )
          
            
          ),
      ),
     ); 
    
  }
}