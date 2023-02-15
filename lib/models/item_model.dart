import 'package:equatable/equatable.dart';

class ItemModel extends Equatable {
  final String? name;
  final String? category; // path
  final String? url;

  const ItemModel({this.name, this.category, this.url});

  ItemModel copyWith({String? name, String? category, String? url}) {
    return ItemModel(
        name: name ?? this.name,
        category: category ?? this.category,
        url: url ?? this.url);
  }

  @override
  List<Object?> get props => [name, category, url];
}
