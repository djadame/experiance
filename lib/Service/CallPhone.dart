import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class CallPhone{
  String? callPhone = "+22893380145";

  _makePhoneCall(
      //String phoneNumber
      ) async {
    var phoneNumber = callPhone; // Numéro de téléphone à appeler
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