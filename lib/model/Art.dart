import 'package:cloud_firestore/cloud_firestore.dart';

class Art {
  String? artID,
      artName,
      artDescription,
      artLieu,
      artUserID,
      artUserName,
      artUrlImg;
  double? artPrice;
  Timestamp? artTimestamp;
  bool? isMyFavoriteArt;
  int? artFavoriteCount;

  Art(
      {this.artID,
      this.artName,
      this.artDescription,
      this.artPrice,
      this.artLieu,
      this.artUrlImg,
      this.artUserID,
      this.artUserName,
      this.artTimestamp,
      this.artFavoriteCount,
      this.isMyFavoriteArt});
}
