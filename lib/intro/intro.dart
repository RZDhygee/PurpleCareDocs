import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:purplecaredocs/authentication/registration.dart';
import 'package:purplecaredocs/components/size_config.dart';
import 'package:purplecaredocs/components/styles.dart';
import 'package:purplecaredocs/home/homepage.dart';
import 'package:purplecaredocs/language/language.dart';
import 'package:purplecaredocs/utils/utils.dart';

class IntroWidget extends StatefulWidget
{
  @override
  State<IntroWidget> createState() => IntroWidgetState();
}

class IntroWidgetState extends State <IntroWidget> {

  int _page =0;

  @override
  void initState(){
    final storage = new FlutterSecureStorage();
    storage.write(key: "first_access", value: "false");

    super.initState();
  }

  void initLink(BuildContext context){

    String langCodePhone = AppLocalizations.of(context).locale.languageCode;

    if (langCodePhone == 'en' || !Utils.isLangSupported(langCodePhone))
    {
      Utils.wsLink = Utils.endPoint;
    }
    else
    {
      Utils.wsLink = Utils.endPoint + langCodePhone + '/';
    }

    print("I am inside the initLink of LoginWidget, I have initialized the link: ${Utils.wsLink}");
  }


  @override
  Widget build(BuildContext context) {

    AppLocal.init(context);
    SizeConfig.init(context);
    initLink(context);

      return Scaffold(
        body: Container(
          width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-4,-4),
                end: Alignment(1,1),
                stops: [
                  0,
                  1
                ],
                colors: [
                  Styles.accentColor,
                  Styles.primaryColor
                ],
              ),
            ),
          child: Column(
            children: <Widget> [
              SizedBox(
                height: SizeConfig.safeBlockVertical * 9),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:<Widget> [
                  GestureDetector(
                    child: Row(
                      children: <Widget> [
                        Text(
                          AppLocal.get("intro_skip"),
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          RegistrationWidget()), (Route<dynamic> route) => false);
                    },
                  ),
                  SizedBox(width: SizeConfig.safeBlockHorizontal *4)
                  ],
              ),
                  SizedBox(height: SizeConfig.safeBlockVertical*20),
                  Container(
                    height: SizeConfig.safeBlockVertical * 55,
                    child: PageView(
                      children: <Widget>[
                        _IntroItemWidget(
                            "assets/images/razzo.png",
                            AppLocal.get("intro_1"),
                            AppLocal.get("intro_1sub"),
                            Platform.isAndroid
                        ),
                        _IntroItemWidget(
                            "assets/images/sveglia.png",
                            AppLocal.get("intro_2"),
                            AppLocal.get("intro_2sub"),
                            false
                        ),
                        _IntroItemWidget(
                            "assets/images/report.png",
                            AppLocal.get("report_reports"),
                            AppLocal.get("intro_3sub"),
                            false
                        ),
                        _IntroItemWidget(
                            "assets/images/chat.png",
                            AppLocal.get("intro_4"),
                            AppLocal.get("intro_4sub"),
                            false
                        )
                      ],
                      onPageChanged: (newPage) {
                        setState(() {
                          _page = newPage;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical*8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: _page == 0 ? 22 : 8,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: _page == 0 ? Colors.white : Colors.white54
                        ),
                      ),
                      Container(
                        width: _page == 1 ? 22 : 8,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: _page == 1 ? Colors.white : Colors.white54
                        ),
                      ),
                      Container(
                        width: _page == 2 ? 22 : 8,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: _page == 2 ? Colors.white : Colors.white54
                        ),
                      ),
                      Container(
                        width: _page == 3 ? 22 : 8,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: _page == 3 ? Colors.white : Colors.white54
                        ),
                      )
                    ],
                  )
                ],
              )

          ),

      );
  }
}



class _IntroItemWidget extends StatelessWidget{

  String _imageAssetString;
  String _title;
  String _subtitle;
  bool _mustAddTestText;
  _IntroItemWidget(this._imageAssetString, this._title, this._subtitle, this._mustAddTestText);

  @override
  Widget build(BuildContext context) {

    SizeConfig.init(context);

    return Container(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Container(
            height: SizeConfig.safeBlockVertical*25,
            child: Image.asset(_imageAssetString),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical *15),
          Text(
            _title,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.safeBlockHorizontal *7,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical*0.75),
          Container(
            width: SizeConfig.safeBlockHorizontal*80,
            child: Text(
              _subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.safeBlockHorizontal*3.8,
                fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

}







