// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:todo_app/core/helper/show_snackbar.dart';
import 'package:todo_app/core/views/models/todo_model.dart';
import 'package:todo_app/core/views/widgets/todo_tile.dart';
import '../themes/app_colors.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final List<TodoModel> allTasks = [];
  // List.generate(10, (index) {
  //   return TodoModel(title: 'Task $index', status: index % 2 == 0);
  // });

  void addTask() {
    if (textEditingController.text.isNotEmpty) {
      setState(() {
        allTasks
            .add(TodoModel(title: textEditingController.text, status: false));
        showCustomSnackBar(
            context: context, text: 'task was added successfully');
        textEditingController.clear();
      });
    }
  }

  void updateStatus(int itemIndex) {
    setState(() => allTasks[itemIndex].status = !allTasks[itemIndex].status);
  }

  void deleteAllTasks() {
    if (allTasks.isEmpty) {
      showCustomSnackBar(
          context: context,
          text: 'no task to delete',
          color: Colors.deepPurpleAccent);
    } else {
      setState(() {
        showCustomSnackBar(
            context: context,
            text: 'all task was deleted successfully',
            color: Colors.green);
        allTasks.clear();
      });
    }
  }

  void deleteItem(int itemIndex) {
    setState(() => allTasks.removeAt(itemIndex));
  }

  int calculateCompletedTask() => allTasks.where((task) => task.status).length;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskDialog(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, size: 25),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: deleteAllTasks,
            icon: const Icon(Icons.delete_forever,
                size: 32, color: Colors.redAccent),
          ),
        ],
        backgroundColor: AppColors.primaryColor,
        title: const Text('TO DO APP',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: const Color.fromARGB(179, 37, 53, 94).withOpacity(0.4),
          alignment: Alignment.center,
          child: Text(
            '${calculateCompletedTask()}/${allTasks.length}',
            style: TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.bold,
              color: (calculateCompletedTask() == allTasks.length &&
                      allTasks.isNotEmpty)
                  ? Colors.greenAccent
                  : AppColors.secondaryColor.withOpacity(0.4),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: allTasks.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) => TodoTile(
              todo: allTasks[index],
              updateStatus: () => updateStatus(index),
              removeItem: () => deleteItem(index),
            ),
          ),
        ),
      ]),
    );
  }

  void showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  autovalidateMode: autovalidateMode,
                  key: formKey,
                  child: TextFormField(
                    maxLength: 150,
                    maxLines: 3,
                    validator: (value) =>
                        (value?.isEmpty ?? true) ? 'Field is required' : null,
                    controller: textEditingController,
                    cursorColor: AppColors.secondaryColor.withOpacity(0.5),
                    decoration: InputDecoration(
                      errorBorder: textFieldBorder(color: Colors.red),
                      focusedErrorBorder:
                          textFieldBorder(color: Colors.red, width: 1.5),
                      labelText: 'Type your task',
                      enabledBorder: textFieldBorder(),
                      focusedBorder: textFieldBorder(),
                      labelStyle: TextStyle(
                        color: AppColors.secondaryColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    minimumSize: const Size(80, 40),
                    backgroundColor: Colors.deepPurple.withOpacity(0.5),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      addTask();
                    } else {
                      setState(
                          () => autovalidateMode = AutovalidateMode.always);
                    }
                  },
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

OutlineInputBorder textFieldBorder({double? width, Color? color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(
      color: color ?? AppColors.secondaryColor,
      width: width ?? 2.0,
    ),
  );
}
