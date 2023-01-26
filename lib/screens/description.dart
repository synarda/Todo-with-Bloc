import 'package:flutter/material.dart';
import 'package:todo_task/Utils/const.dart';
import 'package:todo_task/blocs/bloc/bloc_exports.dart';
import 'package:todo_task/model/todo_model.dart';
import 'package:todo_task/screens/add_alert.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage(
      {super.key,
      required this.tasksList,
      this.todoController,
      this.titleController});
  final Task tasksList;
  final todoController;
  final titleController;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tasksList.key,
      child: Scaffold(
        backgroundColor: Colorss().foregroundBlack,
        appBar: AppBar(
          backgroundColor:
              tasksList.isSelected ? Colors.grey : Colorss().primary,
          centerTitle: true,
          title: Text(tasksList.title),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: (() {
                  context.read<TasksBloc>().add(DeleteTask(tasksList.key));
                  Navigator.pop(context);
                }),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.only(
                    left: 24, right: 24, bottom: 4, top: 4),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color:
                        tasksList.isSelected ? Colors.grey : Colorss().primary),
                child: const Text(
                  "Todo",
                  style: TextStyle(color: Colors.white),
                )),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ], borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Text(tasksList.todo),
            ),
          ],
        ),
      ),
    );
  }
}
