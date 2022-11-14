import 'package:frp_todo/model/todo.dart';
import 'package:uuid/uuid.dart';

class TodoData {
  static final _uuid = Uuid();
  static final List<TodoEntity> _todoData = [
    TodoEntity(description: '${_uuid.v4().split('-')[0]} - Item 1'),
    TodoEntity(description: '${_uuid.v4().split('-')[0]} - Item 2'),
    TodoEntity(description: '${_uuid.v4().split('-')[0]} - Item 3'),
    TodoEntity(description: '${_uuid.v4().split('-')[0]} - Item 4'),
    TodoEntity(description: '${_uuid.v4().split('-')[0]} - Item 5'),
    TodoEntity(description: '${_uuid.v4().split('-')[0]} - Item 6'),
    TodoEntity(description: '${_uuid.v4().split('-')[0]} - Item 7'),
    TodoEntity(description: '${_uuid.v4().split('-')[0]} - Item 8'),
  ];

  static Future<List<TodoEntity>> loadTodoData() {
    return Future.delayed(const Duration(seconds: 1), () => _todoData);
  }
}
