import 'dart:convert';
import 'TaskItem.dart';
import 'package:http/http.dart' as http;

const API_URL = 'https://todoapp-api-vldfm.ondigitalocean.app';
const API_KEY = '765b6422-a5d6-4b97-9514-90f3fc7a9668';

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
  static Future deleteTask(String id) async {
    await http.delete('$API_URL/todos/$id?key=$API_KEY');
  }

//  Uppdatera data
  static Future updateTask(TaskItem task) async {
    Map<String, dynamic> json = TaskItem.toJson(task);
    print(json);
    var taskid = task.taskId;
    await http.put('$API_URL/todos/$taskid?key=$API_KEY',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'title': task.title,
          'done': task.status,
        }));
  }

  static Future<List<TaskItem>> getTasks() async {
    var response = await http.get('$API_URL/todos?key=$API_KEY');
    String bodyString = response.body;
    var json = jsonDecode(bodyString);
    return json.map<TaskItem>((todo) {
      return TaskItem.fromJson(todo);
    }).toList();
  }
}
