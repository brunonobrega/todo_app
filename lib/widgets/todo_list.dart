import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_cards.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(int) updateTodoCompletions;

  TodoList({required this.todos, required this.updateTodoCompletions});

  // const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        itemBuilder: (ctx, i) {
          return TodoCard(
            title: todos[i].title,
            completed: todos[i].completed,
            updateTodoCompletions: updateTodoCompletions,
            index: i,
          );
        },
        itemCount: todos.length,
      ),
    );
  }
}
