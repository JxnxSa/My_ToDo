import 'package:flutter/material.dart';
import 'package:homework_5/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<ToDo> todoList = [
  ToDo(
    id: '01',
    todoText: 'ทำการบ้านครั้งที่ 4 วิชา Mobile App Dev',
    isDone: true,
  ),
  ToDo(
    id: '02',
    todoText: 'ทำการบ้านครั้งที่ 5 วิชา Mobile App Dev',
    isDone: false,
  ),
  ToDo(
    id: '03',
    todoText: 'ทำโปรเจ็ควิชา Mobile App Dev',
    isDone: false,
  ),
];

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todoList.add(ToDo(
        id: (todoList.length+1).toString(),
        todoText: toDo,
      ));
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.check_box),
            const Text(' My ToDo'),
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int id) {
                var ToDo = todoList[id];
                return Card(
                  margin: EdgeInsets.only(
                    bottom: 10,
                    right: 20,
                    left: 20,
                    top: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _handleToDoChange(ToDo);
                          },
                          child: Container(
                              width: 40.0,
                              height: 40.0,
                              child: ToDo.isDone
                                  ? Icon(
                                      Icons.check_box,
                                      color: Colors.blue,
                                      size: 24.0,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors.grey,
                                      size: 24.0,
                                    )),
                          customBorder: CircleBorder(),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${ToDo.todoText}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  decoration: ToDo.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _deleteToDoItem(ToDo.id.toString());
                                  });
                                },
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                    size: 24.0,
                                  ),
                                ),
                                customBorder: CircleBorder(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: todoList.length,
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter new ToDo',
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _addToDoItem(_controller.text);
                      });
                    },
                    child: Container(
                        width: 50.0,
                        height: 30.0,
                        alignment: Alignment.center,
                        child: Text(
                          'ADD',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        )),
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
