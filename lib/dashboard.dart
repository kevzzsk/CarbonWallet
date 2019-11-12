import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Dashboard extends StatefulWidget {
  final purchaseState;
  final updatePurchase;
  final carbonValue;
  final updateCarbonValue;
  Dashboard({this.purchaseState,this.updatePurchase,this.carbonValue,this.updateCarbonValue});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int carbonValue = 0;


  _generateTrees(level) {
    var treesLocation = [
      Positioned(
        left: 40,
        top: 20,
        width: 50,
        height: 60,
        child: Image.asset('assets/tree.png'),
      ),
      Positioned(
        left: 15,
        top: 60,
        width: 40,
        height: 50,
        child: Image.asset('assets/tree.png'),
      ),
      Positioned(
        left: 100,
        top: 20,
        width: 40,
        height: 66,
        child: Image.asset('assets/tree.png'),
      ),
      Positioned(
        left: 80,
        top: 65,
        width: 56,
        height: 66,
        child: Image.asset('assets/tree.png'),
      ),
      Positioned(
        left: 150,
        top: 38,
        width: 55,
        height: 40,
        child: Image.asset('assets/tree.png'),
      ),
      Positioned(
        right: 40,
        top: 65,
        width: 56,
        height: 66,
        child: Image.asset('assets/tree.png'),
      ),
      Positioned(
        right: 15,
        top: 60,
        width: 40,
        height: 50,
        child: Image.asset('assets/tree.png'),
      ),
      Positioned(
        right: 80,
        top: 10,
        width: 50,
        height: 50,
        child: Image.asset('assets/tree.png'),
      ),
      Positioned(
        right: 120,
        top: 80,
        width: 72,
        height: 60,
        child: Image.asset('assets/tree.png'),
      ),
      Positioned(
        right: 80,
        top: 60,
        width: 40,
        height: 50,
        child: Image.asset('assets/tree.png'),
      ),
    ];
    if (level > treesLocation.length) {
      return [];
    }

    return treesLocation.sublist(0, treesLocation.length - level);
  }

  _buildTrees(value) {
    int numTrees = value ~/ 4;

    return Stack(
      children: <Widget>[
        Positioned(
          child: Image.asset(
            'assets/Ellipse1.png',
            width: MediaQuery.of(context).size.width * 0.9,
          ),
        ),
        ..._generateTrees(numTrees),
        Positioned(
          right: -15,
          bottom: -10,
          width: 150,
          height: 150,
          child: InkWell(
            child: Image.asset("assets/badge_chameleon.png"),
            onTap: () {},
          ),
        )
      ],
    );
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  

  void _onRefresh() async {
    // monitor network fetch
    try {
      final res = await http.get("http://db5e86e1.ngrok.io/api/purchase");

      final jsonRes = json.decode(res.body);

      setState(() {
        
        carbonValue = widget.carbonValue + jsonRes["aggregateCF"].toInt();
        widget.updateCarbonValue(carbonValue);
        widget.updatePurchase(jsonRes);
      });
    } catch (e) {
      setState(() {
        carbonValue = Random().nextInt(30);
        widget.updateCarbonValue(carbonValue);
      });
    }

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Text("Carbon Footprint",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                   widget.carbonValue.toString(),
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Kg of CO2",
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            _buildTrees( widget.carbonValue ),
            SizedBox(
              height: 60,
            ),
            Card(
              elevation: 3,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Recent Purchase Footprints"),
                      OutlineButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text("View Insights"),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/dashboard_chart.png",
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
