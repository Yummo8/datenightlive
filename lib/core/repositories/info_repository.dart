import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:DNL/core/models/info_model.dart';
import 'package:DNL/core/repositories/firestore_service.dart';

class InfoRepository {
  final CollectionReference infoCollection =
      FirebaseFirestore.instance.collection('infos');

  Future<InfoModel?> getInfoById(String uid) async {
    try {
      DocumentSnapshot snapshot = await infoCollection.doc(uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return InfoModel.fromSnapsot(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<InfoModel> createInfo(InfoModel info) async {
    final authedUser = FirebaseAuth.instance.currentUser;
    bool exists = await isCollectionExists('infos');

    if (!exists) {
      await createCollection("infos");
    }
    await infoCollection.doc(authedUser!.uid).set(info.toMap());

    return info;
  }

  Future<void> updateInfo(InfoModel info) async {
    // update info
  }

  Future<void> deleteInfo(String uid) async {
    // delete info
  }
}
