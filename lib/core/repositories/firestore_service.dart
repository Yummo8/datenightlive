import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:DNL/common/utils/logger.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<bool> isCollectionExists(String collectionPath) async {
  try {
    final snapshot = await firestore.collection(collectionPath).limit(1).get();
    return snapshot.docs.isNotEmpty;
  } catch (e) {
    return false;
  }
}

Future<void> createCollection(String collection) async {
  try {
    await firestore.collection(collection).doc().set({'dummyData': true});
  } catch (e) {
    logger.e('Error creating collection: $e');
  }
}
