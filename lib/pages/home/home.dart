import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/pages/default_pages/failure/failure.dart';
import 'package:app/pages/default_pages/loading/loading_page.dart';
import 'package:app/pages/home/cadastrar/cadastrar.dart';
import 'package:app/pages/home/configuracoes/configuracoes.dart';
import 'package:app/pages/home/pesquisar/pesquisar.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:app/utils/api_helper.dart';
import 'package:app/utils/url_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class QuarterSales {
  final String quarter;
  final double sales;
  final charts.Color color;

  QuarterSales(this.quarter, this.sales, this.color);
}

class _HomePageState extends State<HomePage> {
  final mockedData = [
    QuarterSales('Q1', 15000, charts.ColorUtil.fromDartColor(Colors.amber)),
    QuarterSales('Q2', 25000, charts.ColorUtil.fromDartColor(Colors.yellow)),
    QuarterSales('Q3', 80000, charts.ColorUtil.fromDartColor(Colors.green)),
    QuarterSales('Q4', 55000, charts.ColorUtil.fromDartColor(Colors.purple)),
  ];
  var orcamentoConfig = {};

  /// Create one series with pass in data.
  List<charts.Series<QuarterSales, String>> mapChartData(
      List<QuarterSales> data) {
    return [
      charts.Series<QuarterSales, String>(
        id: 'Sales',
        colorFn: (QuarterSales sales, __) => sales.color,
        domainFn: (QuarterSales sales, _) => sales.quarter,
        measureFn: (QuarterSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  var selectedIndex = 0;
  var pageController = new PageController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      loadData();
    });
  }

  void loadData() async {
    Provider.of<LoadingNotifier>(context, listen: true).displayLoading();
    var res = await ApiHelper.postRequest(
        context, UrlHelper.listarOrcamentoConfig, {});
    print(res['response'][0]);
    if (res['status'] == 200) {
      // Navigator.pushReplacementNamed(context, '/home');
      setState(() {
        orcamentoConfig = res['response'][0];
      });
    } else {
      Provider.of<FailureNotifier>(context, listen: true)
          .displayFailure("Algo de errado aconteceu");
    }
    Provider.of<LoadingNotifier>(context, listen: true).hideLoading();
    // orcamentoConfig =
  }

  @override
  Widget build(BuildContext context) {
    // loadData();
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: 5,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.maxFinite,
                    height: 200,
                    margin: EdgeInsets.only(top: 150),
                    child: charts.PieChart(
                      mapChartData(mockedData),
                      animate: true,
                      animationDuration: Duration(seconds: 1),
                    ),
                  )
                ],
              ),
            );
          } else if (index == 1) {
            return CadastrarPage(
              orcamentoConfig: orcamentoConfig,
            );
          } else if (index == 2) {
            return PesquisarPage(
              orcamentoConfig: orcamentoConfig,
            );
          } else if (index == 4) {
            return ConfiguracoesPage(
              orcamentoConfig: orcamentoConfig,
            );
          }
          return Container(
            child: Center(
              child: Text(index.toString()),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.grey[800],
        elevation: 10,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) async {
          ApiHelper.tokenExpired(context);
          setState(() {
            selectedIndex = value;
            pageController.animateToPage(value,
                curve: Curves.ease, duration: Duration(milliseconds: 500));
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('HOME'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            title: Text('CADASTRAR'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('PESQUISAR'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_backup_restore),
            title: Text('CONTRAPROPOSTAS'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('CONFIGURAÇÕES'),
          ),
        ],
      ),
    );
  }
}
