import 'package:equatable/equatable.dart';
import 'package:link_in_bio/models/item_category_model.dart';

class ItemModel extends Equatable {
  // String? id;
  final String? name;
  final ItemCategoryModel? category;
  final String? url;

  const ItemModel({this.name, this.category, this.url});

  ItemModel copyWith({String? name, ItemCategoryModel? category, String? url}) {
    return ItemModel(
        name: name ?? this.name,
        category: category ?? this.category,
        url: url ?? this.url);
  }

  @override
  List<Object?> get props => [name, category, url];
}
