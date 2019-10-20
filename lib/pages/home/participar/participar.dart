import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/pages/default_pages/failure/failure.dart';
import 'package:app/pages/default_pages/loading/loading_page.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:app/utils/api_helper.dart';
import 'package:app/utils/url_helper.dart';
import 'package:app/utils/globals.dart' as globals;
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class ParticiparPage extends StatefulWidget {
  var desafio = {};
  var desafios = {};
  ParticiparPage({this.desafio, this.desafios});
  @override
  _ParticiparPageState createState() => _ParticiparPageState();
}

class _ParticiparPageState extends State<ParticiparPage> {
  void participarClicked() async {
    Provider.of<LoadingNotifier>(context, listen: true).displayLoading();
    var res = await ApiHelper.postRequest(
        context, UrlHelper.desafioCliente, {'email': globals.email});
    // print(res['response'][0]);
    if (res['status'] == 200) {
      // Navigator.pushReplacementNamed(context, '/home');
      Navigator.pop(context);
    } else {
      Provider.of<FailureNotifier>(context, listen: true)
          .displayFailure("Houston we have a problem");
    }
    Provider.of<LoadingNotifier>(context, listen: true).hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.desafio['img'] == null) {
      return CircularProgressIndicator();
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.desafio['img']),
              )),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      widget.desafio['pontos'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      widget.desafio['titulo'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(child: Text(widget.desafio['descricao']))
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: participarClicked,
        child: Icon(Icons.add),
      ),
    );
  }
}
