import 'package:experiance/firebase/dbservices.dart';
import 'package:experiance/model/Art.dart';
import 'package:flutter/material.dart';

class Favorit extends StatefulWidget {
  final Art? art;
  final String? userID;
  const Favorit({super.key, this.art, this.userID});

  @override
  State<Favorit> createState() => _FavoritState();
}

class _FavoritState extends State<Favorit> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 4.0,
      right: 12.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: widget.art!.isMyFavoriteArt!
            ? GestureDetector(
              onTap: () => DbService().removeFavArt(widget.art!, widget.userID!),
              child: Row(
              children: [
                Text(
                  widget.art!.artFavoriteCount.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const Icon(Icons.favorite, color: Colors.red),
              ],
        ),
            )
            : GestureDetector(
              onTap: () => DbService().addFavArt(widget.art!, widget.userID!),
              child: Row(
              children: [
                widget.art!.artFavoriteCount! > 0 ?
                Text(
                  widget.art!.artFavoriteCount.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                )
                : Container(),
                const Icon(Icons.favorite_border, color: Colors.red),
              ],
        ),
            ),
      ),
    );
  }
}
