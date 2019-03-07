import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SideMenuComponent extends StatefulWidget {
  final Widget child;

  SideMenuComponent({Key key, this.child}) : super(key: key);

  _SideMenuComponentState createState() => _SideMenuComponentState();
}

class _SideMenuComponentState extends State<SideMenuComponent> {

  List<Map<String, dynamic>> listItems = [
      {
        'title': 'Home',
        'iconUrl': 'assets/icons/house.svg',
        'route': '/'
      },
      {
        'title': 'Manage Account',
        'iconUrl': 'assets/icons/analytics.svg',
        'route': '/bus_time'
      },
      {
        'title': 'About Us',
        'iconUrl': 'assets/icons/team.svg',
        'route': ''
      },
      {
        'title': 'Contact Us',
        'iconUrl': 'assets/icons/contact.svg',
        'route': ''
      },
      {
        'title': 'Disclaimer',
        'iconUrl': 'assets/icons/key.svg',
        'route': ''
      },
      {
        'title': 'Logout',
        'iconUrl': 'assets/icons/exit.svg',
        'route': ''
      },
    ];

  @override
  Widget build(BuildContext context) {
    return listViewBuilder(listItems);
  }

  Widget listViewBuilder(List<Map<String, dynamic>> listItems){
    return ListView.builder(
      itemCount: listItems.length,
      itemBuilder: (BuildContext context, index){
        return listTile(listItems[index]['title'], listItems[index]['iconUrl'], listItems[index]['route']);
      },
    );
  }

  Widget listTile(String title, String iconUrl, String route){
    return ListTile(
          leading: Container(
            width: 32,
            height: 32,
            child: SvgPicture.asset(iconUrl),
          ),
          title: Text(title),
          onTap: () {
            Navigator.pushNamed(context, route);
          },
        );
  }

}