import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HappenOnDayProvider extends ChangeNotifier {
  String dicreption;
  String video;
  late FirebaseFirestore _query;

  HappenOnDayProvider({required this.dicreption,required this.video}) {
    _query = FirebaseFirestore.instance;
  }

  void setdatadicreption() async {
    var hodData =
        _query.collection("HappenedOnThisDay").doc("GEYokaQrwUtGoHpjSSfG");

    hodData.get().then((value) {

      dicreption = value.get('deception').toString() ;
      video = value.get('vidoe').toString() ;

         notifyListeners();

      print("${value.get('deception').toString()}");
    });

 
  }
}
