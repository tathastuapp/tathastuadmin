import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tathastu_admin/pages/bus_time/service/bus_time_service.dart';

class UpdateBusTimePage extends StatefulWidget {
  final Widget child;

  final Map<String, dynamic> document;

  UpdateBusTimePage({Key key, this.child, this.document}) : super(key: key);

  _UpdateBusTimePageState createState() => _UpdateBusTimePageState();
}

class _UpdateBusTimePageState extends State<UpdateBusTimePage> {
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  String _id = '',
      _source = '',
      _destination = '',
      _stations = '',
      _city = 'patan';
  GlobalKey<FormState> addBusTimeFormKey = new GlobalKey<FormState>();

  TextEditingController _sourceController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _stationsController = TextEditingController();

  BusTimeService busTimeService = new BusTimeService();

  @override
  void initState() {
    this._id = widget.document['id'];
    this._time = TimeOfDay.fromDateTime(widget.document['date']);
    this._sourceController.text = widget.document['source'];
    this._destinationController.text = widget.document['destination'];
    this._stationsController.text = widget.document['stations'];

    super.initState();
  }

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
        (_time.hourOfPeriod == 0 ? '12' : _time.hourOfPeriod.toString())
                    .length <
                2
            ? ('0' + _time.hourOfPeriod.toString())
            : _time.hourOfPeriod.toString();
    String _minute = _time.minute.toString().length < 2
        ? ('0' + _time.minute.toString())
        : _time.minute.toString();
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
        validator: (value) {
          if (value.length < 2) {
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
        validator: (value) {
          if (value.length < 2) {
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
        validator: (value) {
          if (value.length < 2) {
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

  Widget buildSubmitFormButton() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: RaisedButton(
        padding: EdgeInsets.all(20.0),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(4.0)),
        color: Colors.blue,
        child: Text(
          'SUBMIT',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: updateBusTime,
      ),
    );
  }

  updateBusTime() {
    if (addBusTimeFormKey.currentState.validate() && _time != null) {
      addBusTimeFormKey.currentState.save();

      print('Document Reference in Update Page : $_id');

      busTimeService
          .updateBusTime(_id, _date, _source.toUpperCase(),
              _destination.toUpperCase(), _stations, false, _city)
          .then((value) {
        print('Bus Time document Updated : $value');
        _time = TimeOfDay.now();
        _sourceController.text = '';
        _destinationController.text = '';
        _stationsController.text = '';
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: Text('Success'),
                  content: Text('Bus Time is successfully updated.'),
                ));
      }).catchError((error) {
        print(error);
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: Text('Error'),
                  content: Text('An error occured while updating Bus Time.'),
                ));
      });
    }
  }
}
