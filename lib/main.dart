import 'package:flutter/material.dart';
import 'package:tathastu_admin/pages/bus_time/bus_time.dart';
import 'package:tathastu_admin/pages/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

