import 'package:flutter/material.dart';
import 'package:flutter_centovacast_api/widgets/SharedPreferencesUtil.dart';
import 'package:flutter_centovacast_api/widgets/tabs/tab3_saved_message.dart';
import 'package:flutter_centovacast_api/widgets/localisation/AppLanguage.dart';
import 'package:flutter_centovacast_api/widgets/localisation/AppLocalizations.dart';
import 'package:provider/provider.dart';

class Tab3 extends StatefulWidget {
  @override
  _Tab3 createState() => _Tab3();
}

class _Tab3 extends State<Tab3> {
  TextEditingController urlController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String cc_url = "";
  String cc_username = "";
  String cc_password = "";

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
        body: new Container(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    AppLocalizations.of(context).translate('configuration'),
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('enter_your_details'),
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: urlController
                    ..text = StorageUtil.getString("cc_url"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText:
                        AppLocalizations.of(context).translate('cc_url_label'),
                    hintText:
                        AppLocalizations.of(context).translate('cc_url_hint'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController
                    ..text = StorageUtil.getString("cc_username"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)
                        .translate('cc_username_label'),
                    hintText: AppLocalizations.of(context)
                        .translate('cc_username_hint'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  controller: passwordController
                    ..text = StorageUtil.getString("cc_password"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)
                        .translate('cc_password_label'),
                    hintText: AppLocalizations.of(context)
                        .translate('cc_password_hint'),
                  ),
                ),
              ), // Save Button
              Container(
                  height: 75,
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text(AppLocalizations.of(context).translate('save')),
                    onPressed: () async {
                      print(urlController.text);
                      print(nameController.text);
                      print(passwordController.text);

                      StorageUtil.putString("cc_url", urlController.text);
                      StorageUtil.putString("cc_username", nameController.text);
                      StorageUtil.putString("cc_password", passwordController.text);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ButtonPressed()));
                    },
                  )),
              new Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('app_language'),
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('app_language_desc'),
                          style: TextStyle(fontSize: 20),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            appLanguage.changeLanguage(Locale("en"));
                          },
                          child: Text(AppLocalizations.of(context)
                              .translate('language_en')),
                        ),
                        RaisedButton(
                          onPressed: () {
                            appLanguage.changeLanguage(Locale("de"));
                          },
                          child: Text(AppLocalizations.of(context)
                              .translate('language_de')),
                        )
                      ],
                    )
                  ],
                ),
              ),
              // Dev Button
              /*Container(
                  height: 75,
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.red,
                    child: Text('Show Preferences'),
                    onPressed: () {
                      print('Dev Button was pressed');

                      // Get Preferences
                      print(StorageUtil.getString("cc_url"));
                      print(StorageUtil.getString("cc_username"));
                      print(StorageUtil.getString("cc_password"));
                      print(StorageUtil.getString("language_code"));

                    },
                  )),*/
            ],
          )),
    ));
  }
}
