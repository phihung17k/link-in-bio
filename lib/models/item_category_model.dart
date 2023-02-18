import 'package:equatable/equatable.dart';

class ItemCategoryModel extends Equatable {
  final int? index;
  final String? name;
  final String? imageURL;
  final String? baseURL;
  final String? url;

  const ItemCategoryModel(
      {this.index, this.name, this.imageURL, this.baseURL, this.url});

  ItemCategoryModel copyWith(
      {int? index,
      String? name,
      String? imageURL,
      String? baseURL,
      String? url}) {
    return ItemCategoryModel(
        index: index ?? this.index,
        name: name ?? this.name,
        imageURL: imageURL ?? this.imageURL,
        baseURL: baseURL ?? this.baseURL,
        url: url ?? this.url);
  }

  @override
  List<Object?> get props => [index, name, imageURL, baseURL, url];
}
