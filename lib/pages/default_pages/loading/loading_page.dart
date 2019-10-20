import 'package:flutter/material.dart';

class LoadingNotifier with ChangeNotifier {
  var isLoading = false;

  void displayLoading() async {
    isLoading = true;
    notifyListeners();
  }

  void fakeLoading() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(new Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
  }

  void hideLoading() {
    isLoading = false;
    notifyListeners();
  }
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
//    _controller = new AnimationController(vsync: this,duration: Duration(seconds: 1));
//    _animation = new Tween(
//      begin: 0.0,
//      end: 1.0
//    ).animate(_controller);
//    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
