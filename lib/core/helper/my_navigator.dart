import 'package:flutter/material.dart';

enum MyNavigatorState { push, pushReplace, pushRemove }

Future<T?> goTo<T>(
  context, {
  required Widget page,
  MyNavigatorState state = MyNavigatorState.push,
})async {
  var pageRoute = MaterialPageRoute<T>(builder: (context) => page);

  switch (state) {
    case MyNavigatorState.push:
      return Navigator.push<T>(context, pageRoute);
    case MyNavigatorState.pushReplace:
      return Navigator.pushReplacement(context, pageRoute);
    case MyNavigatorState.pushRemove:
      return Navigator.pushAndRemoveUntil<T>(context, pageRoute, (r) => false);

  }
}
