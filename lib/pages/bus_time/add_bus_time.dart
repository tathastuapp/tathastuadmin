import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tathastu_admin/pages/bus_time/service/bus_time_service.dart';

class AddBusTimePage extends StatefulWidget {
  final Widget child;

  AddBusTimePage({Key key, this.child}) : super(key: key);

  _AddBusTimePageState createState() => _AddBusTimePageState();
}

class _AddBusTimePageState extends State<AddBusTimePage> {
  DateTime _date = DateTime(1970);
  TimeOfDay _time = TimeOfDay.now();
  String _source = '', _destination = '', _stations = '', _city = 'patan';
  bool isExpress = false;
  GlobalKey<FormState> addBusTimeFormKey =
      new GlobalKey<FormState>();

  TextEditingController _sourceController =TextEditingController();
  TextEditingController _destinationController =TextEditingController();
  TextEditingController _stationsController =TextEditingController();

  BusTimeService busTimeService = new BusTimeService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Bus Time',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: buildAddBusTimeForm(),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget buildAddBusTimeForm() {
    return Form(
      key: addBusTimeFormKey,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          buildSelectTimeField(),
          buildSelectSource(),
          buildSelectDestination(),
          buildSelectStations(),
          buildIsExpressField(),
          buildSubmitFormButton()
        ],
      ),
    );
  }

  selectTime() async {
    final picked = await showTimePicker(initialTime: _time, context: context);

    if (picked != null) {
      setState(() {
        _time = picked;
      });
      print('Time Selected : ${_time.toString()}');
    }
  }

  Widget buildSelectTimeField() {
    String _hour =
        (_time.hourOfPeriod == 0) ? '12' : (_time.hourOfPeriod.toString().length < 2) ? ('0'+_time.hourOfPeriod.toString()) : _time.hourOfPeriod.toString();
    String _minute = _time.minute.toString().length < 2 ? ('0'+_time.minute.toString()):_time.minute.toString();
    String _period = _time.period.index == 0 ? 'AM' : 'PM';

    _date =
        DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '$_hour : $_minute $_period',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            RaisedButton(
              child: Row(
                children: <Widget>[
                  Container(
                      height: 40.0,
                      width: 40.0,
                      padding: EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/icons/clock.svg')),
                  Text(
                    'SELECT TIME',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(4.0)),
              color: Colors.white,
              onPressed: selectTime,
            ),
          ],
        ));
  }

  Widget buildSelectSource() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: const InputDecoration(
          // border: OutlineInputBorder(),
          // icon: Icon(Icons.message),
          hintText: 'Source Station',
          labelText: 'Source',
          border: OutlineInputBorder(),
        ),
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.black87,
        ),
        controller: _sourceController,
        validator: (value){
          if(value.length <2){
            return 'Minimum 2 characters required';
          }
        },
        onSaved: (value) {
          setState(() {
            _source = value;
          });
        },
      ),
    );
  }

  Widget buildSelectDestination() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: const InputDecoration(
          // border: OutlineInputBorder(),
          // icon: Icon(Icons.message),
          hintText: 'Destination Station',
          labelText: 'Destination',
          border: OutlineInputBorder(),
        ),
        style: TextStyle(fontSize: 20.0, color: Colors.black87),
        validator: (value){
          if(value.length <2){
            return 'Minimum 2 characters required';
          }
        },
        controller: _destinationController,
        onSaved: (value) {
          setState(() {
            _destination = value;
          });
        },
      ),
    );
  }

  Widget buildSelectStations() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: const InputDecoration(
          // border: OutlineInputBorder(),
          // icon: Icon(Icons.message),
          hintText: 'Bus Stations',
          labelText: 'Stations',
          border: OutlineInputBorder(),
        ),
        style: TextStyle(fontSize: 20.0, color: Colors.black87),
        validator: (value){
          if(value.length <2){
            return 'Minimum 2 characters required';
          }
        },
        controller: _stationsController,
        onSaved: (value) {
          setState(() {
            _stations = value;
          });
        },
      ),
    );
  }

  Widget buildIsExpressField(){
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Checkbox(
              value: isExpress,
              onChanged: (bool value){
                setState(() {
                 isExpress = value; 
                });
              },
            ),
          ),
          Container(
            child: Text('Is Express Bus ?',
            style: TextStyle(fontSize: 20.0, color: Colors.black87),),
          )
        ],
      ),
    );
  }

  Widget buildSubmitFormButton() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: RaisedButton(
        padding: EdgeInsets.all(18.0),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(4.0)),
        color: Colors.blue,
        child: Text(
          'SUBMIT',
          style: TextStyle(color: Colors.white, fontSize: 16.0,),
        ),
        onPressed: addBusTime,
      ),
    );
  }

  addBusTime() {
    if (addBusTimeFormKey.currentState.validate() && _time != null) {
      addBusTimeFormKey.currentState.save();
      busTimeService
          .addBusTime(_date, _source.toUpperCase(), _destination.toUpperCase(), _stations, isExpress, _city)
          .then((value) {
        print('Bus Time document added : $value');

        setState(() {
          _time = TimeOfDay.now();
        _sourceController.text = '';
        _destinationController.text = '';
        _stationsController.text = '';
        isExpress =false;
        });

        
        showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
          title: Text('Success', style:TextStyle(color:Colors.green)),
          content: Text('Bus Time is successfully added.'),
          actions: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text('OKAY', style: TextStyle(color: Colors.white)),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        )
    );
        
      }).catchError((error) {
        print('An error occured while adding Bus Time');
        showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: Text('Error'),
          content: Text('An error occured while adding Bus Time.'),
        )
    );
      });
    }
  }
}
