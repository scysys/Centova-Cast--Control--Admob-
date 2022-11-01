import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_centovacast_api/config/admob.dart';
import 'package:flutter_centovacast_api/widgets/SharedPreferencesUtil.dart';
import 'package:flutter_centovacast_api/widgets/tabs/tab3_saved_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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

  // Admob
  static const AdRequest request = AdRequest(
    nonPersonalizedAds: true,
  );
  BannerAd? _anchoredBanner;
  bool _loadingAnchoredBanner = false;

  Future<void> _createAnchoredBanner(BuildContext context) async {
    if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
      final AnchoredAdaptiveBannerAdSize? size = await AdSize.getAnchoredAdaptiveBannerAdSize(
        Orientation.portrait,
        MediaQuery.of(context).size.width.truncate(),
      );

      if (size == null) {
        if (kDebugMode) {
          print('Unable to get height of anchored banner.');
        }
        return;
      }

      final BannerAd banner = BannerAd(
        size: size,
        request: request,
        adUnitId: AdManager.bannerAdUnitId,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            if (kDebugMode) {
              print('$BannerAd loaded.');
            }
            setState(() {
              _anchoredBanner = ad as BannerAd;
            });
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            if (kDebugMode) {
              print('$BannerAd failedToLoad: $error');
            }
            ad.dispose();
          },
          //onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
          //onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        ),
      );
      return banner.load();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    AppLocalizations.of(context)!.configuration,
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    AppLocalizations.of(context)!.enter_your_details,
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: urlController..text = StorageUtil.getString("cc_url"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.cc_url_label,
                    hintText: AppLocalizations.of(context)!.cc_url_hint,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController..text = StorageUtil.getString("cc_username"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.cc_username_label,
                    hintText: AppLocalizations.of(context)!.cc_username_hint,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  controller: passwordController..text = StorageUtil.getString("cc_password"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.cc_password_label,
                    hintText: AppLocalizations.of(context)!.cc_password_hint,
                  ),
                ),
              ), // Save Button
              Container(
                  height: 75,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                      //textColor: Colors.white,
                      //color: Colors.blue,
                      child: Text(
                        AppLocalizations.of(context)!.save,
                        style: new TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        print(urlController.text);
                        print(nameController.text);
                        print(passwordController.text);

                        StorageUtil.putString("cc_url", urlController.text);
                        StorageUtil.putString("cc_username", nameController.text);
                        StorageUtil.putString("cc_password", passwordController.text);

                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ButtonPressed()));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue))),
              spShowAdmobBanner
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_anchoredBanner != null)
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: AdWidget(ad: _anchoredBanner!),
                          ),
                      ],
                    )
                  : Column(),
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

// Find the right device and show the right admob details
class AdManager {
  static String get bannerAdUnitId {
    if (Platform.isIOS) {
      return 'ca-app-pub-7700881921681700/6198192865';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-7700881921681700/9763755555';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
