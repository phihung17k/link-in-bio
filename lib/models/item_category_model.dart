import 'package:equatable/equatable.dart';

class ItemCategoryModel extends Equatable {
  final String? name;
  final String? imageURL;
  final String? baseURL;

  const ItemCategoryModel({this.name, this.imageURL, this.baseURL});

  ItemCategoryModel copyWith(
      {String? name, String? imageURL, String? baseURL}) {
    return ItemCategoryModel(
        name: name ?? this.name,
        imageURL: imageURL ?? this.imageURL,
        baseURL: baseURL ?? this.baseURL);
  }

  factory ItemCategoryModel.fromMap(Map<String, dynamic> json) =>
      ItemCategoryModel(
          name: json['name'],
          imageURL: json['imageURL'],
          baseURL: json['baseURL']);

  Map<String, dynamic> toJson() =>
      {'name': name, 'imageURL': imageURL, 'baseURL': baseURL};

  @override
  List<Object?> get props => [name, imageURL, baseURL];
}
