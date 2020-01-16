import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int selectedTab = 0;
  List badges = [
    {
      "name": "Chameleon",
      "badgeUrl": "assets/badge_chameleon.png",
      "description":
          "Changing your purchase behaviour to consume more eco-friendly products"
    },
    {
      "name": "Green Warrior",
      "badgeUrl": "assets/green_warrior.png",
      "description":
          "Purchase only eco-friendly choice products for the week. Badges stacks/upgrades."
    },
    {
      "name": "Curb Your Carbon",
      "badgeUrl": "assets/curb_your_carbon.png",
      "description":
          "Produce less than 50 kg of CO2 from your monthly purchases."
    },
    {
      "name": "Local Goodness",
      "badgeUrl": "assets/local_goodness.png",
      "description": "Purchase only local produce for a month."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.22,
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.account_circle,
                      size: 100,
                    ),
                  ),
                  Text("Maureen Tan"),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            child: Text(
                              "Badges",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: selectedTab == 0
                                      ? FontWeight.w600
                                      : FontWeight.w400),
                            ),
                            onTap: () {
                              setState(() {
                                selectedTab = 0;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: selectedTab == 1
                                      ? FontWeight.w600
                                      : FontWeight.w400),
                            ),
                            onTap: () {
                              setState(() {
                                selectedTab = 1;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          buildContent(selectedTab)
        ],
      ),
    );
  }

  buildContent(index) {
    switch (index) {
      case 0:
        return buildBadges();
      case 1:
        return buildProfile();
      default:
        return buildBadges();
    }
  }

  buildProfile() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        ListTile(
          title: Text("Username"),
        ),
        ListTile(
          title: Text("Date Of Birth"),
        ),
        ListTile(
          title: Text("Name"),
        ),
        ListTile(
          title: Text("Name"),
        ),
        ListTile(
          title: Text("Name"),
        ),
      ],
    );
  }

  ListView buildBadges() {
    return ListView.separated(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      separatorBuilder: (context,index){
       return  Divider();
      },
      itemCount: badges.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 100, child: Image.asset(badges[index]['badgeUrl'])),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      badges[index]['name'],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text(badges[index]['description'])
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
