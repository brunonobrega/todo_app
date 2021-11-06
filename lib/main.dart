import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/counter.dart';
import 'package:todo_app/widgets/new_todo.dart';
import 'package:todo_app/widgets/todo_list.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Todo> todos = [
    Todo(id: Uuid(), title: "Clean Room", completed: true),
    Todo(id: Uuid(), title: "Pet the Cat", completed: true),
    Todo(id: Uuid(), title: "Dance", completed: false),
  ];

  void _updateTodoCompletions(int index) {
    setState(() {
      todos[index].completed = !todos[index].completed;
    });
  }

  int _calcTotalCompeltions() {
    var totalCompletions = 0;

    todos.forEach((todo) {
      if(todo.completed) {
        totalCompletions++;
      }
    });

    return totalCompletions;
  }

  void _showAddTodoModal(BuildContext context) {
    showModalBottomSheet(context: context, builder: (bCtx) {
      return NewTodo(addTodo: _addTodo);
    });
  }
  void _addTodo(String todo) {
    setState(() {
      todos.add(Todo(
        id: Uuid(),
        completed: false,
        title: todo
      ));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Counter(
              numberOfTodos: todos.length,
              totalCompletions: _calcTotalCompeltions(),
            ),
            TodoList(todos: todos, updateTodoCompletions: _updateTodoCompletions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoModal(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

}
