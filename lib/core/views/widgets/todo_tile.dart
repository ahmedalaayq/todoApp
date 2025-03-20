import 'package:flutter/material.dart';
import 'package:todo_app/core/views/models/todo_model.dart';

import '../../themes/app_colors.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.todo,
    required this.updateStatus,
    required this.removeItem,
  });

  final TodoModel todo;
  final VoidCallback updateStatus;
  final VoidCallback removeItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text(
                todo.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
              
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => updateStatus(),
                    icon: Icon(
                      todo.status ? Icons.check : Icons.close,
                      color: todo.status ? Colors.greenAccent : Colors.red,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => removeItem(),
                    icon: Icon(Icons.delete,color: Colors.redAccent,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
