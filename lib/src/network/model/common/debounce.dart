import 'dart:async';
import 'package:flutter/widgets.dart';

class Debounce {
  final Duration delay;
  VoidCallback? action;

  Timer? _timer;

  Debounce(this.delay);

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(delay, action);
  }
}
