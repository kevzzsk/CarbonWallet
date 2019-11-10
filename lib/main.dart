import 'package:carbon_wallet/Login/LoginScreen.dart';
import 'package:carbon_wallet/account.dart';
import 'package:carbon_wallet/dashboard.dart';
import 'package:carbon_wallet/recommendation.dart';
import 'package:flutter/material.dart';
import 'route_gen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static Map<int, Color> color = {
    50: Color.fromRGBO(117, 218, 195, .1),
    100: Color.fromRGBO(117, 218, 195, .2),
    200: Color.fromRGBO(117, 218, 195, .3),
    300: Color.fromRGBO(117, 218, 195, .4),
    400: Color.fromRGBO(117, 218, 195, .5),
    500: Color.fromRGBO(117, 218, 195, .6),
    600: Color.fromRGBO(117, 218, 195, .7),
    700: Color.fromRGBO(117, 218, 195, .8),
    800: Color.fromRGBO(117, 218, 195, .9),
    900: Color.fromRGBO(117, 218, 195, 1),
  };
  MaterialColor colorCustom = MaterialColor(0xFF75DAC3, color);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carbon Wallet',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;

  var purchaseState = [];
  var carbonValue = 0;

  updatePurchaseState(newTransaction){
    setState(() {
      purchaseState.add(newTransaction);
    });
  }
  updateCarbonValue(newValue){
    setState(() {
      carbonValue = newValue;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _buildBody() {
    switch (_selectedIndex) {
      case 0: // Dashboard
        return Dashboard(purchaseState: purchaseState, updatePurchase:updatePurchaseState,carbonValue:carbonValue,updateCarbonValue:updateCarbonValue,);
      case 1:
        return RecommendationPage();
      case 2:
        return Container();
      case 3:
        return AccountPage();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Carbon Wallet"),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up), title: Text("Recommendation")),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), title: Text("History")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text("Account")),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:
            Color.fromARGB(255, 46, 147, 60), // SELECTED ITEM COLOR
        unselectedItemColor: Color.fromARGB(130, 46, 147, 60),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
