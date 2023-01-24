import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_task/features/task_management/params/add_task_param.dart';
import 'package:innoscripta_task/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:innoscripta_task/features/task_management/presentation/widgets/app_button.dart';
import 'package:innoscripta_task/features/task_management/presentation/widgets/app_textfield.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({
    super.key,
    required this.onSave,
  });
  final VoidCallback onSave;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: const Text(
          'Add Task',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          AppButton(
            text: 'Save',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<TaskBloc>().add(
                      AddTaskEvent(
                        param: AddTaskParam(
                          title: _titleController.text,
                          description: _descriptionController.text,
                        ),
                      ),
                    );
                Navigator.pop(context);
              }
            },
          ),
        ],
        backgroundColor: const Color(0xffFFFFFF),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              controller: _titleController,
              hintText: 'Task Title',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: _descriptionController,
              hintText: 'Description',
              maxLines: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
