// ignore_for_file: non_constant_identifier_names

class Constants {
  static DateTime release_date = DateTime(2023, 7, 10);
}

class Media {
  final int index;
  final String type;
  final String media;
  final String thumbnail;
  final String duration;

  Media({
    required this.index,
    required this.type,
    required this.media,
    required this.thumbnail,
    required this.duration,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['index'] = index;
    data['type'] = type;
    data['media'] = media;
    data['thumbnail'] = thumbnail;
    data['duration'] = duration;

    return data;
  }

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      index: json['index'],
      type: json['type'],
      media: json['media'],
      thumbnail: json['thumbnail'],
      duration: json['duration'],
    );
  }
}
