import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SucessNotifier with ChangeNotifier {
  var shouldDisplay = false;
  var message = "";

  void displaySucess(custom_message) async {
    shouldDisplay = true;
    message = custom_message;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));
    shouldDisplay = false;
    notifyListeners();
  }
}

class SucessPage extends StatelessWidget {
  var message = "";

  SucessPage({this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle_outline,
                size: 55,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
