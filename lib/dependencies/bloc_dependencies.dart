import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:link_in_bio/bloc/home/home_bloc.dart';
import 'package:link_in_bio/pages/pages.dart';
import 'package:link_in_bio/pages/qrcode_sharing_page.dart';
import 'package:link_in_bio/routes.dart';

class BlocDependencies {
  static Future setUp(GetIt injector) async {
    injector.registerFactory(() => HomeBloc());
  }
}
