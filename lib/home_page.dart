import 'package:flutter/material.dart';
import 'package:frp_todo/provider/todo_provider.dart';
import 'package:frp_todo/widgets/FilterTextBox.dart';
import 'package:frp_todo/widgets/todo_list_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Todo App Using Hooks & RiverPod'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _headerLayout,
            _divider,
            _filterLayout(ref),
            _divider,
            _loadTodoLayout(ref),
          ],
        ),
      ),
    ));
  }

  Row get _headerLayout {
    return Row(
      children: const [
        Text('Todo List',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ],
    );
  }

  Divider get _divider {
    return const Divider(
      color: Colors.blue,
    );
  }

  Widget _loadTodoLayout(WidgetRef ref) {
    final todoData = ref.watch(TodosNotifier.todosDataProvider);
    if (TodosNotifier.dataState == loadingState.hasData) {
      return TodoList(
        todoData: todoData,
        onChange: (entity, isChecked) {
          ref.read(TodosNotifier.todosDataProvider.notifier).toggle(entity.id);
        },
      );
    } else if (TodosNotifier.dataState == loadingState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Text('Unable to Load Todo Data..');
    }
  }

  Widget _filterLayout(WidgetRef ref) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: FilterTextBox(onChange: (String text) {
            ref
                .read(TodosNotifier.todosDataProvider.notifier)
                .getFilteredData(searchText: text);
          }),
        ),
        Flexible(
            flex: 1,
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                IconButton(
                    tooltip: 'Mark All Completed',
                    onPressed: () {
                      ref
                          .read(TodosNotifier.todosDataProvider.notifier)
                          .markAllCompleted();
                    },
                    icon: const Icon(Icons.check_box)),
                IconButton(
                    onPressed: () {
                      ref
                          .read(TodosNotifier.todosDataProvider.notifier)
                          .markAllNotCompleted();
                    },
                    tooltip: 'Mark All Not Completed',
                    icon: const Icon(Icons.check_box_outline_blank)),
              ],
            ))
      ],
    );
  }
}
