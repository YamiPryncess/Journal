import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/connectdb.dart';

class Root {
  Root() {
    notes.db.open();
  }

  static Future<Response> get(Request req) async {
    var result = await notes.findOne(where.eq('root', true));
    return Response.ok(jsonEncode(result),
        headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> post(Request req) async {
    var search = await notes.findOne(where.eq('root', true));
    if (search == null) {
      var body = await req.readAsString();
      var title = jsonDecode(body)['title'];
      var root = {
        "root": true,
        "children": [],
        "title": title,
        "type": "",
        "tags": [],
        "entry": "",
        "progress": {"complete": "true", "deaths": 0},
      };

      await notes.insertOne(root);
      var creation = await notes.findOne(where.eq('root', true));
      return Response.ok(jsonEncode(creation),
          headers: {'Content-Type': 'application/json'});
    }
    return Response(409);
  }

  static Future<Response> delete(Request req) async {
    var result = await notes.deleteOne(where.eq('root', true));
    return Response.ok(jsonEncode(result.toString()),
        headers: {'Content-Type': 'application/json'});
  }
}
