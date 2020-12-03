import 'dart:convert';
import 'TaskItem.dart';
import 'package:http/http.dart' as http;

const API_URL = 'https://todoapp-api-vldfm.ondigitalocean.app';
const API_KEY = '7bed00ca-6040-4be3-b026-c6d354a8fe3b';

class Api {
  // Lägga till data
  static Future addTask(TaskItem task) async {
    Map<String, dynamic> json = TaskItem.toJson(task);
    print(json);

    await http.post('$API_URL/todos?key=$API_KEY',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'title': task.title,
          'done': task.status,
        }));
  }

// Ta bort data
  static Future deleteTask(String taskId) async {
    await http.delete('$API_URL/todos/$taskId?key=$API_KEY');
  }

//  Uppdatera data
  static Future updateTask(String taskId, TaskItem task) async {
    Map<String, dynamic> json = TaskItem.toJson(task);
    print(json);
    await http.put('$API_URL/todos/$taskId?key=$API_KEY',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'title': task.title,
          'done': task.status,
        }));
  }

  static Future<List<TaskItem>> getTasks() async {
    var url = '$API_URL/todos?key=$API_KEY';
    print(url);
    var response = await http.get('$API_URL/todos?key=$API_KEY');
    String bodyString = response.body;
    print(response.body);
    var json = jsonDecode(bodyString);
    print(json);
    return json.map<TaskItem>((data) {
      return TaskItem.fromJson(data);
    }).toList();
  }
}
