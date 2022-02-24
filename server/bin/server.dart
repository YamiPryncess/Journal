import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:server/note.dart';
import 'package:server/tag.dart';
import 'package:server/root.dart';
import 'package:server/connectdb.dart';

// Configure routes.
final _router = Router()
  //Root
  ..get('/root', Root.get)
  ..post('/root', Root.post)
  ..delete('/root', Root.delete)
  //Notes
  ..get('/notes', Note.get)
  ..get('/note/<id>', Note.getId)
  ..post('/note/<id>', Note.postId)
  ..put('/note/<id>', Note.putId)
  ..delete('/note/<id>', Note.deleteId)
  //Tags
  ..get('/tag', Tag.get)
  ..post('/tag', Tag.post)
  ..put('/tag', Tag.put)
  ..delete('/tag', Tag.delete)
  ..get('/echo/<message>', _echoHandler);

Response _echoHandler(Request request) {
  final message = params(request, 'message');
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  connectdb();
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final _handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse("8081"); //Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);
  print('Server listening on port ${server.port}');
}
