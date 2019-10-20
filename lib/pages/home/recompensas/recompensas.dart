import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/pages/default_pages/failure/failure.dart';
import 'package:app/pages/default_pages/loading/loading_page.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:app/utils/api_helper.dart';
import 'package:app/utils/url_helper.dart';
import 'package:app/utils/globals.dart' as globals;
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class RecompensasPage extends StatefulWidget {
  @override
  _RecompensasPageState createState() => _RecompensasPageState();
}

class _RecompensasPageState extends State<RecompensasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      GridView.count(
        //cria um grid com 2 colunas
        shrinkWrap: true,
        crossAxisCount: 2,
        // Gera 100 Widgets que exibem o seu índice na lista
        children: List.generate(100, (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headline,
            ),
          );
        }),
      )
    ])));
  }
}
