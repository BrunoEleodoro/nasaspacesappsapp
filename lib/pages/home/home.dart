import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/pages/default_pages/failure/failure.dart';
import 'package:app/pages/default_pages/loading/loading_page.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:app/utils/api_helper.dart';
import 'package:app/utils/url_helper.dart';
import 'package:app/utils/globals.dart' as globals;
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final mockedData = [
    QuarterSales('Q1', 15000, charts.ColorUtil.fromDartColor(Colors.amber)),
    QuarterSales('Q2', 25000, charts.ColorUtil.fromDartColor(Colors.yellow)),
    QuarterSales('Q3', 80000, charts.ColorUtil.fromDartColor(Colors.green)),
    QuarterSales('Q4', 55000, charts.ColorUtil.fromDartColor(Colors.purple)),
  ];

  var desafios = [];
  var desafio_clientes = [];

  AnimationController _controller;
  Animation<double> _animation;

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
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = new Tween<double>(
      begin: 0,
      end: 10,
    ).animate(new CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: _controller,
    ));
    _controller.forward(from: 0.0);
  }

  void loadData() async {
    Provider.of<LoadingNotifier>(context, listen: true).displayLoading();
    var res = await ApiHelper.postRequest(
        context, UrlHelper.desafioCliente, {'email': globals.email});
    // print(res['response'][0]);
    if (res['status'] == 200) {
      // Navigator.pushReplacementNamed(context, '/home');
      setState(() {
        desafio_clientes = res['response'];
      });
    } else {
      Provider.of<FailureNotifier>(context, listen: true)
          .displayFailure("Houston we have a problem");
    }

    res = await ApiHelper.postRequest(
        context, UrlHelper.desafios, {'email': globals.email});
    if (res['status'] == 200) {
      setState(() {
        desafios = res['response'];
      });
    } else {
      Provider.of<FailureNotifier>(context, listen: true)
          .displayFailure("Houston we have a problem");
    }
    Provider.of<LoadingNotifier>(context, listen: true).hideLoading();
    // orcamentoConfig =
  }

  @override
  Widget build(BuildContext context) {
    // loadData();
    print(desafio_clientes);
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: 5,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
                child: SingleChildScrollView(
                    child: Stack(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                ),
                Column(
                  children: <Widget>[
                    // Container(
                    //   width: double.maxFinite,
                    //   height: 200,
                    //   margin: EdgeInsets.only(top: 150),
                    //   child: charts.PieChart(
                    //     mapChartData(mockedData),
                    //     animate: true,
                    //     animationDuration: Duration(seconds: 1),
                    //   ),
                    // )
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width - 30,
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              Container(
                                  height: 150,
                                  width: double.maxFinite,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      AnimatedBuilder(
                                        animation: _animation,
                                        builder: (context, child) {
                                          return Text(
                                            // _animation[index].value.toStringAsFixed(0),
                                            '10',
                                            style: TextStyle(
                                                fontSize: 30,
                                                // color: cardsFalta[index]['color'],
                                                fontWeight: FontWeight.bold),
                                          );
                                        },
                                      ),
                                      new AnimatedCircularChart(
                                        duration: new Duration(seconds: 1),
                                        key: new GlobalKey<
                                            AnimatedCircularChartState>(),
                                        size: new Size(120, 120),
                                        percentageValues: true,
                                        initialChartData: <CircularStackEntry>[
                                          new CircularStackEntry(
                                            <CircularSegmentEntry>[
                                              new CircularSegmentEntry(
                                                  100, Colors.green,
                                                  rankKey: 'Q1'),
                                              new CircularSegmentEntry(
                                                  100, Colors.green[200],
                                                  rankKey: 'Q2'),
                                              // new CircularSegmentEntry(double.parse("2"), Colors.red[200],
                                              //     rankKey: 'Q1'),
                                              // new CircularSegmentEntry(double.parse("100"), Colors.green[200],
                                              //     rankKey: 'Q2'),
                                            ],
                                            rankKey: 'PontosKey',
                                          ),
                                        ],
                                        chartType: CircularChartType.Radial,
                                        // holeLabel: "2" + ' faltas restantes',
                                        // labelStyle: TextStyle(
                                        //   color: Colors.white,
                                        // ),
                                      ),
                                    ],
                                  )),
                              Center(
                                child: Text(
                                  'Pontos',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: desafios.length,
                      itemBuilder: (context, index) {
                        return Container(
                            width: double.maxFinite,
                            height: 180,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 4,
                                            child: Container(
                                              width: double.maxFinite,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          desafios[index]
                                                              ['img']))),
                                            )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                desafios[index]['titulo'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Divider(),
                                              Text(
                                                  desafios[index]['descricao']),
                                              Divider(),
                                              Text(
                                                desafios[index]['pontos'] +
                                                    " p",
                                                style: TextStyle(fontSize: 20),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                      },
                    )
                  ],
                ),
              ],
            )));
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
            icon: Icon(Icons.confirmation_number),
            title: Text('RECOMPENSAS'),
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
