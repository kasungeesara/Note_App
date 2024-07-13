
import 'package:flutter/material.dart';
import 'package:noteapp/auth/login.dart';
import 'package:noteapp/auth/register.dart';

class authscreen extends StatefulWidget {
  
  const authscreen({super.key});

  @override
  State<authscreen> createState() => _authscreenState();
}

// ignore: camel_case_types
class _authscreenState extends State<authscreen> {
  bool signinpage = true;

  // toggle page
void swichpages(){
  setState(() {
    signinpage =! signinpage;
  });
}

  @override
  Widget build(BuildContext context) {
    if(signinpage == true){
      return loginscreen(toggle: swichpages,);
    }
    else{
      return registerscreen(toggle: swichpages,);
    }
  }
}