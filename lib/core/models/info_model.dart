import 'package:DNL/common/values/constants.dart';

class InfoModel {
  final List<Media>? medias;
  final String? bio;
  final List<String>? prompts;
  final List<String>? answers;

  InfoModel({
    this.medias,
    this.bio,
    this.prompts,
    this.answers,
  });

  InfoModel copyWith(
      {List<Media>? medias,
      String? bio,
      List<String>? prompts,
      List<String>? answers}) {
    return InfoModel(
        medias: medias ?? this.medias,
        bio: bio ?? this.bio,
        prompts: prompts ?? this.prompts,
        answers: answers ?? this.answers);
  }

  factory InfoModel.fromSnapsot(Map<String, dynamic> snapshot) {
    return InfoModel(
      medias: List<Media>.from(
          snapshot['medias'].map((i) => Media.fromJson(i)).toList() ?? []),
      bio: snapshot['bio'],
      prompts: List<String>.from(snapshot['prompts'] ?? []),
      answers: List<String>.from(snapshot['answers'] ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
        'medias': medias!.map((e) => e.toJson()).toList(),
        'bio': bio,
        'prompts': prompts,
        'answers': answers,
      };
}
