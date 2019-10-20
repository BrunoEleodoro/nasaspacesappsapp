import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FailureNotifier with ChangeNotifier {
  var shouldDisplay = false;
  var message = "";

  void displayFailure(custom_message) async {
    shouldDisplay = true;
    message = custom_message;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));
    shouldDisplay = false;
    notifyListeners();
  }
}

class FailurePage extends StatelessWidget {
  var message = "";
  var warning = false;
  FailurePage({this.message, this.warning});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: (warning) ? Colors.black : Colors.red,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                (warning) ? Icons.warning : Icons.error_outline,
                size: 55,
                color: (warning) ? Colors.amber : Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 25, color: Colors.white),
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
