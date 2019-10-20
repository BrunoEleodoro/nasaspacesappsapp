import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/pages/default_pages/failure/failure.dart';
import 'package:app/pages/default_pages/loading/loading_page.dart';
import 'package:app/pages/default_pages/sucess/sucess.dart';
import 'package:app/pages/home/home.dart';
import 'package:app/pages/login/login.dart';
import 'package:app/pages/template.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (_) => LoadingNotifier()),
          ChangeNotifierProvider(builder: (_) => SucessNotifier()),
          ChangeNotifierProvider(builder: (_) => FailureNotifier()),
        ],
        child: MaterialApp(
          title: 'EcoQuest',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'ProximaNova',
              primarySwatch: Colors.orange,
              accentColor: Colors.orangeAccent,
              brightness: Brightness.dark),
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => TemplatePage(
                  child: LoginPage(),
                ),
            '/home': (BuildContext context) => TemplatePage(
                  child: HomePage(),
                ),
          },
        ));
  }
}
