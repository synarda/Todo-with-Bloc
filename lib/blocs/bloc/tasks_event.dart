part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TasksEvent {
  final Task task;
  final String time;
  final String todo;
  final int key;
  final bool isSelected;

  const AddTask({
    required this.task,
    required this.time,
    required this.todo,
    required this.key,
    required this.isSelected,
  });

  @override
  List<Object> get props => [key];
}

class GetTask extends TasksEvent {
  final String query;
  final int idxTab;
  const GetTask({this.query = "", this.idxTab = 0});
  @override
  List<Object> get props => [query, idxTab];
}

class DeleteTask extends TasksEvent {
  final int keyId;
  const DeleteTask(this.keyId);
  @override
  List<Object> get props => [keyId];
}

class ToggleThemeTask extends TasksEvent {
  @override
  List<Object> get props => [];
}

class UpdateTask extends TasksEvent {
  final Task task;
  final String time;
  final String title;
  final String todo;
  final int key;
  final bool isSelected;
  const UpdateTask({
    required this.task,
    required this.title,
    required this.time,
    required this.todo,
    required this.key,
    required this.isSelected,
  });

  @override
  List<Object> get props => [
        task,
        time,
        todo,
        key,
        isSelected,
      ];
}
