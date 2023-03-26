import 'package:link_in_bio/models/item_model.dart';

abstract class BioPreviewEvent {}

class LoadingBioDataEvent extends BioPreviewEvent {
  final List<ItemModel> items;

  LoadingBioDataEvent(this.items);
}

class FailLaunchUrlEvent extends BioPreviewEvent {
  final Uri uri;

  FailLaunchUrlEvent(this.uri);
}
