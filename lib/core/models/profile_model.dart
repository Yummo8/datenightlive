class ProfileModel {
  final String? firstname;
  final String? lastname;
  final DateTime? birthday;
  final String? gender;
  final bool? genderVisibility;
  final String? town;
  final bool? townVisibility;
  final List<String>? nation;
  final bool? nationVisibility;
  final String? religious;
  final bool? religiousVisibility;
  final String? smoke;
  final bool? smokeVisibility;
  final String? drink;
  final bool? drinkVisibility;
  final String? drug;
  final bool? drugVisibility;

  ProfileModel({
    this.firstname,
    this.lastname,
    this.birthday,
    this.gender,
    this.genderVisibility,
    this.town,
    this.townVisibility,
    this.nation,
    this.nationVisibility,
    this.religious,
    this.religiousVisibility,
    this.smoke,
    this.smokeVisibility,
    this.drink,
    this.drinkVisibility,
    this.drug,
    this.drugVisibility,
  });

  ProfileModel copyWith(
      {String? firstname,
      String? lastname,
      DateTime? birthday,
      String? gender,
      bool? genderVisibility,
      String? town,
      bool? townVisibility,
      List<String>? nation,
      bool? nationVisibility,
      String? religious,
      bool? religiousVisibility,
      String? smoke,
      bool? smokeVisibility,
      String? drink,
      bool? drinkVisibility,
      String? drug,
      bool? drugVisibility,
      String? pronoun,
      bool? pronounVisibility,
      int? height,
      bool? heightVisibility}) {
    return ProfileModel(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        genderVisibility: genderVisibility ?? this.genderVisibility,
        town: town ?? this.town,
        townVisibility: townVisibility ?? this.townVisibility,
        nation: nation ?? this.nation,
        nationVisibility: nationVisibility ?? this.nationVisibility,
        religious: religious ?? this.religious,
        religiousVisibility: religiousVisibility ?? this.religiousVisibility,
        smoke: smoke ?? this.smoke,
        smokeVisibility: smokeVisibility ?? this.smokeVisibility,
        drink: drink ?? this.drink,
        drinkVisibility: drinkVisibility ?? this.drinkVisibility,
        drug: drug ?? this.drug,
        drugVisibility: drugVisibility ?? this.drugVisibility);
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
        town: snapshot['town'],
        townVisibility: snapshot['town_visibility'],
        nation: List<String>.from(snapshot['nation'] ?? []),
        nationVisibility: snapshot['nation_visibility'],
        religious: snapshot['religious'],
        religiousVisibility: snapshot['religious_visibility'],
        smoke: snapshot['smoke'],
        smokeVisibility: snapshot['smoke_visibility'],
        drink: snapshot['drink'],
        drinkVisibility: snapshot['drink_visibility'],
        drug: snapshot['drug'],
        drugVisibility: snapshot['drug_visibility']);
  }

  Map<String, dynamic> toMap() => {
        'firstname': firstname,
        'lastname': lastname,
        'birthday': birthday?.toString() ?? DateTime.now().toString(),
        'gender': gender,
        'gender_visibility': genderVisibility ?? false,
        'town': town,
        'town_visibility': townVisibility ?? false,
        'nation': nation,
        'nation_visibility': nationVisibility ?? false,
        'religious': religious,
        'religious_visibility': religiousVisibility ?? false,
        'smoke': smoke,
        'smoke_visibility': smokeVisibility ?? false,
        'drink': drink,
        'drink_visibility': drinkVisibility ?? false,
        'drug': drug,
        'drug_visibility': drugVisibility ?? false
      };
}
