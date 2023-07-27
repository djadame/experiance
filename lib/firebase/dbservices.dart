import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/Art.dart';

class DbService {
  //declaration et initialisation
  final CollectionReference _art = FirebaseFirestore.instance.collection('art');
  FirebaseStorage storage = FirebaseStorage.instance;

  //upload de l'image vers firebase storage
  Future<String> uploadFile(file) async {
    Reference reference = storage.ref().child('art/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  //ajout de l'article' dans la BD
  void addArticle(Art art) {
    _art.add({
      "artName": art.artName,
      "artDescription": art.artDescription,
      "artPrice": art.artPrice,
      "artLieu": art.artLieu,
      "artUserID": art.artUserID,
      "artUserName": art.artUserName,
      "artTimestamp": FieldValue.serverTimestamp(),
      "artFavoriteCount": 0,
      "isMyFavoriteArt": art.isMyFavoriteArt,
      "artUrlImg": art.artUrlImg
    });
  }
}
