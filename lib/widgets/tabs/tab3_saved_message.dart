import 'package:flutter/material.dart';
import 'package:flutter_centovacast_api/widgets/localisation/AppLanguage.dart';
import 'package:flutter_centovacast_api/widgets/localisation/AppLocalizations.dart';
import 'package:provider/provider.dart';

class ButtonPressed extends StatefulWidget {
  @override
  _ButtonPressedState createState() => _ButtonPressedState();
}

class _ButtonPressedState extends State<ButtonPressed> {
  @override
  Widget build(BuildContext context) {
    print('Save Button was pressed');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Setting were Saved'),
      ),
      // create a popup to show some msg.
      body: new Container(
        child: new Text(
          AppLocalizations.of(context).translate('saved_desc'),
          style: new TextStyle(
              fontSize: 16.0,
              color: const Color(0xFFffffff),
              fontWeight: FontWeight.w200,
              fontFamily: "Roboto"),
        ),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
      ),
    );
  }
}
