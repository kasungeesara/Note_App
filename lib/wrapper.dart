import 'package:flutter/material.dart';
import 'package:noteapp/auth/auth.dart';
import 'package:noteapp/screens/home.dart';
import 'package:noteapp/service/usermodel.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    
    // the user data that the provider provides this can be a  user data or can be null
    final User = Provider.of<UserModel?>(context);

    if(User==null){
      return authscreen();
    }else{
      return homescreen();
    }
  }
}
