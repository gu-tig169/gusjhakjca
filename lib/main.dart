import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TaskListView.dart';
import 'TaskItem.dart';

void main() {
  var state = TaskState();
  state.getList();

  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TIG169 TODO',
      home: TaskListView(),
    );
  }
}
