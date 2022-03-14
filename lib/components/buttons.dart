import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:purplecaredocs/components/size_config.dart';
import 'package:purplecaredocs/components/styles.dart';


class PurpleButton extends StatelessWidget
{
  final String text;
  final VoidCallback onPressed;
  final int widthPercentage;
  final Color backgroundColor;
  final Color textColor;
  final bool enabled;

  PurpleButton({this.text = "Text", this.onPressed, this.widthPercentage = 80,
    this.backgroundColor = Styles.primaryColor, this.textColor = Colors.white,
    this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig.safeBlockHorizontal * widthPercentage,
        height: SizeConfig.safeBlockVertical * 6,
        child: FlatButton(
            onPressed: onPressed,
            color: enabled ? backgroundColor : backgroundColor.withAlpha(100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            textColor: Colors.white,
            child: Text(
              text,
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                  fontWeight: FontWeight.w700,
                  color: textColor
              ),
              textAlign: TextAlign.center,
            )
        )
    );
  }
}

class BorderedButton extends StatelessWidget
{
  final String text;
  final VoidCallback onPressed;
  final int widthPercentage;
  final double heightPercentage;
  final Color borderColor;
  final Color textColor;

  BorderedButton({this.text = "Text", this.onPressed, this.widthPercentage = 80, this.heightPercentage = 6,
    this.borderColor = Styles.primaryColor, this.textColor = Styles.primaryColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.safeBlockHorizontal * widthPercentage,
      height: SizeConfig.safeBlockVertical * heightPercentage,
      child: OutlineButton(
        child: Text(
          text,
          style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
              color: textColor,
              fontWeight: FontWeight.w700
          ),
          textAlign: TextAlign.center,
        ),
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
        borderSide: BorderSide(
          color: borderColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}