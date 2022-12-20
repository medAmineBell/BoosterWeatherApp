import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:bwapp/provider/data_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    getChartData();
  }

  Map<int, double> result = {};

  void getChartData() {
    final capacity = Provider.of<DataProvider>(context, listen: false).capacity;

    for (var i = 0; i < 24; i++) {
      result.addAll({i: double.parse((capacity / i).toString())});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: double.infinity,
            height: 400,
            padding: EdgeInsets.only(right: 20, left: 20),
            child: DChartLine(
              includePoints: true,
              includeArea: true,
              data: [
                {
                  'id': 'Line',
                  'data': [
                    {'domain': 0, 'measure': 44},
                    {'domain': 1, 'measure': 45},
                    {'domain': 2, 'measure': 50},
                    {'domain': 3, 'measure': 60},
                    {'domain': 4, 'measure': 90},
                    {'domain': 5, 'measure': 90},
                    {'domain': 6, 'measure': 65},
                    {'domain': 7, 'measure': 60},
                    {'domain': 8, 'measure': 30},
                    {'domain': 9, 'measure': 10},
                    {'domain': 10, 'measure': 0},
                    {'domain': 11, 'measure': 0},
                    {'domain': 12, 'measure': 0},
                    {'domain': 13, 'measure': 10},
                    {'domain': 14, 'measure': 10},
                    {'domain': 15, 'measure': 20},
                    // result.map((key, value) {
                    //   return  {};
                    // })
                  ],
                },
              ],
              lineColor: (lineData, index, id) => Colors.green,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<DataProvider>(context, listen: false).loadWeather();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Text(
                "List Residances",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
          )
        ],
      ),
    );
  }
}
