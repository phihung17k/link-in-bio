import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(State initialState) : super(initialState);

  final StreamController<dynamic> _controller = StreamController.broadcast();

  Stream<dynamic> get listenerStream => _controller.stream;

  void addNavigatedEvent(dynamic event) {
    _controller.sink.add(event);
  }
}
