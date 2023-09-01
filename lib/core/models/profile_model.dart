import 'package:DNL/common/values/constants.dart';

class ProfileModel {
  final String? firstname;
  final String? lastname;
  final String? gender;
  final bool? genderVisibility;
  final DateTime? birthday;
  final bool? birthdayVisibility;
  final String? height;
  final bool? heightVisibility;
  final String? town;
  final bool? townVisibility;
  final String? relStatus;
  final bool? relStatusVisibility;
  final String? smoke;
  final bool? smokeVisibility;
  final String? drink;
  final bool? drinkVisibility;
  final String? preferDrink;
  final List<Media>? medias;
  final String? bio;
  final String? music;
  final String? search;
  final String? dateGender;
  final String? distance;

  ProfileModel({
    this.firstname,
    this.lastname,
    this.gender,
    this.genderVisibility,
    this.birthday,
    this.birthdayVisibility,
    this.height,
    this.heightVisibility,
    this.town,
    this.townVisibility,
    this.relStatus,
    this.relStatusVisibility,
    this.smoke,
    this.smokeVisibility,
    this.drink,
    this.drinkVisibility,
    this.preferDrink,
    this.medias,
    this.bio,
    this.music,
    this.search,
    this.dateGender,
    this.distance,
  });

  ProfileModel copyWith({
    String? firstname,
    String? lastname,
    String? gender,
    bool? genderVisibility,
    DateTime? birthday,
    bool? birthdayVisibility,
    String? height,
    bool? heightVisibility,
    String? town,
    bool? townVisibility,
    String? relStatus,
    bool? relStatusVisibility,
    List<String>? nation,
    bool? nationVisibility,
    String? smoke,
    bool? smokeVisibility,
    String? drink,
    bool? drinkVisibility,
    String? preferDrink,
    String? pronoun,
    bool? pronounVisibility,
    List<Media>? medias,
    String? bio,
    String? music,
    String? search,
    String? dateGender,
    String? distance,
  }) {
    return ProfileModel(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        gender: gender ?? this.gender,
        genderVisibility: genderVisibility ?? this.genderVisibility,
        birthday: birthday ?? this.birthday,
        birthdayVisibility: birthdayVisibility ?? this.birthdayVisibility,
        height: height ?? this.height,
        heightVisibility: heightVisibility ?? this.heightVisibility,
        town: town ?? this.town,
        townVisibility: townVisibility ?? this.townVisibility,
        relStatus: relStatus ?? this.relStatus,
        relStatusVisibility: relStatusVisibility ?? this.relStatusVisibility,
        smoke: smoke ?? this.smoke,
        smokeVisibility: smokeVisibility ?? this.smokeVisibility,
        drink: drink ?? this.drink,
        drinkVisibility: drinkVisibility ?? this.drinkVisibility,
        preferDrink: preferDrink ?? this.preferDrink,
        medias: medias ?? this.medias,
        bio: bio ?? this.bio,
        music: music ?? this.music,
        search: search ?? this.search,
        dateGender: dateGender ?? this.dateGender,
        distance: distance ?? this.distance);
  }

  factory ProfileModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return ProfileModel(
      firstname: snapshot['firstname'],
      lastname: snapshot['lastname'],
      gender: snapshot['gender'],
      genderVisibility: snapshot['gender_visibility'],
      birthday: snapshot['birthday'] != null
          ? DateTime.parse(snapshot['birthday'])
          : null,
      birthdayVisibility: snapshot['birthday_visibility'],
      height: snapshot['height'],
      heightVisibility: snapshot['height_visibility'],
      town: snapshot['town'],
      townVisibility: snapshot['town_visibility'],
      relStatus: snapshot['relStatus'],
      relStatusVisibility: snapshot['relStatus_visibility'],
      smoke: snapshot['smoke'],
      smokeVisibility: snapshot['smoke_visibility'],
      drink: snapshot['drink'],
      drinkVisibility: snapshot['drink_visibility'],
      preferDrink: snapshot['preferDrink'],
      medias: List<Media>.from(
          snapshot['medias'].map((i) => Media.fromJson(i)).toList() ?? []),
      bio: snapshot['bio'],
      music: snapshot['music'],
      search: snapshot['search'],
      dateGender: snapshot['dateGender'],
      distance: snapshot['distance'],
    );
  }

  Map<String, dynamic> toMap() => {
        'firstname': firstname,
        'lastname': lastname,
        'gender': gender,
        'gender_visibility': genderVisibility ?? false,
        'birthday': birthday?.toString() ?? DateTime.now().toString(),
        'birthday_visibility': birthdayVisibility ?? false,
        'height': height,
        'height_visibility': heightVisibility ?? false,
        'town': town,
        'town_visibility': townVisibility ?? false,
        'relStatus': relStatus,
        'relStatus_visibility': relStatusVisibility ?? false,
        'smoke': smoke,
        'smoke_visibility': smokeVisibility ?? false,
        'drink': drink,
        'drink_visibility': drinkVisibility ?? false,
        'preferDrink': preferDrink,
        'medias': medias!.map((e) => e.toJson()).toList(),
        'bio': bio,
        'music': music,
        'search': search,
        'dateGender': dateGender,
        'distance': distance,
      };
}
