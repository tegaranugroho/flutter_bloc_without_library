import 'package:flutter/material.dart';
import 'dart:async';

enum ColorEvent { to_amber, to_blue }

class ColorBLoc {
  Color _color = Colors.amber;

  StreamController<ColorEvent> _eventController =
      StreamController<ColorEvent>();
  StreamSink<ColorEvent> get eventSink => _eventController.sink;

  StreamController<Color> _stateController = StreamController<Color>();
  StreamSink<Color> get _stateSink => _stateController.sink;
  Stream<Color> get stateStream => _stateController.stream;

  void _mapEventToState(ColorEvent colorEvent) {
    if (colorEvent == ColorEvent.to_amber)
      _color = Colors.amber;
    else
      _color = Colors.blue;

    _stateSink.add(_color);
  }

  ColorBLoc() {
    _eventController.stream.listen(_mapEventToState);
  }
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
