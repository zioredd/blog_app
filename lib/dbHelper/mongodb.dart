import 'dart:developer';
import 'package:blog_app/dbHelper/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDbClient {
  static Db? _db;

  static Future<Db> connect() async {
    if (_db == null) {
      _db = await Db.create(MONGODB_URI);
      await _db!.open();
      inspect(_db);
      var collection = _db!.collection('users');
      final document = await collection.insertOne(
          {"name": "name", "email": "zior@gamail.com", "password": "123zior"});
      print("mongodb.dart ${document}");
    }
    return _db!;
  }
}
