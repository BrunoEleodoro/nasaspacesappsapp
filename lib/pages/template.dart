// import 'package:connectivity/connectivity.dart';
import 'package:app/pages/default_pages/failure/failure.dart';
import 'package:app/pages/default_pages/loading/loading_page.dart';
import 'package:app/pages/default_pages/sucess/sucess.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class TemplatePage extends StatefulWidget {
  var child;
  TemplatePage({this.child});
  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  var isOnTheRightNetwork = false;
  var wifiName = "";
  void checkWifiConnection() async {}

  @override
  void initState() {
    super.initState();
    checkWifiConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        Consumer<LoadingNotifier>(
          builder: (context, loadingNotifier, _) {
            if (loadingNotifier.isLoading) {
              return LoadingPage();
            } else {
              return SizedBox();
            }
          },
        ),
        Consumer<SucessNotifier>(
          builder: (context, sucessNotifier, _) {
            if (sucessNotifier.shouldDisplay) {
              return SucessPage(
                message: sucessNotifier.message,
              );
            } else {
              return SizedBox();
            }
          },
        ),
        Consumer<FailureNotifier>(
          builder: (context, failureNotifier, _) {
            if (failureNotifier.shouldDisplay) {
              return FailurePage(
                warning: false,
                message: failureNotifier.message,
              );
            } else {
              return SizedBox();
            }
          },
        ),
        // (!isOnTheRightNetwork)
        //     ? FailurePage(
        //         message:
        //             'Você precisa estar conectado na rede wifi "webcabines", rede atual:' +
        //                 wifiName,
        //         warning: true,
        //       )
        //     : SizedBox()
      ],
    );
  }
}
