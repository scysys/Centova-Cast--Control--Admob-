import 'package:flutter/material.dart';
import 'package:flutter_centovacast_api/widgets/NavDrawer.dart';
import 'package:flutter_centovacast_api/widgets/tabs/tab1.dart';
import 'package:flutter_centovacast_api/widgets/tabs/tab2.dart';
import 'package:flutter_centovacast_api/widgets/tabs/tab3.dart';
import 'package:flutter_centovacast_api/widgets/SharedPreferencesUtil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter_centovacast_api/widgets/localisation/AppLanguage.dart';
import 'package:flutter_centovacast_api/widgets/localisation/AppLocalizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();

  await StorageUtil.getInstance();
  await Firebase.initializeApp();

  FirebaseAnalytics();

  Admob.initialize();

  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  MyApp({this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return OKToast(
            child: MaterialApp(

              locale: model.appLocal,

              supportedLocales: [
                Locale('en', ''),
                Locale('de', ''),
              ],

              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],

              title: 'Centova Cast: Control',

              theme: new ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.blue,
                primaryColor: const Color(0xFF212121),
                accentColor: const Color(0xFF64ffda),
                canvasColor: const Color(0xFF303030),
              ),
              home: new MyHomePage(),

            )
        );
      }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.filter_drama), text: AppLocalizations.of(context).translate('nav_server')),
              Tab(icon: Icon(Icons.music_note), text: AppLocalizations.of(context).translate('nav_autodj')),
              Tab(icon: Icon(Icons.settings), text: AppLocalizations.of(context).translate('nav_configuration')),
            ],
          ),
          title: Text(AppLocalizations.of(context).translate('app_title')),
        ),
        body: TabBarView(
          children: [
            Tab1(),
            Tab2(),
            Tab3(),
          ],
        ),
      ),
    );
  }
}

// Find the right device and show the right admob details
String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-7700881921681700/6198192865';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-7700881921681700/9763755555';
  }
  return null;
}
