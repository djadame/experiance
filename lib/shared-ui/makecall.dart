import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Service/CallPhone.dart';
import '../model/Art.dart';


class CallerPhone extends StatelessWidget {
/*  final Art? art;
  final String? userID;*/
  const CallerPhone({super.key,
  //this.art, this.userID
   });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 4.0,
      right: 20.0,
        child: GestureDetector(
          onTap: () => _makePhoneCall(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child:const Icon(Icons.call, color: Colors.blue,),

    ),
        ));
  }
  void _makePhoneCall(
      //String phoneNumber
      ) async {
    const phoneNumber = '+22893380145'; // Numéro de téléphone à appeler
    final Uri _url = Uri.parse('tel:$phoneNumber');
    if (await Permission.phone.request().isGranted){
      if (await canLaunchUrl(_url)) {
        await launchUrl(_url);
      } else {
        throw 'Impossible de passer l\'appel au numéro $phoneNumber';
      }
    }else{
      throw 'Permission refusée';
    }
  }
}

