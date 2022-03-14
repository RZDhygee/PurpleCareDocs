import 'package:flutter/material.dart';
import 'package:purplecaredocs/language/language.dart';


class AppLocal{
  static AppLocalizations appLocal;

  static String get(String str) => appLocal.get(str);

  static void init(BuildContext context)
  {
    if (appLocal == null)
    {
      appLocal = AppLocalizations.of(context);
    }
  }

}

class MyHomePage extends StatefulWidget
{


  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}