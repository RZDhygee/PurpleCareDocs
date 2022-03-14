import 'package:flutter/widgets.dart';

class SizeConfig
{
  static MediaQueryData _mediaQueryData;

  static double paddingBottom;

  static double screenWidth;
  static double screenHeight;

  static double safeScreenWidth;
  static double safeScreenHeight;

  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double safeAreaHorizontal;
  static double safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  static void init(BuildContext context)
  {
    _mediaQueryData = MediaQuery.of(context);

    paddingBottom = _mediaQueryData.padding.bottom;

    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - safeAreaVertical) / 100;

    safeScreenWidth = screenWidth - safeAreaHorizontal;
    safeScreenHeight = screenHeight - safeAreaVertical;
  }
}