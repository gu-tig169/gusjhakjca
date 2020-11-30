import 'dart:convert';
import 'TaskItem.dart';
import 'package:http/http.dart' as http;

const API_URL = 'https://todoapp-api-vldfm.ondigitalocean.app';
const API_KEY = '3fb12e27-9dbb-473e-a876-19b22cb486bc';

class Api {
  // Lägga till data
  static Future addTaskApi(TaskItem task) async {
    Map<String, dynamic> json = TaskItem.toJson(task);
    var bodyString = jsonEncode(json);
    await http.post(
      '$API_URL/todos?key=$API_KEY',
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
  }

// Ta bort data med id
  static Future deleteTask(String id) async {
    await http.delete('$API_URL/todos/$id?key=$API_KEY');
  }

//  Uppdatera data med id
  static Future updateTask(TaskItem task, String taskId) async {
    var json = jsonEncode(TaskItem.toJson(task));
    await http.put(
      '$API_URL/todos/$taskId?key=$API_KEY',
      body: json,
      headers: {'Content-Type': 'application/json'},
    );
  }

  static Future<List<TaskItem>> getTasksApi() async {
    var response = await http.get('$API_URL/todos?key=$API_KEY');
    String bodyString = response.body;
    var json = jsonDecode(bodyString);
    return json.map<TaskItem>((data) {
      return TaskItem.fromJson(data);
    }).toList();
  }
}
