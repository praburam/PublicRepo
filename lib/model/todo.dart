import 'package:uuid/uuid.dart';

class TodoEntity {
  static const _uuid = Uuid();
  final String id;
  String description;
  bool? completed;

  TodoEntity({required this.description, this.completed = false, String? id})
      : id = id ?? _uuid.v4();

  @override
  String toString() {
    bool _completed = completed ?? false;
    return 'Task "$description" is ${_completed ? '' : 'not '}completed.';
  }
}
