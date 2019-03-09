
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryTypeService {
  Stream<QuerySnapshot> qn;
  DocumentReference documentReference;


  Stream<QuerySnapshot> getCategoryTypes() {
    return Firestore.instance.collection('category_types').where('city', isEqualTo: 'patan').snapshots();
  }

  Future<bool> addCategoryType(String name, String iconUrl, String iconPath)async {
    documentReference = await Firestore.instance.collection('category_types').add({
      'name': name,
      'iconUrl': iconUrl,
      'iconPath': iconPath,
    });
    return true;
  }

  Future<void> updateCategoryType(String id, String name, String iconUrl, String iconPath) async{
    await Firestore.instance.collection('category_types').
    document(id)
    .updateData({
      'name': name,
      'iconUrl': iconUrl,
      'iconPath': iconPath,
    });
    
  }

  Future<void> deleteCategoryType(String id) async{
    await Firestore.instance.collection('category_types').
    document(id)
    .delete();
  }

}