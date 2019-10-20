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
      SizedBox(
        height: 50,
      ),
      Center(
        child: Text('Recompensas', style: TextStyle(fontSize: 20)),
      ),
      SizedBox(
        height: 20,
      ),
      GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(10, (index) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
              ),
              margin: EdgeInsets.all(16),
            ),
          );
        }),
      )
    ])));
  }
}
