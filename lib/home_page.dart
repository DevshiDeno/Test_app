import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Task/task.dart';
import 'package:untitled/provider.dart';
import 'package:untitled/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> taskList = [];

  @override
  Widget build(BuildContext context) {
     taskList = Provider.of<TaskProvider>(context).taskList;
     final provider = Provider.of<TaskProvider>(context);
     return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80.0,
        title: const Text("Test App",
        style: TextStyle(
          fontSize:25 ,
          fontWeight: FontWeight.bold
        ),),
        leading:const Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.indigo), // Set the button color to indigo
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddTask()));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "New",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.black12,
        child: Consumer<TaskProvider>(
          builder: (context,taskProvider,child){
            return taskProvider.taskList.isEmpty ?
                const Center(child: Text("No added Tasks."))
           : ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  final task = taskList[index];
                  return SizedBox(
                   // height: 200,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        //height: 200,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Text(task.title,style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  IconButton(
                                      onPressed: () {
                                        provider.deleteTask(index, context);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ))
                                ],
                              ),
                              Text(task.descriptions),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      )
      );
  }
}
