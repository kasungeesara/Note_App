import 'package:flutter/material.dart';
import 'package:noteapp/constant/color.dart';
import 'package:noteapp/screens/addnote.dart';
import 'package:noteapp/screens/displaynote.dart';
import 'package:noteapp/service/fireauth.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {

final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: bgcolor,
          title: Text("Emerald Memo",
          style: TextStyle(
            color: textcolor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          ),
          actions: [
            ElevatedButton(onPressed:()async {
             await _auth.signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: buttoncolor,
            ),
             child:const Icon(Icons.logout,
             color: Colors.black,
             ),
             )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70,),
             Center(
               child: Image.asset("assets/home.png",
               width: 350,
               height: 350,
               ),
             ),
             SizedBox(height: 20,),
              MaterialButton(
                onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddNoteScreen()));
              },
                child: Container(
                            height: 60,
                            width: 300,
                            child: Center(
                              child: Text("ADD NOTES",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: buttoncolor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              )
                            ),
                          ),
              ),
                        SizedBox(height: 10,),
                 MaterialButton(
                  onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  DisplayNotesScreen()));
              },
                   child: Container(
                            height: 60,
                            width: 300,
                            child: Center(
                              child: Text("YOUR NOTES",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: buttoncolor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              )
                            ),
                          ),
                 ),
            ],
          ),
        ),
      ),
    );
  }
}