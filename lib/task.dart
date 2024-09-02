import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Task/task.dart';
import 'package:untitled/home_page.dart';
import 'package:untitled/provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          "Add Item",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey, // Associate the form with the key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "*",
                      style: TextStyle(color: _taskController.text.isEmpty? Colors.red:Colors.black12),
                    ),
                    const SizedBox(width: 10),
                    const Text("Indicates required fields"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text("Item title"),
                    const SizedBox(width: 10),
                    Text(
                      "*",
                      style: TextStyle(color: _taskController.text.isEmpty ? Colors.red:Colors.black12),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: _taskController,
                decoration: const InputDecoration(
                  hintText: "Enter a title for the item",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title for the item';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text("Description"),
                  ],
                ),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: "Add description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ),
                ),
                minLines: 6,
                // Set the minimum height (in lines)
                maxLines: null,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel",
                    style: TextStyle(color: Colors.blue),),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.indigo), // Set the button color to indigo
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var task = Task(
                          title: _taskController.text,
                          descriptions: _descriptionController.text,
                        );
                        provider.addTask(task,context); // Add the task using the provider
                        Navigator.pop(context); // Navigate back to the previous screen
                      }
                    },
                    child: const Text(
                      "Add Item",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
