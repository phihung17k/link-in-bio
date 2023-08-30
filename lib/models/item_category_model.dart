import 'package:equatable/equatable.dart';

class ItemCategoryModel extends Equatable {
  final String? topic;
  final String? name;
  final String? image;
  final String? appUrl;
  final String? webUrl;

  const ItemCategoryModel(
      {this.topic, this.name, this.image, this.appUrl, this.webUrl});

  ItemCategoryModel copyWith(
      {String? topic,
      String? name,
      String? image,
      String? appUrl,
      String? webUrl}) {
    return ItemCategoryModel(
        topic: topic ?? this.topic,
        name: name ?? this.name,
        image: image ?? this.image,
        appUrl: appUrl ?? this.appUrl,
        webUrl: webUrl ?? this.webUrl);
  }

  factory ItemCategoryModel.fromMap(Map<String, dynamic> json) =>
      ItemCategoryModel(
          topic: json['topic'] ?? "",
          name: json['name'] ?? "",
          image: json['image'] ?? "",
          appUrl: json['appUrl'] ?? "",
          webUrl: json['webUrl'] ?? "");

  Map<String, dynamic> toMap() => {
        'topic': topic,
        'name': name,
        'image': image,
        'app_url': appUrl,
        'web_url': webUrl,
      };

  @override
  List<Object?> get props => [topic, name, image, appUrl, webUrl];
}
