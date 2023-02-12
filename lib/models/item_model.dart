import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ItemModel extends Equatable {
  String? name;
  String? symbolPath;
  String? url;

  ItemModel({this.name, this.symbolPath, this.url});

  @override
  List<Object?> get props => [name, symbolPath, url];

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  //   if (other.runtimeType != runtimeType) return false;
  //   return other is ItemModel &&
  //       other.name == name &&
  //       other.symbolPath == symbolPath &&
  //       other.url == other.url;
  // }

  // @override
  // int get hashCode => Object.hash(name, symbolPath, url);
}
