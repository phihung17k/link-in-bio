import 'package:equatable/equatable.dart';
import 'package:link_in_bio/models/data_model.dart';
import 'item_category_model.dart';

class ItemModel extends Equatable {
  final String? name;
  final ItemCategoryModel? category;
  final UrlModel? url;
  final SmsModel? sms;

  const ItemModel({this.name, this.category, this.url, this.sms});

  ItemModel copyWith(
      {String? name,
      ItemCategoryModel? category,
      UrlModel? url,
      SmsModel? sms}) {
    return ItemModel(
        name: name ?? this.name,
        category: category ?? this.category,
        url: url ?? this.url,
        sms: sms ?? this.sms);
  }

  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
      name: json['name'],
      category: ItemCategoryModel.fromMap(json['category']),
      url: json['url']);

  Map<String, dynamic> toJson() =>
      {'name': name, 'category': category?.toJson(), 'url': url};

  @override
  List<Object?> get props => [name, category, url, sms];
}
