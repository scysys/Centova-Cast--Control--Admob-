import 'package:flutter/material.dart';
import 'package:flutter_centovacast_api/widgets/NavDrawer.dart';
import 'package:flutter_centovacast_api/widgets/SharedPreferencesUtil.dart';
import 'package:flutter_centovacast_api/widgets/tabs/tab1.dart';
import 'package:flutter_centovacast_api/widgets/tabs/tab2.dart';
import 'package:flutter_centovacast_api/widgets/tabs/tab3.dart';
import 'package:oktoast/oktoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Generated App',
        theme: new ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF212121),
          accentColor: const Color(0xFF64ffda),
          canvasColor: const Color(0xFF303030),
        ),
        home: new MyHomePage(),
        debugShowCheckedModeBanner: false,
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
                icon: Icon(Icons.android),
                text: "Stream Server",
              ),
              Tab(icon: Icon(Icons.phone_iphone), text: "AutoDJ"),
              Tab(icon: Icon(Icons.phone_iphone), text: "Configuration"),
            ],
          ),
          title: Text('Centova Cast: Control'),
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
