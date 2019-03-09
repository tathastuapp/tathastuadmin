import 'package:flutter/material.dart';
import 'package:tathastu_admin/pages/bus_time/bus_time.dart';
import 'package:tathastu_admin/pages/category/category_types.dart';
import 'package:tathastu_admin/pages/home/components/sidemenu/sidemenu.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tathastu Admin',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: buildBody(),
        backgroundColor: Colors.white,
        drawer: Drawer(child: SideMenuComponent()),
      ),
    );
  }

  buildBody(){
    return Container(
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            child: Text('BUS TIME', style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => BusTimePage()
              ));
            },
          ),
          SizedBox(height: 16.0,),
          RaisedButton(
            color: Colors.green,
            child: Text('CATEGORY TYPES', style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => CategoryTypePage()
              ));
            },
          ),
        ],
      ),
    );
  }

}