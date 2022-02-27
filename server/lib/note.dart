import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/connectdb.dart';

class Note {
  static Future<Response> getAll(Request req) async {
    var data = {};
    int i = 0;
    await for (final val in notes.find()) {
      data[i.toString()] = val;
      i++;
    }
    return Response.ok(jsonEncode(data),
        headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> getChildren(Request req, String parentId) async {
    var data = {};
    int i = 0;
    await for (final val in notes.find(where.eq('parent', parentId))) {
      print(val);
      data[i.toString()] = val;
      i++;
    }
    print(data);
    return Response.ok(jsonEncode(data),
        headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> deleteAll(Request req) async {
    var result = await notes.deleteMany(where.exists('_id'));
    return Response.ok(result.toString(),
        headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> getId(Request req, String noteId) async {
    var result =
        await notes.findOne(where.eq("_id", ObjectId.fromHexString(noteId)));
    return Response.ok(jsonEncode(result),
        headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> postId(Request req, String parentId) async {
    var body = await req.readAsString();
    Map<String, dynamic> toAdd = json.decode(body);
    toAdd["parent"] = parentId;
    toAdd["children"] = [];
    toAdd["tags"] = [];
    toAdd["type"] = "";
    toAdd["title"] = "";
    toAdd["entry"] = "";
    toAdd["progress"] = {"complete": false, "deaths": 0};
    var result = await notes.insertOne(toAdd);
    //print(result.document); //The code will use result.document in the future.
    var childNote =
        await notes.findOne(where.eq('_id', result.id)).then((futureNote) {
      notes.update(where.eq('_id', ObjectId.fromHexString(parentId)),
          modify.push("children", futureNote?["_id"]));
      return futureNote;
    });
    return Response.ok(json.encode(childNote),
        headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> putId(Request req, String noteId) async {
    var body = await req.readAsString();
    Map<String, dynamic> data = jsonDecode(body);
    Map<String, dynamic> filtered = {};
    data.forEach((key, value) {
      if (key != '_id') {
        filtered[key] = value;
      }
    });
    await notes.update(
        where.eq('_id', ObjectId.fromHexString(noteId)), filtered);
    var search =
        await notes.findOne(where.eq('_id', ObjectId.fromHexString(noteId)));
    return Response.ok(jsonEncode(search),
        headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> deleteId(Request req, String noteId) async {
    var search =
        await notes.findOne(where.eq('_id', ObjectId.fromHexString(noteId)));
    await notes.deleteOne(where.eq('_id', ObjectId.fromHexString(noteId)));
    //This function still needs to delete children[id] from it's parent's note.
    return Response.ok(jsonEncode(search),
        headers: {'Content-Type': 'application/json'});
  }
}

//   // final coll = db.collection('contacts');

//   sevr.get("/", [
//     (ServRequest req, ServResponse res) async {
//       // final contacts = await coll.find().toList();
//       // return res.status(200).json({'contacts': contacts});
//     }
//   ]);

//   sevr.post('/', [
//     (ServRequest req, ServResponse res) async {
//       // await coll.save(req.body);
//       // return res.json(
//       //   await coll.findOne(where.eq('name', req.body['name'])),
//       // );
//     }
//   ]);

//   sevr.delete('/:id', [
//     (ServRequest req, ServResponse res) async {
//       // await coll
//       //     .remove(where.eq('_id', ObjectId.fromHexString(req.params['id'])));
//       // return res.status(200);
//     }
//   ]);