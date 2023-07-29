import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/Art.dart';
import 'FavPage.dart';

class ArtFeed extends StatelessWidget {
  final Art? art;
  final String? userID;
  const ArtFeed({Key? key, this.art, this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  image: DecorationImage(
                    image: NetworkImage(art!.artUrlImg!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Favorit(art: art, userID: userID),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/detail', arguments: art),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.attach_money), // Icône d'argent
                            Text(
                              ' :${art!.artPrice.toString()}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                          height: 2,
                          thickness: 5,
                          indent: 20,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.access_time), // Icône d'heure
                            const SizedBox(width: 2), // Espacement entre l'icône et le texte
                            Text(
                              ' ${formatTimestamp(art!.artTimestamp!)}',
                              // Autres propriétés de style de texte que vous pouvez ajouter
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on), // Icône d'heure
                            Text(
                              art!.artLieu!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.person), // Icône d'heure
                            Text(
                              ' :${art!.artUserName!.toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatTimestamp(Timestamp? timestamp) {
    var format = DateFormat('d MMM');
    return format.format(timestamp!.toDate());
  }
}
