import 'package:experiance/Widget/MyHomePage.dart';
import 'package:experiance/firebase/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Debut_de_laplication/login.dart';


class wrapper extends StatelessWidget {
  const wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final user = Provider.of<User?>(context);
   return user == null ? const login() : MyHomePage();

  }
}