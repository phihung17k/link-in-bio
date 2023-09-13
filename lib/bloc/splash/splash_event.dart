import 'package:link_in_bio/models/item_model.dart';

abstract class SplashEvent {}

class InitialDataEvent extends SplashEvent {}

class NavigatorToHomePageEvent extends SplashEvent {
  final List<ItemModel> items;

  NavigatorToHomePageEvent(this.items);
}
