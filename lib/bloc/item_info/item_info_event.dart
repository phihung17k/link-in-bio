import 'package:equatable/equatable.dart';

abstract class ItemInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetItemEvent extends ItemInfoEvent {
  final String? name;
  final String? category;
  final String? url;
  final int? categoryIndex;

  SetItemEvent({this.name, this.category, this.url, this.categoryIndex});
}

class LoadingCategoryEvent extends ItemInfoEvent {}
