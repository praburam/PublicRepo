import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frp_todo/model/todo.dart';

class TodoList extends HookWidget {
  const TodoList({
    Key? key,
    required this.todoData,
    required this.onChange,
  }) : super(key: key);

  final List<TodoEntity> todoData;
  final void Function(TodoEntity, bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: todoData.length,
        itemBuilder: (BuildContext context, int index) {
          final isCompleted = todoData[index].completed ?? false;
          return Padding(
              padding: const EdgeInsets.only(bottom: 1.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: index % 2 != 0
                        ? Colors.blue.shade100
                        : Colors.blue.shade200),
                child: CheckboxListTile(
                  value: isCompleted,
                  title: Text(todoData[index].description),
                  subtitle: isCompleted ? const Text('Task Completed') : null,
                  onChanged: (bool? value) {
                    onChange(todoData[index], value ?? false);
                  },
                ),

                // title: Text(todoData[index].description),
              )
              // ListTile(
              //   title: Text(todoData[index].description),
              //   trailing:
              //   Text(
              //       (todoData[index].completed ?? false) ? 'Done' : 'Not Done'),
              // ),
              // ),
              );
        },
      ),
    );
  }
}
