import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:DNL/core/models/profile_model.dart';
import 'package:DNL/core/repositories/firestore_service.dart';

class ProfileRepository {
  final authedUser = FirebaseAuth.instance.currentUser;
  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profiles');

  Future<ProfileModel?> getProfileById(String uid) async {
    try {
      DocumentSnapshot snapshot = await profileCollection.doc(uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return ProfileModel.fromSnapshot(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ProfileModel> createProfile(ProfileModel profile) async {
    bool exists = await isCollectionExists('profiles');
    if (!exists) {
      await createCollection("profiles");
    }

    await profileCollection.doc(authedUser!.uid).set(profile.toMap());
    return profile;
  }

  Future<void> updateProfile(ProfileModel profile) async {
    // update profile
  }

  Future<void> deleteProfile(String uid) async {
    // delete profile
  }
}
