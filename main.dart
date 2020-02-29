import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_around_flutter/personModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Play around with Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class MenuItem {
  final Icon leading;
  final String name;
  final int index;
  MenuItem({this.leading, this.name, this.index});
}

class MenuItemIcon {
  final Icon leading;
  final int index;
  MenuItemIcon({this.leading, this.index});
}

class _MyHomePageState extends State<MyHomePage> {

  List<MenuItem> menuItems;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  int _pageIndex = 0;

  List<String> title = [
    "User",
    "Alarm",
    "Account Balance"
  ];

  List<MenuItemIcon> menuItemIcons = [
  MenuItemIcon(
    leading: Icon(Icons.accessibility),
    index: 0,
  ),
  MenuItemIcon(
    leading: Icon(Icons.access_alarm),
    index: 1,
  ),
  MenuItemIcon(
    leading: Icon(Icons.account_balance),
    index: 2,
  )];

  _handleDrawer() {
    _key.currentState.openDrawer();
    print("Drawer clicked");
  }

  Widget _loadBody() {
    Widget body = UserPage();
    switch (menuItemIcons.singleWhere((item) {
      return item.index == _pageIndex;
    }).index) {
      case 0:
        body = UserPage();
        break;
      case 1:
        body = AlarmPage();
        break;
      case 2:
        body = AccountBalancePage();
        break;
      default:
        body = Container();
    }
    return body;
  }

  _loadDrawer(BuildContext context){
    menuItems = [
      MenuItem(
          leading: Icon(Icons.accessibility),
          name:"User",
          index: 0),
      MenuItem(
        leading: Icon(Icons.access_alarm),
        name: "Alarm",
        index: 1,
      ),
      MenuItem(
          name: "Account Balance",
          leading: Icon(Icons.account_balance),
          index: 2),
    ];
    List<Widget> menu = List();
    menu.add(
      Container(
        height: 200.0,
        child: DrawerHeader(
          child: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child : Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Image.asset("assets/images/nitro.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "SOPHEAP Sopheadavid",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  "0966441244",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        ),
      ),
    );
    menuItems.forEach((item) {
      menu.add(
        Column(
          children: <Widget>[
            ListTile(
              leading: item.leading,
              title: Text(item.name),
              onTap: () {
                setState(() {
                  this._pageIndex = item.index;
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.pop(context);
                });
              },
            ),
//              Divider(color: Colors.grey,)
          ],
        ),
      );
    });
    return menu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(title[_pageIndex]),
        leading: new IconButton(
          icon: new Icon(Icons.menu),
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _handleDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: _loadDrawer(context),
        ),
      ),
      body: SafeArea(
        child: _loadBody(),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  GlobalKey<RefreshIndicatorState> _refreshKey = new GlobalKey<RefreshIndicatorState>();

    Future<Null> _handleRefresh() async {
      await new Future.delayed(new Duration(seconds: 1));

      setState(() {
        print("Loading!!!");
      });

      return null;
    }

  List<Person> _person = [
    Person("SAMBATH Dara", "Male", 24, "Cambodian"),
    Person("KEO Sokna", "Female", 22, "Cambodian"),
    Person("ROUS Dara", "Male", 24, "Cambodian"),
    Person("SOKNA David", "Male", 23, "Cambodian"),
    Person("BONA Nora", "Male", 24, "Cambodian"),
    Person("SOVANN Panha", "Female", 22, "Italian"),
    Person("SAMBATH Dara", "Male", 24, "Cambodian"),
    Person("KEO Sokna", "Female", 22, "Cambodian"),
    Person("ROUS Dara", "Male", 24, "Cambodian"),
    Person("SOKNA David", "Male", 23, "Cambodian"),
    Person("BONA Nora", "Male", 24, "Cambodian"),
    Person("SOVANN Panha", "Female", 22, "Italian"),
  ];

  _buildListPerson(List<Person> person){
    return ListView.builder(
        itemCount: person.length,
        itemBuilder: (context, index){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Name : ${person[index].fullName}"),
              SizedBox(height: 5,),
              Text("Sex : ${person[index].sex}"),
              SizedBox(height: 5,),
              Text("Age : ${person[index].age}"),
              SizedBox(height: 5,),
              Text("Nationality : ${person[index].nationality}"),
              Divider()
            ],
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () {
          return _handleRefresh();
        },
        child: Container(
          margin: EdgeInsets.all(8),
          child: _buildListPerson(_person),
        ),
      );
  }
}

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Alarm"),),
    );
  }
}

class AccountBalancePage extends StatefulWidget {
  @override
  _AccountBalancePageState createState() => _AccountBalancePageState();
}

class _AccountBalancePageState extends State<AccountBalancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Account Balance"),),
    );
  }
}



// Border radius on container by using ClipRRect
//      body: Center(
//        child: ClipRRect(
//          borderRadius: BorderRadius.all(Radius.circular(20.0)),
//          child: Container(
//            width: 300,
//            height: 300,
//            color: Colors.blueAccent,
//          ),
//        ),
//      ),

// Concat text
//      body: Center(
//        child: RichText(
//          text: TextSpan(
//            text: "Android ",
//            style: TextStyle(color: Colors.black, fontSize: 25.0),
//            children: [
//              TextSpan(text: "Studio", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 25.0))
//            ]
//          ),
//        )
//      ),