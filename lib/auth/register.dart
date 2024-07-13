import 'package:flutter/material.dart';
import 'package:noteapp/constant/color.dart';
import 'package:noteapp/service/fireauth.dart';

class registerscreen extends StatefulWidget {
  final Function toggle;
  const registerscreen({super.key, required this.toggle});

  @override
  State<registerscreen> createState() => _registerscreenState();
}

class _registerscreenState extends State<registerscreen> {
final AuthServices _auth = AuthServices();
  // form key
 final _formKey = GlobalKey<FormState>();
  //email password states
  String email = "";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
          children: [
            SizedBox(height: 60,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("CREATE ACCOUNT NOW!",
              style: TextStyle(
                color: textcolor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Register to continue..",
              style: TextStyle(
                color: textcolor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            Center(
              child: Image.asset("assets/login.png",
              height: 350,
              width: 350,
              ),
            ),
            SizedBox(height: 10,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (val) =>
                            val!.isEmpty ? "Enter a valid email" : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                            decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                        obscureText: true,
                      validator: (val) => val!.length < 6
                            ? "Password must be at least 6 characters"
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                              decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your Password',
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.password),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                      ),
                  ),
                  SizedBox(height: 5,),
                  Text(error,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                  ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () async {
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);

                          if (result == null) {
                            //error
                            setState(() {
                              error = "please enter a valid email!";
                            });
                          }
                        },
                    child: Container(
                          height: 60,
                          width: 300,
                          child: Center(
                            child: Text("REGISTER",
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
                      SizedBox(height: 6,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",
                          style: TextStyle(
                            color: textcolor,
                            fontSize: 19,
                          ),
                          ),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Text("Login",
                            style: TextStyle(
                              color: buttoncolor,
                              fontSize: 19,
                              decoration: TextDecoration.underline,
                            ),
                            ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}