import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:purplecaredocs/authentication/registration.dart';
import 'package:purplecaredocs/components/middleware.dart';
import 'package:purplecaredocs/components/utily.dart';
import 'package:purplecaredocs/intro/intro.dart';
import 'package:purplecaredocs/language/language.dart';
import 'package:purplecaredocs/utils/notifications.dart';
import 'dart:io' show Platform;

import 'package:purplecaredocs/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication/login.dart';
import 'components/settings.dart';

GetIt locator = GetIt();

void initOneSignalSettings() async{
  if (Platform.isAndroid)
    {
      OneSignal.shared.init(Utils.ONE_SIGNAL_KEY);
    }
  else if (Platform.isIOS)
    {
      OneSignal.shared.init(
        Utils.ONE_SIGNAL_KEY,
        iOSSettings:
          {
            OSiOSSettings.autoPrompt: false,
            OSiOSSettings.inAppLaunchUrl: true
          });
      OneSignal.shared.promptUserForPushNotificationPermission();

      bool allowed = await OneSignal.shared.promptUserForPushNotificationPermission();

      print('initOneSignal(): here I get there with allowed= $allowed');

      if (Platform.isIOS)
      {
        OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) async
        {
          var status = await OneSignal.shared.getPermissionSubscriptionState();

          var playerId = status.subscriptionStatus.userId;
          NotificationsSettings.playerId = playerId;

          OneSignal.shared.setInFocusDisplayType(
              OSNotificationDisplayType.notification);
        });
      }
    }
  var status = await OneSignal.shared.getPermissionSubscriptionState();

  var playerId = status.subscriptionStatus.userId;
  NotificationsSettings.playerId = playerId;

  print("#######################################");
  print('PlayerId: ${NotificationsSettings.playerId}');
  print("#######################################");

  OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initSharedPreferences();
  setuplocator();

}

void setuplocator(){
  locator.registerLazySingleton(() => NavigationService());
}

void initSharedPreferences() async{
  FlutterSecureStorage storage;
  final prefs = await SharedPreferences.getInstance();

  if (prefs.getBool('first_run') ?? true)
    {
      try{
        storage = FlutterSecureStorage();
        await storage.deleteAll();
      } catch(e){
        print(e);
      }

      prefs.setBool('first_run', false);

      SecureStorageData.data = Map();

      runApp(MyApp(true));
    }
  else
    {
      try{
        storage = FlutterSecureStorage();
        storage.readAll().then((map) {
          runApp(MyApp(SecureStorageData.data["first_access"] == null));
        });
      } catch(e){
        runApp(MyApp(SecureStorageData.data["first_access"] == null));
      }
      }
}


class MyApp extends StatelessWidget
{

  bool firstAccess;
  MyApp(this.firstAccess);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    initOneSignalSettings();

    return new MaterialApp(
      debugShowCheckedModeBanner: Settings.debug,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('it', 'IT'),
        Locale('pl', 'PL'),
        Locale('de', 'DE'),
        Locale('fr', 'FR'),
        Locale('es', 'ES'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      title:'Purple Care' ,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Avenir'
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: firstAccess?
          IntroWidget() :
          SecureStorageData.data["email"] != null && SecureStorageData.data["email"] != "" &&
          SecureStorageData.data["password"] != null && SecureStorageData.data["password"] != "" ?
              LoginWidget(): RegistrationWidget()
    );
  }
}

