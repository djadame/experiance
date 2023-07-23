import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget  {
  final User? user;
  const HomeAppBar({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Home'),
      elevation: 0.8,
      floating: true,
      forceElevated: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(user!.photoURL!),
          ),
        ),

      ],
    );
  }

}