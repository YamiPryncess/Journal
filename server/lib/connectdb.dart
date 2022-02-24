import 'package:mongo_dart/mongo_dart.dart';

Db db = new Db('mongodb://localhost:27017/journal');
DbCollection notes = DbCollection(db, "Notes");
connectdb() {
  db.open();
}
