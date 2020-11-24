import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  final List<String> task = [
    'Write a book',
    'Do homework',
    'Tidy room',
    'Watch TV',
    'Nap',
    'Shop groceries',
    'Have fun',
    'Meditate',
  ];
  final bool _onChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            'TIG169 TODO',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          actions: <Widget>[
            PopupMenuButton<int>(
              color: Color.fromARGB(225, 214, 176, 159),
              itemBuilder: (context) => <PopupMenuEntry<int>>[
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    'All',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text(
                    'Undone',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
              icon: Icon(Icons.more_vert_rounded, color: Colors.white),
            )
          ],
        ),
        floatingActionButton: Container(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page2()));
              },
              child: Icon(Icons.add_circle),
              backgroundColor: Colors.grey,
            )),
        body: Center(
            child: ListView.separated(
                itemCount: task.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    value: _onChecked,
                    onChanged: (bool value) {},
                    title: Text(
                      '${task[index]}',
                      style: TextStyle(color: Colors.black),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: (Icon(Icons.clear)),
                  );
                })));
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text(
              'TIG169 TODO',
              style: TextStyle(color: Colors.black, fontSize: 25),
            )),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hoverColor: Color.fromRGBO(226, 226, 226, 100),
                border: OutlineInputBorder(),
                labelText: 'e.g. Coding ',
                labelStyle: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Container(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.add_rounded),
                onPressed: () {},
              ),
              Text(
                'ADD',
                style: TextStyle(color: Colors.black, fontSize: 20),
              )
            ],
          )
        ])));
  }
}
