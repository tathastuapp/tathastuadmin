import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:tathastu_admin/pages/category/services/category_type_service.dart';
import 'package:tathastu_admin/pages/category/services/icon_upload_service.dart';

class AddCategoryTypePage extends StatefulWidget {
  final Widget child;

  AddCategoryTypePage({Key key, this.child}) : super(key: key);

  AddCategoryTypePageState createState() => AddCategoryTypePageState();
}

class AddCategoryTypePageState extends State<AddCategoryTypePage> {
  String _name = '',_city = 'patan';
  String _extension = '';
  GlobalKey<FormState> addBusTimeFormKey = new GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  File categoryTypeIcon;
  CategoryTypeService categoryTypeService = new CategoryTypeService();
  IconUploadService iconUploadService = new IconUploadService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Category Type',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: buildAddCategoryTypeForm(),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget buildAddCategoryTypeForm() {
    return Form(
      key: addBusTimeFormKey,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          buildCategoryTypeNameField(),
          buildUploadIconField(),
          buildSubmitFormButton()
        ],
      ),
    );
  }

  Widget buildCategoryTypeNameField() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: const InputDecoration(
          // border: OutlineInputBorder(),
          // icon: Icon(Icons.message),
          hintText: 'Category Type Name',
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.black87,
        ),
        controller: _nameController,
        validator: (value) {
          if (value.length < 2) {
            return 'Minimum 2 characters required';
          }
        },
        onSaved: (value) {
          setState(() {
            _name = value;
          });
        },
      ),
    );
  }

  Future getImage() async {
    var tempFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      categoryTypeIcon = tempFile;
    });
  }

  Widget buildUploadIconField() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          OutlineButton(
            child: Text('Upload Image'),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0)),
            onPressed: getImage,
          ),
          categoryTypeIcon != null
              ? Expanded(child: Text(path.basename(categoryTypeIcon.path)))
              : Container(),
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        onPressed: addCategoryType,
      ),
    );
  }

  addCategoryType() {
    if (addBusTimeFormKey.currentState.validate()) {
      addBusTimeFormKey.currentState.save();

      _extension = path.extension(categoryTypeIcon.path.toString());

      iconUploadService
          .uploadIcon(_name, _extension, categoryTypeIcon)
          .then((data) {
        categoryTypeService
            .addCategoryType(_name, data[0], data[1])
            .then((value) {
          print('Category Type document added : $value');
          _nameController.text = '';
          categoryTypeIcon = null;
        }).catchError((error) {
          print('An error occured while adding Category Type');
        });
      }).catchError((error) {
        print('An error occured while uploading Category Type Icon');
      });
    }
  }
}
