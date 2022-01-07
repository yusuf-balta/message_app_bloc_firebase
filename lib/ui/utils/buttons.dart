import 'package:flutter/material.dart';

class Buttons {
  Buttons._();

  static Widget elevatedButton({Function()? onPressed, Widget? child}) {
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}
