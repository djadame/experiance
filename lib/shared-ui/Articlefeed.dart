import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/Art.dart';

class ArtFeed extends StatelessWidget {
  final Art? art;
  final String? userID;
  const ArtFeed({super.key, this.art, this.userID});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.4,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            image: DecorationImage(
              image: NetworkImage(art!.artUrlImg!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Row(
          children: [
            Column(
              children: [
                Text(
                  art!.artPrice.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  art!.artName!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  art!.artDescription!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  height: 16,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Text(
                  'Lieu: ${art!.artLieu!}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'De: ${art!.artUserName!.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    const Icon(Icons.access_time), // Icône d'heure
                    const SizedBox(width: 8), // Espacement entre l'icône et le texte
                    Text(
                      '${formatTimestamp(art!.artTimestamp!)}',
                      //'Date: ${art!.artTimestamp!.toDate().toString().substring(0, 10)}',
                    ),
                  ],
                ),
              ]
            ),



            const Spacer(),
          ],
        )
      ],
    );
  }
  String formatTimestamp(Timestamp? timestamp) {
    var format = DateFormat('d MMM');
    return format.format(timestamp!.toDate());
  }
}
