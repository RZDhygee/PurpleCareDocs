
import 'package:flutter/material.dart';

class UserSession
{
  static String email = "";
  static String password = "";
  static String token = "";
}

class Utily
{
  static void showAlert(BuildContext context, String title, String content, String buttonText)
  {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            title: new Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            content: new Text(content),
            actions: <Widget>[
              //buttons at the bottom of the dialog
              new FlatButton(
                  child: new Text(
                    buttonText,
                    style: TextStyle(
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  )
            ],
          );
        });
  }
}