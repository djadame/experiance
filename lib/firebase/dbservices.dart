import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/Art.dart';

class DbService {
  //declaration et initialisation
  final CollectionReference _art = FirebaseFirestore.instance.collection('art');
  FirebaseStorage storage = FirebaseStorage.instance;
  final user = FirebaseAuth.instance.currentUser;

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
          artUrlImg: doc.get('artUrlImg'),
        );
      }).toList(); // Convertir l'Iterable en List<Art>
    });
  }

  /*Stream<List<Art>> getArt() {
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
  }*/

  Stream<List<Art>> getArtByuserID() {
    final currentuser = FirebaseAuth.instance.currentUser;
    if (currentuser != null) {
      final uid = currentuser.uid;
      Query queryArt = _art
          .where('artUserID', isEqualTo: uid)
          .orderBy('artTimestamp', descending: true);
      return queryArt.snapshots().map((snapshot) {
        return snapshot.docs.map((snapshot) {
          return Art(
              artID: snapshot.id,
              artName: snapshot.get('artName'),
              artDescription: snapshot.get('artDescription'),
              artPrice: snapshot.get('artPrice'),
              artLieu: snapshot.get('artLieu'),
              artUserID: snapshot.get('artUserID'),
              artUserName: snapshot.get('artUserName'),
              artTimestamp: snapshot.get('artTimestamp'),
              artFavoriteCount: snapshot.get('artFavoriteCount'),
              isMyFavoriteArt: snapshot.get('isMyFavoriteArt'),
              artUrlImg: snapshot.get('artUrlImg'));
        }).toList();
      });
    }else{
      return Stream.value([]);
    }
  }

  //ajout de l'article' favorit dans une sous collection de la BD

  void addFavArt(Art art, String userID) {
    final artDocRef = _art.doc(art.artID);
    final favoritedBy = artDocRef.collection('favoritedBy');
    favoritedBy.doc(userID).get().then((doc) {
      if (!doc.exists) {
        int artFavoriteCount = art.artFavoriteCount!;
        int increaseCount = artFavoriteCount;

        favoritedBy.doc(userID).set({
          "artName": art.artName,
          "artDescription": art.artDescription,
          "artPrice": art.artPrice,
          "artLieu": art.artLieu,
          "artUserID": art.artUserID,
          "artUserName": art.artUserName,
          "artTimestamp": FieldValue.serverTimestamp(),
          "artFavoriteCount": increaseCount,
          "isMyFavoriteArt": true,
          "artUrlImg": art.artUrlImg

        });
        artDocRef.update({"artFavoriteCount": increaseCount});
      }
    });



  }


  //suppression de l'article' favorit dans une sous collection de la BD
  void removeFavArt(Art art, String userID) {

    final artDocRef = _art.doc(art.artID);
    final favoritedBy = artDocRef.collection('favoritedBy');
    favoritedBy.doc(userID).get().then((doc) {
      if (doc.exists) {
        int artFavoriteCount = art.artFavoriteCount!;
        int decreaseCount = artFavoriteCount -= 1;
        favoritedBy.doc(userID).delete();
        artDocRef.update({"artFavoriteCount": decreaseCount});
      }
    });

  }

  //recupe des article favorit dans une sous collection de la BD de l'utlicateur en temps reel

  Stream<Art> get myFavoriteArt{
    final favoritedBy = _art.doc(artID).collection('favoritedBy');
    return favoritedBy.doc(userID).snapshots().map((snapshot) {
      return Art(
          artID: snapshot.id,
          artName: snapshot.get('artName'),
          artDescription: snapshot.get('artDescription'),
          artPrice: snapshot.get('artPrice'),
          artLieu: snapshot.get('artLieu'),
          artUserID: snapshot.get('artUserID'),
          artUserName: snapshot.get('artUserName'),
          artTimestamp: snapshot.get('artTimestamp'),
          artFavoriteCount: snapshot.get('artFavoriteCount'),
          isMyFavoriteArt: snapshot.get('isMyFavoriteArt'),
          artUrlImg: snapshot.get('artUrlImg'),
      );
    });
  }

  // suppression de la voiture
  Future<void> deleteArt(String carID) => _art.doc(carID).delete();

  Future<Art> singleCar(String carID) async {
    final doc = await _art.doc(carID).get();
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
  }
}