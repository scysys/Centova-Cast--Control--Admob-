import 'package:flutter/material.dart';
import 'package:flutter_centovacast_api/widgets/localisation/AppLocalizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new DrawerHeader(
            child: Html(data: """
        <div>
          <h1>STREAMPANEL</h1>
          <p>Professional Hosting from one of the biggest Stream Server Hosters in Europe. Test us now for free!</p>
        </div>
      """),
            decoration: BoxDecoration(
              color: Colors.black,
              /*image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/background.png')
              ),*/
            ),
          ),
          new ListTile(
            leading: Icon(Icons.help_outline),
            title: Text(AppLocalizations.of(context).translate('drawer_faq')),
            onTap: () async {
              const url =
                  'https://www.streampanel.net/faq/centova-cast-control/';

              if (!await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
                //headers: <String, String>{'my_header_key': 'my_header_value'},
              )) {
                throw 'Could not launch $url';
              }

            },
          ),
          new ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title:
                Text(AppLocalizations.of(context).translate('drawer_support')),
            onTap: () async {
              const url =
                  'https://login.streampanel.net/submitticket.php?step=2&deptid=57&language=german';

              if (!await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
                //headers: <String, String>{'my_header_key': 'my_header_value'},
              )) {
                throw 'Could not launch $url';
              }

            },
          ),
          new ListTile(
            leading: Icon(Icons.contact_mail),
            title:
                Text(AppLocalizations.of(context).translate('drawer_contact')),
            onTap: () async {
              const url = 'https://www.streampanel.net/kontakt/';

              if (!await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
                //headers: <String, String>{'my_header_key': 'my_header_value'},
              )) {
                throw 'Could not launch $url';
              }

            },
          ),
          new ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text(
                AppLocalizations.of(context).translate('drawer_changelog')),
            onTap: () async {
              const url =
                  'https://www.streampanel.net/changelog-centovacast-control/';

              if (!await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
                //headers: <String, String>{'my_header_key': 'my_header_value'},
              )) {
                throw 'Could not launch $url';
              }

            },
          ),
          new ListTile(
            leading: Icon(Icons.remove_red_eye),
            title:
                Text(AppLocalizations.of(context).translate('drawer_aboutus')),
            onTap: () async {
              const url = 'https://www.streampanel.net/kontakt/impressum/';

              if (!await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
                //headers: <String, String>{'my_header_key': 'my_header_value'},
              )) {
                throw 'Could not launch $url';
              }

            },
          ),
          new ListTile(
            leading: Icon(Icons.rate_review),
            title:
                Text(AppLocalizations.of(context).translate('drawer_review')),
            onTap: () {
              LaunchReview.launch();
            },
          )
        ],
      ),
    );
  }
}

/*String getAppLocale() {
  if (StorageUtil.getString("language_code") == "en") {
    //
  } else {
    //
  }
  return null;
}*/
