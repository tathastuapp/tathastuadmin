import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:tathastu_admin/pages/bus_time/add_bus_time/add_bus_time.dart';
import 'package:tathastu_admin/pages/bus_time/service/bus_time_service.dart';
import 'package:tathastu_admin/pages/bus_time/update_bus_time/update_bus_time.dart';
import 'package:tathastu_admin/pages/home/components/sidemenu/sidemenu.dart';

class BusTimePage extends StatefulWidget {
  final Widget child;

  BusTimePage({Key key, this.child}) : super(key: key);

  _BusTimePageState createState() => _BusTimePageState();
}

class _BusTimePageState extends State<BusTimePage> {
  BusTimeService busTimeService = new BusTimeService();
  static Stream<QuerySnapshot> qn;
  @override
  void initState() {
    qn = getDocuments();

    super.initState();
  }

  getDocuments() {
    return busTimeService.getBusTimes();
  }

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
          elevation: 2,
        ),
        body: listViewBuilder(),
        backgroundColor: Colors.white,
        drawer: Drawer(child: SideMenuComponent()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddBusTimePage()));
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget listViewBuilder() {
    return StreamBuilder(
      stream: qn,
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading...');
        } else {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              return listTile(
                  snapshot.data.documents[index]['time'],
                  snapshot.data.documents[index]['source'],
                  snapshot.data.documents[index]['destination'],
                  snapshot.data.documents[index]['stations'],
                  snapshot.data.documents[index].reference.documentID
                      .toString(),
                  index);
              // return tiles(snapshot.data.documents[index].reference);
            },
          );
        }
      },
    );

    // return ListView.separated(
    //   itemCount: listItems.length,
    //   itemBuilder: (BuildContext context, index) {
    //     return listTile(listItems[index]['time'], listItems[index]['busRoute'],
    //         listItems[index]['stations'], index);
    //   },
    //   separatorBuilder: (context, index) {
    //     return Divider();
    //   },
    // );
  }

  Widget tiles(var data) {
    return Container(
      child: Center(
        child: Text(data.documentID.toString()),
      ),
    );
  }

  Widget listTile(DateTime date, String source, String destination,
      String stations, String documentID, int index) {
    TimeOfDay _time = TimeOfDay.fromDateTime(date);

    String _hour =
        (_time.hourOfPeriod == 0 ? '12' : _time.hourOfPeriod.toString())
                    .length <
                2
            ? ('0' + _time.hourOfPeriod.toString())
            : _time.hourOfPeriod.toString();
    String _minute = _time.minute.toString().length < 2
        ? ('0' + _time.minute.toString())
        : _time.minute.toString();
    String _period = _time.period.index == 0 ? 'AM' : 'PM';

    String time = '${_hour} : ${_minute} ${_period}';

    String busRoute = '${source.toUpperCase()} - ${destination.toUpperCase()}';

    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.black12, width: 1.0))),
      child: Slidable(
        delegate: new SlidableDrawerDelegate(),
        actionExtentRatio: 0.25,
        child: new Container(
          color: Colors.white,
          child: Container(
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
              ],
            ),
          ),
        ),
        secondaryActions: <Widget>[
          new IconSlideAction(
            caption: 'Edit',
            color: Colors.orange,
            icon: Icons.edit,
            foregroundColor: Colors.white,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateBusTimePage(
                            document: {
                              'id': documentID,
                              'date': date,
                              'source': source,
                              'destination': destination,
                              'stations': stations
                            },
                          )));
            },
          ),
          new IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              busTimeService.deleteBusTime(documentID).then((value) {
                showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(
                          title: Text('Success'),
                          content: Text('Bus Time is successfully deleted.'),
                        ));
              }).catchError((error) {
                print(error);
                showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(
                          title: Text('Error'),
                          content:
                              Text('An error occured while deleting Bus Time.'),
                        ));
              });
            },
          ),
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
                fontSize: 16.0,
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
}
