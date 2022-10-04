import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myblog/homescreen.dart';
import 'package:path/path.dart' as path;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  FirebaseStorage _storage = FirebaseStorage.instance;

  var userNameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  bool isloading = false;
  String error_msg = "";
  bool showPassword = false;

  void register()async{
    if(image != null){
      var imageUrl = upLoadImage();
     UserCredential userCredential = await FirebaseAuth.instance
     .createUserWithEmailAndPassword(email: emailCtrl.text, password: passwordCtrl.text);
     var route = MaterialPageRoute(builder: (BuildContext) => HomeScreen());
      Navigator.push(context, route);
     var id = userCredential.user!.uid;
     

     FirebaseFirestore.instance.collection("blogUser").doc(id).set({
      "id": id,
      "email": emailCtrl.text,
      "username": userNameCtrl.text,
      "password": passwordCtrl.text,
      "image_url": imageUrl

     });
     
    }else {
      ///errorrr////
    }
  }


  Future<String> upLoadImage()async{
      String filename = path.basename(image!.path);
      Reference reference = FirebaseStorage.instance.ref().child("profileImage/"+filename);
      UploadTask uploadTask = reference.putFile(File(image!.path));
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      print(imageUrl);
      return imageUrl;
      
  }
  void switchPassword(){
    if(showPassword){
      showPassword = false;
    }else{
      showPassword = true;
    }
    setState(() {
      
    });
  }
  XFile? image;

  void pickImage()async{
   final ImagePicker _picker = ImagePicker();
   image = await _picker.pickImage(source: ImageSource.gallery);
   setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
return Scaffold(
 body: SingleChildScrollView(
 padding:EdgeInsets.symmetric(horizontal:10, vertical: 10),
    child:Form(
       key: _formkey,
       child: Column(
       children: [
           Stack(
          children: [
           Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.symmetric(horizontal:5, vertical: 5),
             child: image != null
             ? CircleAvatar( 
                 backgroundColor: Colors.blue, 
                  radius: 80,
                  backgroundImage: FileImage(File(image!.path)),
                   )
                   :CircleAvatar( 
                 backgroundColor: Colors.blue, 
                  radius: 80,
                  backgroundImage: 
                  AssetImage("assets/images/avatar-png.jpg")),
                ),

                Positioned(
                  bottom: 0,
                  right: 130, 
                  child: RawMaterialButton(
                    elevation: 2.0,
                    fillColor: Colors.purple,
                    child: Icon(Icons.add_a_photo),
                    padding: EdgeInsets.all(15),
                    shape: CircleBorder(

                    ),
                    onPressed: () {
                      pickImage();
                    },
                     )
                  ),
           ]
            ),
                  SizedBox(height: 40),
                  
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
                        register();
                      
                     } 
                     },
                    child:Text("Register"),
                    color: Colors.blue,
                    elevation: 10,
                    textColor:Colors.white,
                    shape: StadiumBorder(),
                    ),
                ),

                      ],
                     ) 
                    )
            
        )
    );
      
      
    

    
  }
}