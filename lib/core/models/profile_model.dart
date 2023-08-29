import 'package:DNL/common/values/constants.dart';

class ProfileModel {
  final String? firstname;
  final String? lastname;
  final DateTime? birthday;
  final String? gender;
  final bool? genderVisibility;
  final String? dateGender;
  final bool? dateGenderVisibility;
  final String? town;
  final bool? townVisibility;
  final List<String>? nation;
  final bool? nationVisibility;
  final String? smoke;
  final bool? smokeVisibility;
  final String? drink;
  final bool? drinkVisibility;
  final List<Media>? medias;
  final String? bio;

  ProfileModel({
    this.firstname,
    this.lastname,
    this.birthday,
    this.gender,
    this.genderVisibility,
    this.dateGender,
    this.dateGenderVisibility,
    this.town,
    this.townVisibility,
    this.nation,
    this.nationVisibility,
    this.smoke,
    this.smokeVisibility,
    this.drink,
    this.drinkVisibility,
    this.medias,
    this.bio,
  });

  ProfileModel copyWith(
      {String? firstname,
      String? lastname,
      DateTime? birthday,
      String? gender,
      bool? genderVisibility,
      String? dateGender,
      bool? dateGenderVisibility,
      String? town,
      bool? townVisibility,
      List<String>? nation,
      bool? nationVisibility,
      String? smoke,
      bool? smokeVisibility,
      String? drink,
      bool? drinkVisibility,
      String? pronoun,
      bool? pronounVisibility,
      int? height,
      bool? heightVisibility,
      List<Media>? medias,
      String? bio}) {
    return ProfileModel(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        genderVisibility: genderVisibility ?? this.genderVisibility,
        dateGender: dateGender ?? this.dateGender,
        dateGenderVisibility: dateGenderVisibility ?? this.dateGenderVisibility,
        town: town ?? this.town,
        townVisibility: townVisibility ?? this.townVisibility,
        nation: nation ?? this.nation,
        nationVisibility: nationVisibility ?? this.nationVisibility,
        smoke: smoke ?? this.smoke,
        smokeVisibility: smokeVisibility ?? this.smokeVisibility,
        drink: drink ?? this.drink,
        drinkVisibility: drinkVisibility ?? this.drinkVisibility,
        medias: medias ?? this.medias,
        bio: bio ?? this.bio);
  }

  factory ProfileModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return ProfileModel(
        firstname: snapshot['firstname'],
        lastname: snapshot['lastname'],
        birthday: snapshot['birthday'] != null
            ? DateTime.parse(snapshot['birthday'])
            : null,
        gender: snapshot['gender'],
        genderVisibility: snapshot['gender_visibility'],
        dateGender: snapshot['dateGender'],
        dateGenderVisibility: snapshot['dateGender_visibility'],
        town: snapshot['town'],
        townVisibility: snapshot['town_visibility'],
        nation: List<String>.from(snapshot['nation'] ?? []),
        nationVisibility: snapshot['nation_visibility'],
        smoke: snapshot['smoke'],
        smokeVisibility: snapshot['smoke_visibility'],
        drink: snapshot['drink'],
        drinkVisibility: snapshot['drink_visibility'],
        medias: List<Media>.from(
            snapshot['medias'].map((i) => Media.fromJson(i)).toList() ?? []),
        bio: snapshot['bio']);
  }

  Map<String, dynamic> toMap() => {
        'firstname': firstname,
        'lastname': lastname,
        'birthday': birthday?.toString() ?? DateTime.now().toString(),
        'gender': gender,
        'gender_visibility': genderVisibility ?? false,
        'dateGender': dateGender,
        'dateGender_visibility': dateGenderVisibility ?? false,
        'town': town,
        'town_visibility': townVisibility ?? false,
        'nation': nation,
        'nation_visibility': nationVisibility ?? false,
        'smoke': smoke,
        'smoke_visibility': smokeVisibility ?? false,
        'drink': drink,
        'drink_visibility': drinkVisibility ?? false,
        'medias': medias!.map((e) => e.toJson()).toList(),
        'bio': bio,
      };
}
