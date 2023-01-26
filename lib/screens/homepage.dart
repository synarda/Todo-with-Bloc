import 'package:flutter/material.dart';
import 'package:todo_task/Utils/const.dart';
import 'package:todo_task/blocs/bloc/bloc_exports.dart';
import 'package:todo_task/screens/add_alert.dart';
import 'package:todo_task/widgets/custom_textfield.dart';
import 'package:todo_task/widgets/tasks_list.dart';

import '../model/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController todoController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<TasksBloc>().add(const GetTask(query: "", idxTab: 0));
    super.initState();
  }

  @override
  void dispose() {
    todoController.dispose();
    titleController.dispose();
    searchController.dispose();
    super.dispose();
  }

  int idxTab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Scaffold(
            backgroundColor: Colorss().foregroundBlack,
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(30),
                child: DefaultTabController(
                    length: 3,
                    child: TabBar(
                      onTap: ((value) {
                        idxTab = value;
                        context.read<TasksBloc>().add(GetTask(
                            query: searchController.text, idxTab: idxTab));
                      }),
                      indicatorColor: Colors.black,
                      isScrollable: true,
                      tabs: const [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("All",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("done",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("not  done",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white)),
                        ),
                      ],
                    )),
              ),
              backgroundColor: Colorss().primary,
              title: const Text(
                "Todo",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      style: TextStyle(color: Colorss().primary, fontSize: 12),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colorss().primary,
                        ),
                        labelText: "Search",
                        labelStyle: TextStyle(color: Colorss().primary),
                        filled: false,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colorss().primary),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colorss().primary),
                        ),
                      ),
                      cursorColor: Colorss().primary,
                      onChanged: (value) {
                        context.read<TasksBloc>().add(GetTask(
                            query: searchController.text, idxTab: idxTab));
                      },
                      controller: searchController,
                    ),
                  ),
                ),
                state.allTask.isEmpty
                    ? Center(
                        child: Container(
                            height: 50,
                            width: 100,
                            margin: const EdgeInsets.only(top: 16),
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 4, top: 4),
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
                                color: Colorss().primary),
                            child: const Center(
                              child: Text(
                                "No todo",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      )
                    : Expanded(child: TasksWidget(tasksList: state.allTask)),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Colorss().primary,
                onPressed: () {
                  showAddAlert(context, todoController, titleController);
                },
                label: Text(
                  "Add task",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        );
      },
    );
  }
}
