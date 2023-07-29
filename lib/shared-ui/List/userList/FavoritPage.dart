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
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: widget.art!.isMyFavoriteArt!
            ? Row(
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
        )
            : Row(
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
            const Icon(Icons.favorite_border, color: Colors.red,),
          ],
        ),
      ),
    );
  }
}
