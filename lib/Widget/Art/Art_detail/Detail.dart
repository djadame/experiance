import 'package:experiance/model/Art.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../firebase/dbservices.dart';
import '../../../shared-ui/showSnackBar.dart';


class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    final art = ModalRoute.of(context)!.settings.arguments as Art;
    final UserId = Provider.of<User?>(context)!.uid;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          art.artName!,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          art.artUserID == UserId
              ? IconButton(
                  onPressed: () {
                    onDeleteCar(context, art);
                  },
                  icon: const Icon(Icons.delete),
                )
              : Container(),
        ],
      ),

      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: NetworkImage(art.artUrlImg!),
              fit: BoxFit.cover
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    );
  }
  void onDeleteCar(BuildContext context,Art art) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Voulez-vous supprimer votre ${art.artName} ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('ANNULER'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  DbService().deleteArt(art.artID!);
                  showNotification(context, 'Supprimer avec succès');
                },
                child: Text('SUPPRIMER'),
              )
            ],
          );
        });
  }
}
