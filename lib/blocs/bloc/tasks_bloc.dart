// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_task/model/todo_model.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<GetTask>(_onGetTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final savedList = Hive.box("savedList");

    savedList.put(event.task.key.toString(), event.task.toJson());
    emit(TasksState(
      allTask: List.from(state.allTask)..add(event.task),
    ));
  }

  void _onGetTask(GetTask event, Emitter<TasksState> emit) {
    final savedList = Hive.box("savedList");

    final tasks = <Task>[];

    for (final taskStr in savedList.values) {
      final task = Task.fromJson(taskStr);
      if (task.title
          .toLowerCase()
          .trim()
          .contains(event.query.toLowerCase().trim())) {
        if (event.idxTab == 0) {
          tasks.add(task);
        } else if (event.idxTab == 1 && task.isSelected) {
          tasks.add(task);
        } else if (event.idxTab == 2 && !task.isSelected) {
          tasks.add(task);
        }
      }
    }
    tasks.sort((a, b) => b.key - a.key);
    emit(TasksState(
      allTask: tasks,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final savedList = Hive.box("savedList");
    savedList.delete(event.keyId.toString());
    emit(TasksState(
      allTask: List.from(state.allTask)
        ..removeWhere((element) => element.key == event.keyId),
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    final savedList = Hive.box("savedList");
    final idx = state.allTask.indexOf(task);

    List<Task> allTasks = List.from(state.allTask);
    allTasks[idx] = task.copyWith(
      isSelected: !task.isSelected,
    );

    savedList.put(task.key.toString(), allTasks[idx].toJson());
    emit(TasksState(allTask: allTasks));
  }
}
