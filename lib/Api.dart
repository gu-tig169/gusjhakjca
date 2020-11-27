import 'dart:convert';
import 'Task.dart';
import 'package:http/http.dart' as http;

const API_URL = 'https://todoapp-api-vldfm.ondigitalocean.app';
const API_KEY = '8e18515a-e9a0-4245-8917-7b30364a2932';

class Api {
  // Lägga till data
  static Future addTaskApi(Task task) async {
    Map<String, dynamic> json = Task.toJson(task);
    var bodyString = jsonEncode(json);
    await http.post(
      '$API_URL/todos?key=$API_KEY',
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
  }

// Ta bort data med id
  static Future deleteTaskApi(String id) async {
    await http.delete('$API_URL/todos/$id?key=$API_KEY');
  }

//  Uppdatera data med id
  static Future updateTask(Task task, String taskId) async {
    var json = jsonEncode(Task.toJson(task));
    await http.put(
      '$API_URL/todos/$taskId?key=$API_KEY',
      body: json,
      headers: {'Content-Type': 'application/json'},
    );
  }

  static Future<List<Task>> getTasksApi() async {
    var response = await http.get('$API_URL/todos?key=$API_KEY');
    String bodyString = response.body;
    var json = jsonDecode(bodyString);
    return json.map<Task>((data) {
      return Task.fromJson(data);
    }).toList();
  }
}
