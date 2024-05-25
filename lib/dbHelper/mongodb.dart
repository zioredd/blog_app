import 'dart:developer';
import 'package:blog_app/dbHelper/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDbClient {
  static Db? db;

  static Future<Db> connect() async {
    if (db == null) {
      db = await Db.create(MONGODB_URI);
      await db!.open();
      inspect(db);
    }
    return db!;
  }
}
