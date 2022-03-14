
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:purplecaredocs/authentication/registration.dart';
import 'package:purplecaredocs/components/buttons.dart';
import 'package:purplecaredocs/components/size_config.dart';
import 'package:purplecaredocs/components/textfields.dart';
import 'package:purplecaredocs/components/utily.dart';
import 'package:purplecaredocs/home/homepage.dart';
import 'package:purplecaredocs/utils/utils.dart';
import 'package:purplecaredocs/utils/utily.dart';
import 'package:http/http.dart' as http;

class LoginWidget extends StatefulWidget{

  String registrationEmail = "";
  String registrationPassword = "";

  LoginWidget({
    this.registrationEmail = "",
    this.registrationPassword = ""
  });

  @override
  _LoginWidgetState createState() => _LoginWidgetState(
      registrationEmail: registrationEmail,
      registrationPassword: registrationPassword
  );

}

class _LoginWidgetState extends State<LoginWidget> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  bool _rememberPassword = false;
  bool passwordVisible = false;

  String registrationEmail ="";
  String registrationPassword = "";


  _LoginWidgetState({this.registrationEmail, this.registrationPassword})

  {
  if (registrationEmail != "" && registrationPassword !="") {
  emailController.text = registrationEmail;
  passwordController.text = registrationPassword;
  } else
  {
  try {
    emailController.text = SecureStorageData.data["email"] == null ? "" : SecureStorageData.data["email"];
  } catch (e) {
    emailController.text = '';
  }
  try{
    passwordController.text = SecureStorageData.data["password"] == null ? "" : SecureStorageData.data["password"];
  } catch(e){
    passwordController.text ='';
  }
  }
  }

  void _doLogin(){
    String email = emailController.text.trim();
    String password = passwordController.text;

    if (email =="")
      {
        Utily.showAlert(context, AppLocal.get("registration_cred_wrong"), AppLocal.get("registration_mail"), AppLocal.get("popup_close"));
        return;
      }

    if (password =="")
    {
      Utily.showAlert(context, AppLocal.get("registration_cred_wrong"), AppLocal.get("registration_psw"), AppLocal.get("popup_close"));
      return;
    }

    http.post(
      Utils.wsLink + "users/auth",
      headers: {
        "Content-Type": "application/json"
      },
      body: {
        "email": emailController.text,
        "password": passwordController.text
      }
    ).then((response) async{
      var jsonResponse = json.decode(response.body);

      print(jsonResponse);

      if (jsonResponse["access_token"] != null)
        {
          UserSession.email=email;
          UserSession.password=password;
          UserSession.token=jsonResponse["access_token"];

          final storage = new FlutterSecureStorage();

          storage.write(key: "email", value: email);
          storage.write(key: "password", value: _rememberPassword ? password:"");

          SecureStorageData.data["email"] = email;
          SecureStorageData.data["password"]= password;


        }else {
        print ("Attention! jsonResponse [access_token] not present");
        Utily.showAlert(context, AppLocal.get('registration_cred_wrong'), AppLocal.get('login_cred_wrong'), AppLocal.get("popup_close"));
      }
    }).catchError((error){
      print("doLogin() => $error");
    });
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children:<Widget> [
                SizedBox(height: SizeConfig.safeBlockVertical * 20),
                Container(
                  width: SizeConfig.safeBlockHorizontal * 60,
                  child: Image.asset("assets/images/logo.png"),
                ),
                SizedBox(height: SizeConfig.safeBlockVertical*5),
                Padding(
                    padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical*3,
                      left: SizeConfig.safeBlockHorizontal*7,
                      right: SizeConfig.safeBlockHorizontal*7
                    ),
                  child: Column(
                    children: <Widget>[
                      MyTextField(
                        hintText: AppLocal.get("registration_email_field"),
                        controller: emailController,
                        focusNode: emailNode,
                        nextFocusNode: passwordNode,
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical*2),
                      MyTextField(
                        hintText: AppLocal.get("registration_psw_field"),
                        controller: passwordController,
                        focusNode: passwordNode,
                        nextFocusNode: FocusNode(),
                        textInputAction: TextInputAction.done,
                        obscureText: !passwordVisible,
                        icon: Icon(
                          passwordVisible
                          ? Icons.visibility :
                              Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onIconPressed: (){
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical*1),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal *3),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.black87,
                      value: _rememberPassword,
                      onChanged: (bool value){
                        setState(() {
                          _rememberPassword = value;
                        });
                      },
                    ),
                    Text(AppLocal.get("registration_remember")),
                  ],
                ),
                ),
                SizedBox(height: SizeConfig.safeBlockVertical *2.5,),
                Padding(padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 7,
                    bottom: SizeConfig.safeBlockVertical * 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      child: Text(
                        AppLocal.get("registration_forgot"),
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal*3.5,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: (){

                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: SizeConfig.screenHeight,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Padding(padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal * 10,
                    bottom: SizeConfig.paddingBottom == 0 ?
                    SizeConfig.safeBlockVertical * 3 : SizeConfig.paddingBottom,
                  ),
                  child: Container(
                    child: PurpleButton(text: AppLocal.get("registration_login"),
                    onPressed: () => _doLogin(),
                    ),
                  ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  color: Colors.black54,
                  onPressed: (){
                    Utils.goToPage(context, RegistrationWidget(), false);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}