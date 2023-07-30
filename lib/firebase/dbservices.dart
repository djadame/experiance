import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/Art.dart';

class DbService {
  //declaration et initialisation
  final CollectionReference _art = FirebaseFirestore.instance.collection('art');
  FirebaseStorage storage = FirebaseStorage.instance;

  String? userID, artID;
  DbService({this.userID, this.artID});

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

  //recupe des donne dans la db
  Stream<List<Art>> getArt() {
    Query queryArt = _art.orderBy('artTimestamp', descending: true);
    return queryArt.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Art(
            artID: doc.id,
            artName: doc.get('artName'),
            artDescription: doc.get('artDescription'),
            artPrice: doc.get('artPrice'),
            artLieu: doc.get('artLieu'),
            artUserID: doc.get('artUserID'),
            artUserName: doc.get('artUserName'),
            artTimestamp: doc.get('artTimestamp'),
            artFavoriteCount: doc.get('artFavoriteCount'),
            isMyFavoriteArt: doc.get('isMyFavoriteArt'),
            artUrlImg: doc.get('artUrlImg'));
      }).toList();
    });
  }


  //autre funtion de recupe sur le net, perso pour la db
  void getArt2() {
    var db = FirebaseFirestore.instance;
    final docRef = db.collection('art').doc();
    docRef.get().then(
            (doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Art(
              artID: doc.id,
              artName: data['artName'],
              artDescription: data['artDescription'],
              artPrice: data['artPrice'],
              artLieu: data['artLieu'],
              artUserID: data['artUserID'],
              artUserName: data['artUserName'],
              artTimestamp: data['artTimestamp'],
              artFavoriteCount: data['artFavoriteCount'],
              isMyFavoriteArt: data['isMyFavoriteArt'],
              artUrlImg: data['artUrlImg']);
        },
        onError: (err) => print(err));
  }


  //ajout de l'article' favorit dans une sous collection de la BD

  void addFavArt(Art art, String userID) {
    final artDocRef = _art.doc(art.artID);
    final favoritedBy = artDocRef.collection('favoritedBy');
    int artFavoriteCount = art.artFavoriteCount!;
    int increaseCount = artFavoriteCount+=1;
    favoritedBy.doc(userID).set({
      "artName": art.artName,
      "artDescription": art.artDescription,
      "artPrice": art.artPrice,
      "artLieu": art.artLieu,
      "artUserID": art.artUserID,
      "artUserName": art.artUserName,
      "artTimestamp": FieldValue.serverTimestamp(),
      "artFavoriteCount": increaseCount,
    });
    artDocRef.update({"artFavoriteCount": increaseCount});
  }


  //suppression de l'article' favorit dans une sous collection de la BD
  void removeFavArt(Art art, String userID) {
    final artDocRef = _art.doc(art.artID);
    final favoritedBy = artDocRef.collection('favoritedBy');
    int artFavoriteCount = art.artFavoriteCount!;
    int decreaseCount = artFavoriteCount -= 1;
    artDocRef.update({"artFavoriteCount": decreaseCount});
    favoritedBy.doc(userID).delete();
  }

  //recupe des article favorit dans une sous collection de la BD de l'utlicateur en temps reel

  Stream<Art> get myFavoriteArt{
    final favoritedBy = _art.doc(artID).collection('favoritedBy');
    return favoritedBy.doc(userID).snapshots().map((doc) {
      return Art(
          artID: doc.id,
          artName: doc.get('artName'),
          artDescription: doc.get('artDescription'),
          artPrice: doc.get('artPrice'),
          artLieu: doc.get('artLieu'),
          artUserID: doc.get('artUserID'),
          artUserName: doc.get('artUserName'),
          artTimestamp: doc.get('artTimestamp'),
          artFavoriteCount: doc.get('artFavoriteCount'),
          isMyFavoriteArt: doc.get('isMyFavoriteArt'),
          artUrlImg: doc.get('artUrlImg'),
      );
    });
  }
}