import 'package:cloud_firestore/cloud_firestore.dart';

class BusTimeService {
  
  DocumentReference documentReference;

  Stream<QuerySnapshot> getBusTimes() {
    return Firestore.instance.collection('bus-times').where('city', isEqualTo: 'patan').snapshots();
  }

  Future<bool> addBusTime(DateTime time, String source, String destination, String stations, String city) async{
    documentReference = await Firestore.instance.collection('bus-times').add({
      'time' :time,
      'source':source,
      'destination':destination,
      'stations':stations,
      'city': city
    });
    return true;
  }

  Future<bool> updateBusTime(String id, DateTime time, String source, String destination, String stations, String city) async{
    
    print('Document Referecnce To Update : ${id}');

    await Firestore.instance.collection('bus-times').document(id).updateData({
      'time' :time,
      'source':source,
      'destination':destination,
      'stations':stations,
      'city': city
    });
    return true;
  }

  Future<bool> deleteBusTime(String id) async{
    await Firestore.instance.collection('bus-times').document(id).delete();
    return true;
  }

}