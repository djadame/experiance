import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/Art.dart';
import 'ArtFeed.dart';

class ArtList extends StatelessWidget {
  final String pageName, user;
  const ArtList({Key? key, required this.user, required this.pageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _art = Provider.of<List<Art>>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (_, index) {
          return ArtFeed(
            art: _art[index],
            userID: user,
          );
        },
        childCount: _art.length,
      ),
    );
  }
}
