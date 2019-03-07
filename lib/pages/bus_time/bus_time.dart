import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tathastu_admin/pages/bus_time/add_bus_time/add_bus_time.dart';
import 'package:tathastu_admin/pages/home/components/sidemenu/sidemenu.dart';

class BusTimePage extends StatefulWidget {
  final Widget child;

  BusTimePage({Key key, this.child}) : super(key: key);

  _BusTimePageState createState() => _BusTimePageState();
}

class _BusTimePageState extends State<BusTimePage> {
  List<Map<String, dynamic>> listItems = [
    {
      'time': '02:45 PM',
      'busRoute': 'HYDERABAD - SURENDRANAGAR', 
      'stations': 'Unjha - Mehsana - Kalol'
    },
    {
      'time': '02:45 PM',
      'busRoute': 'PATAN - AHMEDABAD',
      'stations': 'Unjha - Mehsana - Kalol'
    },
    {
      'time': '02:45 PM',
      'busRoute': 'PATAN - AHMEDABAD',
      'stations': 'Unjha - Mehsana - Kalol'
    },
    {
      'time': '02:45 PM',
      'busRoute': 'PATAN - AHMEDABAD',
      'stations': 'Unjha - Mehsana - Kalol'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Bus Time List',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: listViewBuilder(listItems),
        backgroundColor: Colors.white,
        drawer: Drawer(child: SideMenuComponent()),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddBusTimePage()
            ));
          },
          child: Icon(Icons.add, color: Colors.black,),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget listViewBuilder(List<Map<String, dynamic>> listItems) {
    return ListView.separated(
      itemCount: listItems.length,
      itemBuilder: (BuildContext context, index) {
        return listTile(listItems[index]['time'], listItems[index]['busRoute'],
            listItems[index]['stations']);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget listTile(String time, String busRoute, String stations) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              buildClockAndTime(time),
              buildBusRoute(busRoute, stations),
            ],
          ),
          buildActions(),
        ],
      ),
    );
  }

  Widget buildClockAndTime(String time) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              height: 40.0,
              width: 40.0,
              padding: EdgeInsets.all(8.0),
              child: SvgPicture.asset('assets/icons/clock.svg')),
          Container(
              child: Text(
            time,
            style: TextStyle(fontSize: 12.0, color: Colors.grey[850]),
          )),
        ],
      ),
    );
  }

  Widget buildBusRoute(String busRoute, String stations) {
    return Container(
      padding: EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              child: Text(
            busRoute,
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[850],
                fontWeight: FontWeight.w600),
          )),
          Container(
              child: Text(
            stations,
            style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
          )),
        ],
      ),
    );
  }

  Widget buildActions(){
    List<String> choices = [
      'Modify',
      'Delete'
    ];
    return Container(
      child: PopupMenuButton(
            onSelected: null,
            itemBuilder: (BuildContext context){
              return choices.map((String choice){
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
    );
  }

}
