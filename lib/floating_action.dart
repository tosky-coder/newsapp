import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class floatingAction extends StatefulWidget {
  const floatingAction({Key? key}) : super(key: key);

  @override
  State<floatingAction> createState() => _floatingActionState();
}

class _floatingActionState extends State<floatingAction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Card(
                  shape: StadiumBorder(),
                  elevation: 10,
                  child: Container(
                    height: 200,
                    child: Center(
                      child: Text("upload an image")
                    ),
                  ),
                ),
                ),
                SizedBox(height: 20),
      
                TextFormField(
                  decoration: InputDecoration(
                    label: Text("Title"),
                    border: OutlineInputBorder(
                      borderRadius:BorderRadius.circular(12))
                  )
                ),
                SizedBox(height: 20),
      
                TextFormField(
                  maxLength: 60,
                  minLines: 8,
                  maxLines: 8,
                  decoration: InputDecoration(
                    label: Text("Body"),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                  ),
                ),
                SizedBox(height: 20),
      
                MaterialButton(
                  onPressed:() {},
                  child: Text("Submit"),
                  color: Colors.blue,
                  shape: StadiumBorder(),
                  )
      
            ],
          ),
        ),
      ),
    );
    
  }
}