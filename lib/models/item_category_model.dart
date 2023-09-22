import 'package:equatable/equatable.dart';

class ItemCategoryModel extends Equatable {
  final int? id;
  final String? topic;
  final String? name;
  final String? image;
  final String? appUrl;
  final String? webUrl;

  const ItemCategoryModel(
      {this.id, this.topic, this.name, this.image, this.appUrl, this.webUrl});

  ItemCategoryModel copyWith(
      {int? id,
      String? topic,
      String? name,
      String? image,
      String? appUrl,
      String? webUrl}) {
    return ItemCategoryModel(
      id: id ?? this.id,
      topic: topic ?? this.topic,
      name: name ?? this.name,
      image: image ?? this.image,
      appUrl: appUrl ?? this.appUrl,
      webUrl: webUrl ?? this.webUrl,
    );
  }

  factory ItemCategoryModel.fromMap(Map<String, dynamic> map) =>
      ItemCategoryModel(
          id: map['id'],
          topic: map['topic'] ?? "",
          name: map['name'] ?? "",
          image: map['image'] ?? "",
          appUrl: map['app_url'] ?? "",
          webUrl: map['web_url'] ?? "");

  Map<String, dynamic> toMap() => {
        'id': id,
        'topic': topic,
        'name': name,
        'image': image,
        'app_url': appUrl,
        'web_url': webUrl,
      };

  @override
  List<Object?> get props => [id, topic, name, image, appUrl, webUrl];
}
