import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dialogs {
  Dialogs._();

  static Widget loadingDialog(Size size) {
    return AlertDialog(
      content: Container(
        height: size.width * 0.5,
        width: size.width * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  static Widget onWillPop(BuildContext context) {
    return AlertDialog(
      title: new Text('Uyarı'),
      content: new Text('Uygulamadan çık'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text('Hayır'),
        ),
        TextButton(
          onPressed: () => SystemNavigator.pop(),
          child: new Text('Evet'),
        ),
      ],
    );
  }

  static Widget sucssesDialog(
      {required Widget content,
      required BuildContext context,
      required Function() onPressed}) {
    return AlertDialog(
      title: Text('Başarılı'),
      content: content,
      actions: [TextButton(onPressed: onPressed, child: Text('Tamam'))],
    );
  }

  static Widget errorDialog(
      {required Widget content, required BuildContext context}) {
    return AlertDialog(
      title: Text('Başarısız'),
      content: content,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Tamam'))
      ],
    );
  }
}
