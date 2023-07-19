import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeData? themeData;

  const ThemeState({this.themeData});

  ThemeState copyWith({ThemeData? themeData}) {
    return ThemeState(themeData: themeData ?? this.themeData);
  }

  @override
  List<Object?> get props => [themeData];
}
