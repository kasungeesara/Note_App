import 'package:flutter/material.dart';
import 'package:noteapp/constant/color.dart';
import 'package:noteapp/wrapper.dart';
class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
              Center(
                child: Image.asset("assets/getstart.png",
                height: 300,
                width: 300,
                ),
              ),
              SizedBox(height: 20,),
              Text("WELCOME",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              ),
              Text("Emerald Memo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              ),
              SizedBox(height: 100,),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Wrapper()));
                },
                child: Container(
                  height: 50,
                  width: 200,
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                  decoration: BoxDecoration(
                    color: buttoncolor,
                    borderRadius: BorderRadius.circular(100)
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