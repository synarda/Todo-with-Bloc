import 'dart:convert';

import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String todo;

  final String time;
  final int key;
  final bool isSelected;

  const Task({
    required this.title,
    required this.todo,
    required this.time,
    required this.key,
    required this.isSelected,
  });

  @override
  List<Object?> get props => [title, todo, time, key, isSelected];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      "todo": todo,
      'time': time,
      'key': key,
      "isSelected": isSelected,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      todo: map['todo'] as String,
      time: map['time'] as String,
      key: map["key"] as int,
      isSelected: map["isSelected"] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  Task copyWith({
    String? title,
    String? todo,
    String? time,
    int? key,
    bool? isSelected,
  }) {
    return Task(
      title: title ?? this.title,
      todo: todo ?? this.todo,
      time: time ?? this.time,
      key: key ?? this.key,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
