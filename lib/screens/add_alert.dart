import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_task/Utils/const.dart';
import 'package:todo_task/blocs/bloc/bloc_exports.dart';
import 'package:todo_task/blocs/bloc/tasks_bloc.dart';
import 'package:todo_task/model/todo_model.dart';
import 'package:todo_task/widgets/custom_textfield.dart';

Future<Future> showAddAlert(
        BuildContext context, todoController, titleController) async =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(
                  child: Text(
                "Add TODO",
                style: TextStyle(color: Colorss().primary),
              )),
              content: SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: Column(
                  children: [
                    CustomTextField(
                        label: "title",
                        limit: 50,
                        obscure: false,
                        controller: titleController),
                    CustomTextField(
                        label: "Todo",
                        limit: 50,
                        obscure: false,
                        controller: todoController),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colorss().primary,
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              child: const Text(
                                "cancel",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (titleController.text.isEmpty) {
                                  } else {
                                    final key =
                                        DateTime.now().millisecondsSinceEpoch;
                                    Task task = Task(
                                      title: titleController.text,
                                      todo: todoController.text,
                                      time: DateTime.now().toString(),
                                      key: key,
                                      isSelected: false,
                                    );

                                    context.read<TasksBloc>().add(AddTask(
                                          task: task,
                                          time: task.time,
                                          todo: task.todo,
                                          key: task.key,
                                          isSelected: task.isSelected,
                                        ));

                                    Navigator.pop(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colorss().primary,
                                    textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Add",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
