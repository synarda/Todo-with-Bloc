import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_task/Utils/const.dart';
import 'package:todo_task/blocs/bloc/bloc_exports.dart';
import 'package:todo_task/model/todo_model.dart';
import 'package:todo_task/screens/description.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  final List<Task> tasksList;
  void update(BuildContext context, task, title, todo, time, keyy, isSelected) {
    context.read<TasksBloc>().add(UpdateTask(
        task: task,
        title: title,
        time: time,
        todo: todo,
        key: keyy,
        isSelected: isSelected));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: tasksList.length,
        itemBuilder: (context, index) {
          tasksList.sort((a, b) => b.key - a.key);
          final task = tasksList[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DescriptionPage(tasksList: task)));
            },
            child: Hero(
              tag: task.key,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                height: 100,
                width: double.infinity,
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
                    color: task.isSelected ? Colors.grey : Colorss().primary),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 350),
                          opacity: task.isSelected ? 1 : 0,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 100,
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Center(
                                  child: SizedBox(
                                height: 100,
                                child: Stack(
                                  children: [
                                    const Center(child: Text("done")),
                                    Center(
                                        child: Lottie.asset(
                                            "assets/doneLottie.json")),
                                  ],
                                ),
                              )),
                            ),
                          ),
                        ),
                        Center(
                          child: ListTile(
                              title: Text(
                                task.title,
                                style: TextStyle(
                                    color: task.isSelected
                                        ? Colors.grey
                                        : Colors.white,
                                    fontSize: 20),
                              ),
                              subtitle: Text(
                                task.time.substring(0, 10),
                                style: TextStyle(
                                    color: task.isSelected
                                        ? Colors.grey
                                        : Colors.white,
                                    fontSize: 12),
                              ),
                              trailing: Checkbox(
                                  side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                        width: 1.0, color: Colors.white),
                                  ),
                                  activeColor: Colorss().primary,
                                  value: task.isSelected,
                                  onChanged: (value) {
                                    update(context, task, task.title, task.todo,
                                        task.time, task.key, value);
                                  })),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
