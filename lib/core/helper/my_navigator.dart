import 'package:flutter/material.dart';

enum NavigatorState { push, pushReplace, pushRemove }

Future<T?> goTo<T>(
  context, {
  required Widget page,
  NavigatorState state = NavigatorState.push,
})async {
  var pageRoute = MaterialPageRoute<T>(builder: (context) => page);

  switch (state) {
    case NavigatorState.push:
      return Navigator.push<T>(context, pageRoute);
    case NavigatorState.pushReplace:
      return Navigator.pushReplacement(context, pageRoute);
    case NavigatorState.pushRemove:
      return Navigator.pushAndRemoveUntil<T>(context, pageRoute, (r) => false);

  }
}
