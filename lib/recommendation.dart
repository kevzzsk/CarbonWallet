import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:expandable/expandable.dart';

class RecommendationPage extends StatefulWidget {
  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  final TextEditingController _searchQuery = new TextEditingController();

  final ScrollController _scrollController = new ScrollController();
  final double cardInitHeight = 120;
  final double cardExpanHeight = 300;

  _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextField(
        autofocus: false,
        controller: _searchQuery,
        cursorColor: Theme.of(context).primaryColor,
        style: new TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        decoration: new InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          prefixIcon:
              new Icon(Icons.search, color: Theme.of(context).primaryColor),
          hintText: "Search...",
          hintStyle: new TextStyle(color: Theme.of(context).primaryColor),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildSearchBar(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              "November 2019",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Divider(),
          FutureBuilder(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  // return item list to parent
                  var data = snapshot.data;
                  return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      final ExpandableController _expandableController =
                          new ExpandableController();
                      return Container(
                        child: ExpandablePanel(
                          hasIcon: false,
                          expanded: Card(
                            elevation: 4,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    data[index]["imageurl"],
                                                  )))),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            data[index]["carbonValue"] +
                                                " kg of CO2",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.calendar_today),
                                              Text("Update Information")
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  Text("Carbon Heavy Product"),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data[index]["products"].length,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (context, j) {
                                      final ExpandableController
                                          _expandableController2 =
                                          new ExpandableController();
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: ExpandablePanel(
                                          controller: _expandableController2,
                                          hasIcon: false,
                                          expanded:
                                              buildAlternatives(data, index, j),
                                          header: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                      width: 50,
                                                      height: 50,
                                                      child: Image.network(
                                                        data[index]["products"]
                                                            [j]["productUrl"],
                                                        fit: BoxFit.contain,
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(data[index]
                                                              ["products"][j]
                                                          ["name"]),
                                                      Row(
                                                        children: <Widget>[
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            20))),
                                                            height: 30,
                                                            width: 200 *
                                                                double.parse(data[
                                                                            index]
                                                                        [
                                                                        "products"][j]
                                                                    [
                                                                    "percentage"]) /
                                                                100,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(data[index][
                                                                      "products"][j]
                                                                  [
                                                                  "percentage"] +
                                                              "%")
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              InkWell(
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child: Text("Alt"),
                                                ),
                                                onTap: () {
                                                  _expandableController2
                                                      .toggle();
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          controller: _expandableController,
                          tapBodyToCollapse: true,
                          collapsed: Card(
                            color: Color.fromARGB(255, 235, 249, 243),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                data[index]["imageurl"],
                                              )))),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    data[index]["carbonValue"],
                                    style: TextStyle(
                                        fontSize: 80,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Kg of CO2"),
                                      OutlineButton(
                                        onPressed: () {
                                          _expandableController.toggle();
                                        },
                                        child: Text("View Insights"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return CircularProgressIndicator();
              }
              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }

  Container buildAlternatives(data, int index, int j) {
    return Container(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: data[index]["products"][j]["alternatives"].length,
        itemBuilder: (context, k) {
          return Card(
              child: Stack(
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                child: Image.network(
                    data[index]["products"][j]["alternatives"][k]["imageUrl"],fit: BoxFit.cover,),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  color: Colors.white.withAlpha(150),
                  width: 300,
                  height: 20,
                ),
              ),
              Positioned(
                left: 5,
                bottom: 0,
                child:
                    Text(data[index]["products"][j]["alternatives"][k]["name"],style: TextStyle(fontWeight: FontWeight.w600),),
              )
            ],
          ));
        },
      ),
    );
  }
}

Future loadData() async {
  String jsonString =
      await rootBundle.loadString('assets/data/recommendationList.json');
  final jsonResponse = json.decode(jsonString);
  return jsonResponse;
}
