
import 'dart:ui';
import 'package:purplecaredocs/components/size_config.dart';
import 'package:purplecaredocs/components/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class MyTextField extends StatelessWidget
{
  final String hintText;
  final String textSuffix;
  final TextEditingController controller;
  final bool enabled;
  final FontWeight fontWeight;
  final double textSize;
  final Icon icon;
  final VoidCallback onIconPressed;
  final int maxLines;
  final bool obscureText;
  final Color textColor;
  final Color hintColor;
  final Widget bottomSheetWidget;
  final bool underlined;
  final bool autofocus;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Function(String) onChanged;

  MyTextField({this.hintText = "", this.controller, this.enabled = true,
    this.fontWeight = FontWeight.w700, this.textSize, this.textColor = Colors.black,
    this.icon = null, this.onIconPressed = null, this.textSuffix = '', this.maxLines = 1,
    this.bottomSheetWidget, this.onChanged, this.obscureText = false, this.underlined = true,
    this.hintColor = Colors.black, this.autofocus = false, this.focusNode = null,
    this.textInputType = TextInputType.text, this.textInputAction = TextInputAction.next, this.nextFocusNode});

  @override
  Widget build(BuildContext context)
  {
    if (underlined)
    {
      return TextFormField(
        readOnly: !enabled,
        autofocus: autofocus,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: textInputType == TextInputType.number ? Platform.isIOS ? TextInputType.text : textInputType : textInputType,
        onFieldSubmitted: (v)
        {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
        style: TextStyle(
          color: textColor,
          fontSize: SizeConfig.safeBlockHorizontal * 3.8,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Styles.textfield_underline,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Styles.textfield_underline,
            ),
          ),
          hintText: hintText,
          focusColor: Styles.registration_email_black,
          enabled: enabled,
          labelStyle: TextStyle(
            color: textColor,
            fontSize: SizeConfig.safeBlockHorizontal * 3.8,
            fontWeight: FontWeight.w700,
          ),
          hintStyle: TextStyle(
              color: hintColor,
              fontSize: SizeConfig.safeBlockHorizontal * 3.8,
              fontWeight: FontWeight.w700
          ),
          suffixIcon: icon != null ? IconButton(
              icon: icon,
              onPressed: onIconPressed != null ? onIconPressed : null
          ) : Text(''),
        ),
        maxLines: maxLines,
        autocorrect: false,
      );
    }

    return TextFormField(
      readOnly: !enabled,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: textInputType == TextInputType.number ? Platform.isIOS ? TextInputType.text : textInputType : textInputType,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        focusColor: Styles.registration_email_black,
        enabled: enabled,
        labelStyle: TextStyle(
            color: textColor,
            fontSize: SizeConfig.safeBlockHorizontal * 3.8,
            fontWeight: FontWeight.w700
        ),
        hintStyle: TextStyle(
            color: hintColor,
            fontSize: SizeConfig.safeBlockHorizontal * 3.8,
            fontWeight: FontWeight.w700
        ),
        suffixIcon: icon != null ? IconButton(
            icon: icon,
            onPressed: onIconPressed != null ? onIconPressed : null
        ) : Text(''),
      ),
      maxLines: maxLines,
      autocorrect: false,
    );
  }
}

class TimeTextFormatter extends TextInputFormatter
{
  bool withSeconds;

  TimeTextFormatter({this.withSeconds = false});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    //this fixes backspace bug
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    String dateText = withSeconds ? _addSecondSeperators(newValue.text, ':') : _addSeperators(newValue.text, ':');

    int len = withSeconds ? 5 : 2;

    try {
      if (dateText.substring(dateText.indexOf(":") + 1).length > len) {
        dateText = dateText.substring(0, dateText.indexOf(":") + (len + 1));
      }
    } catch (e) {

    }

    return newValue.copyWith(
        text: dateText,
        selection: updateCursorPosition(dateText)
    );
  }

  String _addSecondSeperators(String value, String seperator)
  {
    value = value.replaceAll(':', '');

    String newString = '';

    for (int i = 0; i < value.length; i++)
    {
      newString += value[i];

      if (i == 0)
      {
        if (newString == "3" || newString == "4" || newString == "5" || newString == "6" || newString == "7"
            || newString == "8" || newString == "9")
        {
          newString += seperator;
        }
      }

      if ((i == 1 || i == 3) && (newString[0] == "0" || newString[0] == "1" || newString[0] == "2"))
      {
        newString += seperator;
      }
    }

    return newString;
  }

  String _addSeperators(String value, String seperator)
  {
    value = value.replaceAll(':', '');

    String newString = '';

    for (int i = 0; i < value.length; i++)
    {
      newString += value[i];

      if (i == 0)
      {
        if (newString == "3" || newString == "4" || newString == "5" || newString == "6" || newString == "7"
            || newString == "8" || newString == "9")
        {
          newString += seperator;
        }
      }

      if (i == 1 && (newString[0] == "0" || newString[0] == "1" || newString[0] == "2"))
      {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

class DateTextFormatter extends TextInputFormatter
{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    //this fixes backspace bug
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    String dateText = _addSeperators(newValue.text, '/');

    if (dateText.length > 10) {
      dateText = dateText.substring(0, 10);
    }

    return newValue.copyWith(
        text: dateText,
        selection: updateCursorPosition(dateText)
    );
  }

  String _addSeperators(String value, String seperator)
  {
    value = value.replaceAll('/', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 1) {
        newString += seperator;
      }
      if (i == 3) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

class DateTextField extends StatelessWidget
{
  final String hintText;
  final String textSuffix;
  final TextEditingController controller;
  final bool enabled;
  final FontWeight fontWeight;
  final double textSize;
  final Icon icon;
  final VoidCallback onIconPressed;
  final int maxLines;
  final bool obscureText;
  final Color textColor;
  final Color hintColor;
  final Widget bottomSheetWidget;
  final bool underlined;
  final bool autofocus;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Function(String) onChanged;

  DateTextField({
    this.hintText = "",
    this.textSuffix = '',
    this.controller,
    this.enabled = true,
    this.obscureText = false,
    this.autofocus = false,
    this.underlined = true,
    this.maxLines = 1,
    this.fontWeight = FontWeight.w700,
    this.textSize,
    this.textColor = Colors.black,
    this.hintColor = Colors.black,
    this.icon = null,
    this.onIconPressed = null,
    this.focusNode = null,
    this.textInputType = TextInputType.datetime,
    this.textInputAction = TextInputAction.next,
    this.nextFocusNode,
    this.onChanged,
    this.bottomSheetWidget
  });

  @override
  Widget build(BuildContext context)
  {
    if (underlined)
    {
      return TextFormField(
        autofocus: autofocus,
        controller: controller,
        inputFormatters: [DateTextFormatter()],
        onChanged: (newText)
        {
          onChanged(newText);
        },
        obscureText: obscureText,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        onFieldSubmitted: (v)
        {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
        style: TextStyle(
          color: textColor,
          fontSize: SizeConfig.safeBlockHorizontal * 3.8,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Styles.textfield_underline,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Styles.textfield_underline,
            ),
          ),
          hintText: hintText,
          focusColor: Styles.registration_email_black,
          enabled: enabled,
          labelStyle: TextStyle(
            color: textColor,
            fontSize: SizeConfig.safeBlockHorizontal * 3.8,
            fontWeight: FontWeight.w700,
          ),
          hintStyle: TextStyle(
              color: hintColor,
              fontSize: SizeConfig.safeBlockHorizontal * 3,
              fontWeight: FontWeight.w700
          ),
          suffixIcon: icon != null ? IconButton(
              icon: icon,
              onPressed: onIconPressed != null ? onIconPressed : null
          ) : Text(''),
        ),
        maxLines: maxLines,
        autocorrect: false,
      );
    }

    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        focusColor: Styles.registration_email_black,
        enabled: enabled,
        labelStyle: TextStyle(
            color: textColor,
            fontSize: SizeConfig.safeBlockHorizontal * 3.8,
            fontWeight: FontWeight.w700
        ),
        hintStyle: TextStyle(
            color: hintColor,
            fontSize: SizeConfig.safeBlockHorizontal * 3.8,
            fontWeight: FontWeight.w700
        ),
        suffixIcon: icon != null ? IconButton(
            icon: icon,
            onPressed: onIconPressed != null ? onIconPressed : null
        ) : Text(''),
      ),
      maxLines: maxLines,
      autocorrect: false,
    );
  }
}

class TimeTextField extends StatelessWidget
{
  final String hintText;
  final String textSuffix;
  final TextEditingController controller;
  final bool enabled;
  final FontWeight fontWeight;
  final double textSize;
  final Icon icon;
  final VoidCallback onIconPressed;
  final int maxLines;
  final bool obscureText;
  final Color textColor;
  final Color hintColor;
  final Widget bottomSheetWidget;
  final bool underlined;
  final bool autofocus;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Function(String) onChanged;
  final List<TextInputFormatter> inputFormatters;

  TimeTextField({this.hintText = "", this.controller, this.enabled = true,
    this.fontWeight = FontWeight.w700, this.textSize, this.textColor = Colors.black,
    this.icon = null, this.onIconPressed = null, this.textSuffix = '', this.maxLines = 1,
    this.bottomSheetWidget, this.onChanged, this.obscureText = false, this.underlined = true,
    this.hintColor = Colors.black, this.autofocus = false, this.focusNode = null,
    this.textInputType = TextInputType.datetime, this.textInputAction = TextInputAction.next, this.nextFocusNode,
    this.inputFormatters});

  @override
  Widget build(BuildContext context)
  {
    if (underlined)
    {
      return TextFormField(
        autofocus: autofocus,
        controller: controller,
        inputFormatters: inputFormatters == null ? [TimeTextFormatter()] : inputFormatters,
        onChanged: (newText)
        {
          onChanged(newText);
        },
        obscureText: obscureText,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        onFieldSubmitted: (v)
        {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
        style: TextStyle(
          color: textColor,
          fontSize: SizeConfig.safeBlockHorizontal * 3.8,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Styles.textfield_underline,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Styles.textfield_underline,
            ),
          ),
          hintText: hintText,
          focusColor: Styles.registration_email_black,
          enabled: enabled,
          labelStyle: TextStyle(
            color: textColor,
            fontSize: SizeConfig.safeBlockHorizontal * 3.8,
            fontWeight: FontWeight.w700,
          ),
          hintStyle: TextStyle(
              color: hintColor,
              fontSize: SizeConfig.safeBlockHorizontal * 3.8,
              fontWeight: FontWeight.w700
          ),
          suffixIcon: icon != null ? IconButton(
              icon: icon,
              onPressed: onIconPressed != null ? onIconPressed : null
          ) : Text(''),
        ),
        maxLines: maxLines,
        autocorrect: false,
      );
    }

    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        focusColor: Styles.registration_email_black,
        enabled: enabled,
        labelStyle: TextStyle(
            color: textColor,
            fontSize: SizeConfig.safeBlockHorizontal * 3.8,
            fontWeight: FontWeight.w700
        ),
        hintStyle: TextStyle(
            color: hintColor,
            fontSize: SizeConfig.safeBlockHorizontal * 3.8,
            fontWeight: FontWeight.w700
        ),
        suffixIcon: icon != null ? IconButton(
            icon: icon,
            onPressed: onIconPressed != null ? onIconPressed : null
        ) : Text(''),
      ),
      maxLines: maxLines,
      autocorrect: false,
    );
  }
}