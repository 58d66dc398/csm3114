import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('http://10.0.2.2:8090');

class Data {
  static bool isLoggedIn() {
    return pb.authStore.isValid;
  }

  static Map<String, dynamic> getCurrentUser() {
    return (pb.authStore.model as RecordModel).toJson();
  }

  static void deAuthUser() {
    pb.authStore.clear();
  }

  static Future<Map<String, dynamic>> authUser(Map<String, String> body) async {
    Map<String, dynamic> response = {};
    try {
      String username = body['username']!, password = body['password']!;
      await pb.collection('users').authWithPassword(username, password);
    } on ClientException catch (e) {
      response = e.response;
    }
    if (kDebugMode) {
      print('DEBUG: $response');
    }
    return response;
  }

  static Future<Map<String, dynamic>> addUser(Map<String, dynamic> body) async {
    Map<String, dynamic> response = {};
    try {
      RecordModel rm = await pb.collection('users').create(body: body);
      response = rm.data;
    } on ClientException catch (e) {
      response = e.response;
    }
    if (kDebugMode) {
      print('DEBUG: $response');
    }
    return response;
  }

  static List<Map<String, dynamic>> trucks = [];

  static Future<void> loadTrucks() async {
    await pb.collection("users").authRefresh();
    List<RecordModel> response = await pb
        .collection('trucks')
        .getFullList(filter: 'owner="${pb.authStore.model.id}"');
    // if (kDebugMode) {
    //   for (final e in response) {
    //     print(e.toString());
    //   }
    // }
    trucks = response.map((e) => e.toJson()).toList();
  }

  static Future<Map<String, dynamic>> addTruck(
      Map<String, dynamic> body) async {
    Map<String, dynamic> response = {};
    try {
      RecordModel rm = await pb.collection('trucks').create(body: body);
      response = rm.data;
    } on ClientException catch (e) {
      response = e.response;
    }
    if (kDebugMode) {
      print('DEBUG: $response');
    }
    return response;
  }

  static Future<Map<String, dynamic>> updateTruck(
      String id, Map<String, dynamic> body) async {
    Map<String, dynamic> response = {};
    try {
      RecordModel rm = await pb.collection('trucks').update(id, body: body);
      response = rm.data;
    } on ClientException catch (e) {
      response = e.response;
    }
    if (kDebugMode) {
      print('DEBUG: $response');
    }
    return response;
  }

  static Future<void> deleteTruck(String id) async {
    await pb.collection('trucks').delete(id);
  }

  static List<Map<String, dynamic>> schedules = [];

  static Future<void> loadSchedules() async {
    List<RecordModel> response = await pb
        .collection('schedules')
        .getFullList(filter: 'user="${pb.authStore.model.id}"');
    // if (kDebugMode) {
    //   for (final e in response) {
    //     print(e.toString());
    //   }
    // }
    schedules = response.map((e) => e.toJson()).toList();
  }

  static Future<Map<String, dynamic>> addSchedule(
    Map<String, dynamic> body,
  ) async {
    Map<String, dynamic> response = {};
    try {
      RecordModel rm = await pb.collection('schedules').create(body: body);
      response = rm.data;
    } on ClientException catch (e) {
      response = e.response;
    }
    if (kDebugMode) {
      print('DEBUG: $response');
    }
    return response;
  }

  static Future<Map<String, dynamic>> updateSchedule(
      String id, Map<String, dynamic> body) async {
    Map<String, dynamic> response = {};
    try {
      RecordModel rm = await pb.collection('schedules').update(id, body: body);
      response = rm.data;
    } on ClientException catch (e) {
      response = e.response;
    }
    if (kDebugMode) {
      print('DEBUG: $response');
    }
    return response;
  }

  static Future<void> deleteSchedule(String id) async {
    await pb.collection('schedules').delete(id);
  }

}
