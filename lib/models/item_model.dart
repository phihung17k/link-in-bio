import 'package:equatable/equatable.dart';
import 'models.dart';

class ItemModel extends Equatable {
  final String? name;
  final ItemCategoryModel? category;
  final UrlModel? url;
  final SmsModel? sms;
  final PhoneModel? phone;
  final EmailModel? email;
  final WifiModel? wifi;

  const ItemModel(
      {this.name,
      this.category,
      this.url,
      this.sms,
      this.phone,
      this.email,
      this.wifi});

  ItemModel copyWith(
      {String? name,
      ItemCategoryModel? category,
      UrlModel? url,
      SmsModel? sms,
      PhoneModel? phone,
      EmailModel? email,
      WifiModel? wifi}) {
    return ItemModel(
        name: name ?? this.name,
        category: category ?? this.category,
        url: url ?? this.url,
        sms: sms ?? this.sms,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        wifi: wifi ?? this.wifi);
  }

  factory ItemModel.fromMap(Map<String, dynamic> json) => ItemModel(
      name: json['name'],
      category: ItemCategoryModel.fromMap(json['category']),
      url: json['url']);

  Map<String, dynamic> toJson() =>
      {'name': name, 'category': category?.toMap(), 'url': url};

  @override
  List<Object?> get props => [name, category, url, sms, phone, email, wifi];
}
