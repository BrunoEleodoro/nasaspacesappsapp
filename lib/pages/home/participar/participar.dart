import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/pages/default_pages/failure/failure.dart';
import 'package:app/pages/default_pages/loading/loading_page.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:app/utils/api_helper.dart';
import 'package:app/utils/url_helper.dart';
import 'package:app/utils/globals.dart' as globals;
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class Participar extends StatefulWidget {
  var desafio;
  var desafios = new List();
  var desafio_clientes = new List();
  var helperList = new List();
  var original_data;

  Participar(
      {this.desafio,
      this.desafios,
      this.helperList,
      this.desafio_clientes,
      this.original_data});
  // Participar({this.desafios});
  @override
  _ParticiparState createState() => _ParticiparState();
}

class _ParticiparState extends State<Participar> {
  void participarClicked() async {
    var object = widget.original_data;
    print('participarClicked');
    object[0]['desafios'].add(widget.desafio);

    var finalObject = Map<String, dynamic>();
    finalObject['email'] = object[0]['email'];
    finalObject['desafios'] = object[0]['desafios'];
    finalObject['id'] = object[0]['_id'];

    Provider.of<LoadingNotifier>(context, listen: true).displayLoading();
    var res = await ApiHelper.postRequest(
        context, UrlHelper.atualizarDesafioCliente, finalObject);
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
                      widget.desafio['pontos'] + " pontos",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent),
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
                    height: 10,
                  ),
                  Center(child: Text(widget.desafio['descricao'])),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: MaterialButton(
                      // minWidth: double.maxFinite,
                      color: Colors.orange,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text('ACEITAR O DESAFIO'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: OutlineButton(
                      // minWidth: double.maxFinite,
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text('CANCELAR'),
                    ),
                  ),
                  // participarClicked
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
