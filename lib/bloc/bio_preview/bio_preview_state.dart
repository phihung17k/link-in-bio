import 'package:equatable/equatable.dart';
import '../../models/item_model.dart';

class BioPreviewState extends Equatable {
  final List<ItemModel>? items;

  const BioPreviewState({required this.items});

  BioPreviewState copyWith({List<ItemModel>? items}) {
    return BioPreviewState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}
