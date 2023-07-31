import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget  {
  final User? user;
  const HomeAppBar({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Add Section',),
      elevation: 0.8,
      floating: true,
      forceElevated: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: ()=> Navigator.pushNamed(context, '/profile') ,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(user!.photoURL!),
            ),
          ),
        ),

      ],
    );
  }

}