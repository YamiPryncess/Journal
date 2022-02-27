import 'dart:convert';
import 'package:dio/dio.dart';

final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8081/'));

Future getRoot() async {
  final response = await _dio.get('/root',
      queryParameters: {},
      options: Options(headers: {'Content-Type': 'application/json'}));
  return response.data;
  // return {"name": "Elden Ring"};
}

Future postRoot() async {
  final response = await _dio.post('/root',
      data: {"title": "First Entry"},
      options: Options(headers: {'Content-Type': 'application/json'}));
  return response.data;
  // return {"name": "Elden Ring"};
}

Future getNotes() async {
  final response = await _dio.get('/notes',
      queryParameters: {},
      options: Options(headers: {'Content-Type': 'application/json'}));
  return response.data;
}

Future getChildren(String id) async {
  final response = await _dio.get('/notes/' + id,
      queryParameters: {},
      options: Options(headers: {'Content-Type': 'application/json'}));
  return response.data;
}

Future getNote(String id) async {
  final response = await _dio.get('/note/' + id,
      queryParameters: {},
      options: Options(headers: {'Content-Type': 'application/json'}));
  return response.data;
}

Future postNote(Map _data) async {
  final response = await _dio.post('/note/' + _data['_id'],
      data: {},
      options: Options(headers: {'Content-Type': 'application/json'}));
  return response.data;
}

Future putNote(Map _data) async {
  final response = await _dio.put('/note/' + _data['_id'],
      data: _data,
      options: Options(headers: {'Content-Type': 'application/json'}));
  return response.data;
}

initializeInterceptors() {
  _dio.interceptors
      .add(InterceptorsWrapper(onError: (error, ErrorInterceptorHandler) {
    print(error.message);
  }, onRequest: (request, RequestInterceptorHandler) {
    print("${request.method} ${request.path}");
  }, onResponse: (response, ResponseInterceptorHandler) {
    print(response.data);
  }));
}

// Options(headers: {
//           'Content-type': 'application/json; charset=UTF-8',
//         })
