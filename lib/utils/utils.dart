


import 'package:flutter/material.dart';

class Utils {
  static const endPoint = "https://purplecaredocs.herokuapp.com/";
  static const headers = {"Content-Type": "application/json"};
  static String wsLink = "";
  static const String ONE_SIGNAL_KEY = "5ab61ad5-9c66-4f36-9c15-9da40581f2d7";

  static bool isLangSupported(String languageCode)
  {
    return ['en', 'it', 'pl', 'de', 'fr', 'es'].contains(languageCode);
  }

  static void goToPage(BuildContext context, Widget widgetToOpen, bool mantainNavStack)
  {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context)
        => widgetToOpen), (Route<dynamic> route) => mantainNavStack);
  }

}