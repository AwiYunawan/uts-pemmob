import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Katalog');

class FirebaseCrud {
//CRUD method here
  static Future<Response> addKatalog({
    required String nama,
    required String deskripsi,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "deskripsi": deskripsi,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Berhasil masuk ke database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readKatalog() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> updateKatalog({
    required String nama,
    required String deskripsi,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "deskripsi": deskripsi
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Update Katalog Sukses";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> deleteKatalog({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Data Katalog Telah Dihapus";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
