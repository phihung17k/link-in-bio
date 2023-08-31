import 'package:equatable/equatable.dart';
import 'models.dart';

class ItemModel extends Equatable {
  final int? id;
  final String? name;
  final ItemCategoryModel? category;
  final UrlModel? url;
  final SmsModel? sms;
  final PhoneModel? phone;
  final EmailModel? email;
  final WifiModel? wifi;

  const ItemModel(
      {this.id,
      this.name,
      this.category,
      this.url,
      this.sms,
      this.phone,
      this.email,
      this.wifi});

  ItemModel copyWith(
      {int? id,
      String? name,
      ItemCategoryModel? category,
      UrlModel? url,
      SmsModel? sms,
      PhoneModel? phone,
      EmailModel? email,
      WifiModel? wifi}) {
    return ItemModel(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        url: url ?? this.url,
        sms: sms ?? this.sms,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        wifi: wifi ?? this.wifi);
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) => ItemModel(
      id: map['id'],
      name: map['name'],
      category: ItemCategoryModel.fromMap(map['category']),
      url: map['url']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'item_category_id': category?.id,
        'url': url?.url,
        'phone_number': sms?.phoneNumber ?? phone?.phoneNumber,
        'message': sms?.message,
        'address': email?.address,
        'cc': email?.cc,
        'bcc': email?.bcc,
        'subject': email?.subject,
        'body': email?.body,
        'network_name': wifi?.networkName,
        'password': wifi?.password,
        'encryption': wifi?.encryption,
        'is_hidden': wifi?.isHidden ?? false,
      };

  @override
  List<Object?> get props => [id, name, category, url, sms, phone, email, wifi];
}
