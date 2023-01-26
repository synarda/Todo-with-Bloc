// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState({this.allTask = const <Task>[]});
  final List<Task> allTask;
  @override
  List<Object> get props => [...allTask, allTask.length];
}
