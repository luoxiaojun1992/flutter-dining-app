import 'package:flutter/material.dart';

dialog(String title, String type,
    {String content,
    BuildContext context,
    String okText = 'ok',
    Function okCallback,
    String cancelText = 'cancel',
    Function cancelCallback}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      switch (type) {
        case 'alert':
          List<Widget> actions = [];

          if (okCallback != null) {
            actions.add(FlatButton(child: Text(okText), onPressed: okCallback));
          }

          if (cancelCallback != null) {
            actions.add(
                FlatButton(child: Text(cancelText), onPressed: cancelCallback));
          }

          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            content: Text(
              content,
              textAlign: TextAlign.center,
            ),
            actions: actions,
          );
        case 'simple':
          return SimpleDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
          );
      }
    },
  );
}

alert(String title, String content, BuildContext context,
    {String okText = 'ok',
    Function okCallback,
    String cancelText = 'cancel',
    Function cancelCallback}) {
  dialog(
    title,
    'alert',
    content: content,
    context: context,
    okText: okText,
    okCallback: okCallback,
    cancelText: cancelText,
    cancelCallback: cancelCallback,
  );
}

simpleWindow(
  title,
) {
  dialog(
    title,
    'simple',
  );
}
