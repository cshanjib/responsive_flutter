import 'package:flutter/material.dart';
import 'package:responsive_flutter/login.dart';

class DialogUtil {

  static Future openLoginPopup(BuildContext context, {dismissible: false}) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext dialogContext) {
        return WillPopScope(
          onWillPop: () async => dismissible,
          child: Dialog(
              insetPadding: EdgeInsets.all(10),
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: LoginForm()),
        );
      },
    );
  }
}
