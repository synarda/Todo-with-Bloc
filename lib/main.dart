import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_task/blocs/bloc/tasks_bloc.dart';
import 'package:todo_task/screens/homepage.dart';

void main() {
  // ignore: deprecated_member_use
  BlocOverrides.runZoned(() async {
    await Hive.initFlutter();

    await Hive.openBox("savedList");

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
