import 'dart:convert';
import 'task.dart';
import 'package:http/http.dart' as http;

const API_URL = 'https://todoapp-api-vldfm.ondigitalocean.app';
const API_KEY = '9a32ccc5-0532-43e1-90f0-4b256dd51d5e';

class Api {
  static Future addTask(Task task) async {
    print(task);
    Map<String, dynamic> json = Task.toJson(task);
    var bodyString = jsonEncode(json);
    print(json);
    await http.post(
      '$API_URL/todos?key=$API_KEY',
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
    print('done');
  }

  static Future deleteTask(String id) async {
    await http.delete('$API_URL/todos/$id?key=$API_KEY');
  }

  static Future<List<Task>> getTasks() async {
    var response = await http.get('$API_URL/todos?key=$API_KEY');
    String bodyString = response.body;
    print(response.body);
    var json = jsonDecode(bodyString);
    print(json);

    return json.map<Task>((data) {
      return Task.fromJson(data);
    }).toList();
  }
}
