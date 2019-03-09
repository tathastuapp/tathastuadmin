import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tathastu_admin/pages/category/add_category_type.dart';
import 'package:tathastu_admin/pages/category/services/category_type_service.dart';
import 'package:tathastu_admin/pages/home/components/sidemenu/sidemenu.dart';

class CategoryTypePage extends StatefulWidget {
  final Widget child;

  CategoryTypePage({Key key, this.child}) : super(key: key);

  _CategoryTypePageState createState() => _CategoryTypePageState();
}

class _CategoryTypePageState extends State<CategoryTypePage> {
  CategoryTypeService busTimeService = new CategoryTypeService();
  static Stream<QuerySnapshot> qn;
  @override
  void initState() {
    qn = getDocuments();

    super.initState();
  }

  getDocuments() {
    return busTimeService.getCategoryTypes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Category Type List',
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
                MaterialPageRoute(builder: (context) => AddCategoryTypePage()));
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
                  // snapshot.data.documents[index]['time'],
                  // snapshot.data.documents[index]['source'],
                  // snapshot.data.documents[index]['destination'],
                  // snapshot.data.documents[index]['stations'],
                  // snapshot.data.documents[index].reference.documentID.toString(),
                  // index
                  );
              // return tiles(snapshot.data.documents[index].reference);
            },
          );
        }
      },
    );
  }

  Widget listTile() {
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
                    buildCategoryTypeIcon(),
                    buildCaterogyTypeTitle(),
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
            onTap: () {},
          ),
          new IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget buildCategoryTypeIcon(){
    return Container(
              height: 40.0,
              width: 40.0,
              padding: EdgeInsets.all(8.0),
              child: SvgPicture.asset('assets/icons/clock.svg'));
  }

  buildCaterogyTypeTitle(){
    return Container(
      child: Center(child: Text('Category Type Title',
      style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[850],
                fontWeight: FontWeight.w600),
          )),
    );
  }

}
