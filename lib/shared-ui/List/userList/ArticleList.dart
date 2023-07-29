import 'package:experiance/shared-ui/List/userList/Articlefeed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/Art.dart';


class ArticleList extends StatelessWidget {
  final String user;
  const ArticleList({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final _art = Provider.of<List<Art>>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (_, index) {
          return ArticleFeed(
            art: _art[index],
            userID: user,
          );
        },
      childCount: _art.length,
      )
    );
  }
}
