import 'package:experiance/shared-ui/List/userList/Articlefeed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../firebase/dbservices.dart';
import '../../../model/Art.dart';


class ArticleList extends StatelessWidget {
  final String userID;
  const ArticleList({super.key,  required this.userID});

  @override
  Widget build(BuildContext context) {
    final _art = Provider.of<List<Art>>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (_, index) {
          return StreamBuilder(
            stream: DbService(userID: userID, artID: _art[index].artID).myFavoriteArt,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                _art[index].isMyFavoriteArt = false;
                return ArticleFeed(
                  art: _art[index],
                  userID: userID,
                );
              }else{
                _art[index].isMyFavoriteArt = true;
                return ArticleFeed(
                  art: _art[index],
                  userID: userID,
                );
              }
            },
          );
        },
      childCount: _art.length,
      )
    );
  }
}
