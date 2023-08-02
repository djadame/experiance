import 'package:experiance/Home/profile/ProfileAppBar.dart';
import 'package:experiance/shared-ui/List/userList/ArticleList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared-ui/List/popularlist/ArtList.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProfileAppBar(user: _user,),
            SliverList(
              delegate: SliverChildListDelegate([
                const Padding(
                  padding: EdgeInsets.only(
                    top: 24.0,
                    left: 16.0,
                    bottom: 12.0,
                  ),
                  child: Text(
                    'Vos favoris',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider()
              ]),
            ),
            ArticleList(pageName: '/profile', userID: _user!.uid)
          ],
        ),
      )
    );
  }

}