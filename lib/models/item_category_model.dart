import 'package:equatable/equatable.dart';

class ItemCategoryModel extends Equatable {
  final String? topic;
  final String? name;
  final String? imageURL;
  final String? baseURL;

  const ItemCategoryModel({this.topic, this.name, this.imageURL, this.baseURL});

  ItemCategoryModel copyWith(
      {String? topic, String? name, String? imageURL, String? baseURL}) {
    return ItemCategoryModel(
        topic: topic ?? this.topic,
        name: name ?? this.name,
        imageURL: imageURL ?? this.imageURL,
        baseURL: baseURL ?? this.baseURL);
  }

  factory ItemCategoryModel.fromMap(Map<String, dynamic> json) =>
      ItemCategoryModel(
          topic: json['topic'] ?? "",
          name: json['name'] ?? "",
          imageURL: json['imageURL'] ?? "",
          baseURL: json['baseURL'] ?? "");

  Map<String, dynamic> toJson() =>
      {'topic': topic, 'name': name, 'imageURL': imageURL, 'baseURL': baseURL};

  @override
  List<Object?> get props => [topic, name, imageURL, baseURL];
}
