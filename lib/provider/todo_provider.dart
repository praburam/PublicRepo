import 'package:flutter/cupertino.dart';
import 'package:frp_todo/model/todo.dart';
import 'package:frp_todo/model/todo_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum loadingState { isLoading, hasError, hasData }

class TodosNotifier extends StateNotifier<List<TodoEntity>> {
  static loadingState dataState = loadingState.isLoading;
  List<TodoEntity> _initialData = [];

  static final todosDataProvider =
      StateNotifierProvider<TodosNotifier, List<TodoEntity>>((ref) {
    return TodosNotifier();
  });

  TodosNotifier({List<TodoEntity> initialTodos = const []})
      : super(initialTodos) {
    fetchData();
  }

  fetchData() async {
    try {
      dataState = loadingState.isLoading;
      _initialData = await TodoData.loadTodoData();
      state = [..._initialData];
      dataState = loadingState.hasData;
    } on Exception catch (e, s) {
      dataState = loadingState.hasError;
      debugPrintStack(label: 'Error on API Fetch - $e', stackTrace: s);
    }
  }

  // reFetchData() => fetchData();

  addAll(List<TodoEntity> todoEntityList) {
    state = [...todoEntityList];
  }

  add({required String description, String? id, bool? completed}) {
    state = [
      ...state,
      TodoEntity(description: description, id: id, completed: completed)
    ];
  }

  toggle(String id) {
    state = state.map((TodoEntity e) {
      if (e.id == id) {
        e.completed = !(e.completed ?? false);
      }
      return e;
    }).toList();
  }

  edit({required String id, required String description}) {
    state = state.map((TodoEntity e) {
      if (e.id == id) {
        e.completed = !(e.completed ?? false);
        e.description = description;
      }
      return e;
    }).toList();
  }

  remove(String id) {
    state = state.where((element) => element.id != id).toList();
  }

  markAllCompleted() {
    return _markAllStatusAs(true);
  }

  markAllNotCompleted() {
    return _markAllStatusAs(false);
  }

  _markAllStatusAs(bool status) {
    state = state.map((TodoEntity e) {
      e.completed = status;
      return e;
    }).toList();
  }

  getFilteredData({required String searchText, ignoreCase = true}) {
    state = (searchText.trim().isEmpty)
        ? _initialData
        : _initialData
            .where((element) => element.description.contains(searchText))
            .toList();
  }
}
