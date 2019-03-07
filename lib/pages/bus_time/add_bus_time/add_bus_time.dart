import 'package:flutter/material.dart';

class AddBusTimePage extends StatefulWidget {
  final Widget child;

  AddBusTimePage({Key key, this.child}) : super(key: key);

  _AddBusTimePageState createState() => _AddBusTimePageState();
}

class _AddBusTimePageState extends State<AddBusTimePage> {
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
        body: buildAddBusTimeForm(),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget buildAddBusTimeForm(){
    return ListView(
      children: <Widget>[
        buildSelectTimeField(),
        buildSelectSource(),
        buildSelectDestination(),
        buildSubmitFormButton()
      ],
    );
  }

  Widget buildSelectTimeField(){
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    // icon: Icon(Icons.message),
                    hintText: 'Select Time',
                    labelText: 'Time',
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(fontSize: 20.0, color: Colors.black87),
                  // validator: OtpValidator.validate,
                  onSaved: (value) {
                    
                  },
                ),
    );
  }
  
  Widget buildSelectSource(){
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
                  style: TextStyle(fontSize: 20.0, color: Colors.black87),
                  // validator: OtpValidator.validate,
                  onSaved: (value) {
                    
                  },
                ),
    );
  }

  Widget buildSelectDestination(){
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
                  // validator: OtpValidator.validate,
                  onSaved: (value) {
                    
                  },
                ),
    );
  }

  Widget buildSubmitFormButton(){
    return Container(
      padding: EdgeInsets.all(8.0),
      child: FlatButton(
        
        child: Text('SUBMIT'),
        onPressed: (){},
      )
    );
  }

}