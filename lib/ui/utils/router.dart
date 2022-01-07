import 'package:flutter/material.dart';

class Routter {
  Routter._();
  static pushReplacement(Widget widget, BuildContext context) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  static push(Widget widget, BuildContext context) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => widget));
  }
}
