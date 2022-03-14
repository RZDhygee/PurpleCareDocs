

import 'package:flutter/material.dart';
import 'package:purplecaredocs/components/buttons.dart';
import 'package:purplecaredocs/components/settings.dart';
import 'package:purplecaredocs/components/size_config.dart';
import 'package:purplecaredocs/components/styles.dart';
import 'package:purplecaredocs/home/homepage.dart';
import 'package:purplecaredocs/language/language.dart';
import 'package:purplecaredocs/utils/utils.dart';

import 'login.dart';

class RegistrationWidget extends StatelessWidget{

  void initLink(BuildContext context)
  {
    if (AppLocalizations.languageCode != null) return;

    String langCodeTelefono = AppLocalizations.of(context).locale.languageCode;

    if (langCodeTelefono == 'en' || !Utils.isLangSupported(langCodeTelefono))
    {
      Utils.wsLink = Utils.endPoint;
    }
    else
    {
      Utils.wsLink = Utils.endPoint + langCodeTelefono + '/';
    }

    print("Sono dentro initLink di RegistrationWidget, ho inizializzato il link: ${Utils.wsLink}");
  }

  void goToLogin(BuildContext context)
  {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginWidget()));
  }

  void goToCountrySteps(BuildContext context)
  {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => StepCountryWidget()));
  }


  @override
  Widget build(BuildContext context) {

    AppLocal.init(context);
    SizeConfig.init(context);
    initLink(context);

      return Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                children: <Widget> [
                  SizedBox(height: SizeConfig.safeBlockVertical *30),
                  Container(
                    width: SizeConfig.safeBlockHorizontal *60,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical*5),
                  Padding(padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal *15,
                          right: SizeConfig.safeAreaHorizontal * 15),
                    child: Text(
                      AppLocal.get("registration"),
                      style: TextStyle(
                        color: Styles.registration_grey,
                        fontSize: SizeConfig.safeBlockHorizontal *4
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 5),
                  PurpleButton(text: AppLocal.get("registration_register"),onPressed: ()=> this.goToCountrySteps(context),),
                  SizedBox(height: SizeConfig.safeBlockVertical*2.5),
                  BorderedButton(text: AppLocal.get("registration_login"),onPressed: () =>this.goToLogin(context),),
                  if (Settings.debug) Text(
                    Utils.wsLink,
                    style: TextStyle(
                      color: Styles.primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 24
                    ),
                  )
                ],
              ),
            ),
            SafeArea(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Image.asset("assets/images/dhygee-legal.png"),
                    ),
                  ),
                )
            )
          ],
        ),
      );
  }
}