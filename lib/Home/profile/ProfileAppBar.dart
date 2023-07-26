import 'package:experiance/firebase/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ProfileAppBar extends StatelessWidget {
  final User? user;
  const ProfileAppBar({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.40,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(user!.photoURL!),
              fit: BoxFit.cover
            )
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white, Colors.transparent],
                begin: Alignment.bottomRight,
              )
            ),
          ),
        ),
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: '${user!.displayName}\n',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black)),
            TextSpan(
                text: '${user!.email}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black87)),
          ],
        ),
      ),
        titlePadding: const EdgeInsets.only(left: 46.0, bottom: 8.0),
    ),
      actions: [
        IconButton(onPressed: () => Signout(context), icon: const Icon(Icons.logout))
      ],
    );
  }

  Signout(BuildContext context){
    Navigator.of(context).pop();
    AuthService().logout();
  }
}
