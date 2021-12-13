import 'dart:math';

import 'package:flutter/material.dart';

class Size {
  double? _screenHeight;
  double? _screenWidth;
  static const double modelHeight = 800;
  static const double modelWidth = 428;
  final BuildContext _context;
  final BoxConstraints _constrain;
  Size(this._context,
      [this._constrain = const BoxConstraints(maxHeight: 1, maxWidth: 1)]);

  double get constrainMaxHeight {
    return _constrain.maxHeight == 1 ? screenHeight() : _constrain.maxHeight;
  }

  double get constrainMaxWidth {
    return _constrain.maxWidth == 1 ? screenWidth() : _constrain.maxWidth;
  }

  double screenHeight() {
    _screenHeight ??= MediaQuery.of(_context).size.height +
        MediaQuery.of(_context).padding.top;
    return _screenHeight ?? 1;
  }

  double screenWidth() {
    _screenWidth ??= MediaQuery.of(_context).size.width;
    return _screenWidth ?? 1;
  }

  double height(double number) {
    double result = constrainMaxHeight * (number / modelHeight);
    return result;
  }

  double width(double number) {
    double _screenWidth = constrainMaxWidth;
    return _screenWidth * (number / modelWidth);
  }

  List<int> statusDash(
      {required int dashNumber,
      required double radius,
      required double maxSpace}) {
    int space = _space(dashNumber, maxSpace, radius);
    double result = _circumference(radius) - (space * dashNumber);
    return [result ~/ dashNumber, space];
  }

  int _space(int number, double max, double radius) {
    max = height(max);
    if (number == 1) {
      return 0;
    } else if ((number * max) < _circumference(radius) / 3) {
      return max.toInt();
    } else {
      int temp = 1;
      while ((max / temp) * number > (_circumference(radius) / 3)) {
        ++temp;
      }
      double result = (max / temp);
      return height(result).toInt();
    }
  }

  double _circumference(double radius) {
    double result = height(radius) * 2 * pi;
    return result;
  }

  double circle(double number) {
    double result = height(number * 2);
    return result;
  }
}
