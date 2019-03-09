import 'package:flutter/material.dart';
import 'package:tathastu_admin/pages/bus_time/bus_time.dart';
import 'package:tathastu_admin/pages/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tathastu Admin App',
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/bus_time': (context) => BusTimePage(),
        '/train_time': (context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

