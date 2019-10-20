import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/pages/default_pages/failure/failure.dart';
import 'package:app/pages/default_pages/loading/loading_page.dart';
import 'package:app/utils/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/utils/api_helper.dart';
import 'package:app/utils/url_helper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usuarioController = new TextEditingController();
  var senhaController = new TextEditingController();
  var _formKey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  void fazerLogin() async {
    if (_formKey.currentState.validate()) {
      Provider.of<LoadingNotifier>(context, listen: true).displayLoading();
      var res = await ApiHelper.postRequest(context, UrlHelper.login,
          {'email': usuarioController.text, 'password': senhaController.text});
      if (res['token'] != null) {
        sharedPreferences.setString('token', res['token']);
        sharedPreferences.setString('email', usuarioController.text);
        globals.token = res['token'];
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Provider.of<FailureNotifier>(context, listen: true)
            .displayFailure("Login ou senha inválidos");
      }
      Provider.of<LoadingNotifier>(context, listen: true).hideLoading();
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var email = sharedPreferences.getString('email');
    if (token != null) {
      globals.token = token;
      globals.email = email;
      if (!await ApiHelper.tokenExpired(context)) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 60),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              Container(
                width: 100,
                height: 2,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Preencha este campo';
                  }
                  return null;
                },
                controller: usuarioController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Usuario'),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Preencha este campo';
                  }
                  return null;
                },
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Senha'),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 150,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: fazerLogin,
                      child: Text('LOGIN'),
                      color: Theme.of(context).accentColor,
                      elevation: 5,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
