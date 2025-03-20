import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class Task {
  String id;
  String name;
  DateTime deadline;
  bool isDone;

  Task({
    required this.id,
    required this.name,
    required this.deadline,
    this.isDone = false,
  });
}

class _TodoPageState extends State<TodoPage> {
  DateTime? _selectedDateTime;
  final DateFormat _dateFormatter = DateFormat('dd-MM-yyyy HH:mm');
  final TextEditingController _nameController = TextEditingController();
  final List<Task> _tasks = [];
  final _key = GlobalKey<FormState>();
  bool _showDateError = false;

  void _showDateTimePicker() {
    DateTime tempDateTime = _selectedDateTime ?? DateTime.now();

    showCupertinoModalPopup(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                height: 270,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Set Task Date & Time",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.dateAndTime,
                        initialDateTime: tempDateTime,
                        minimumDate: DateTime.now().subtract(
                          const Duration(days: 365),
                        ),
                        maximumDate: DateTime.now().add(
                          const Duration(days: 365),
                        ),
                        onDateTimeChanged: (date) {
                          tempDateTime = date;
                          setModalState(() {});
                        },
                      ),
                    ),
                    FilledButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.blue),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),

                      child: const Text('Select'),
                      onPressed: () {
                        setState(() => _selectedDateTime = tempDateTime);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  void _addTask() {
    setState(() {
      _showDateError = _selectedDateTime == null;
    });

    if (_key.currentState!.validate() && _selectedDateTime != null) {
      setState(() {
        _tasks.add(
          Task(
            id: DateTime.now().toString(),
            name: _nameController.text,
            deadline: _selectedDateTime!,
          ),
        );
        _nameController.clear();
        _selectedDateTime = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Tugas berhasil ditambahkan!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  void _taskStatus(String taskId) {
    setState(() {
      final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
      _tasks[taskIndex].isDone = !_tasks[taskIndex].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Page", style: TextStyle(fontSize: 24)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Task Date:"),
                      Text(
                        _selectedDateTime == null
                            ? "Select a date"
                            : _dateFormatter.format(_selectedDateTime!),
                        style: TextStyle(fontSize: 16),
                      ),
                      if (_showDateError)
                        const Text(
                          'Please select a date',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                    ],
                  ),
                  IconButton(
                    onPressed: _showDateTimePicker,
                    icon: Icon(Icons.calendar_today, color: Colors.blue),
                  ),
                ],
              ),
              Form(
                key: _key,
                child: Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          label: Text("Task"),
                          hintText: "Masukkan tugas",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "task tidak boleh kosong";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    FilledButton(onPressed: _addTask, child: Text("Submit")),
                  ],
                ),
              ),
              Text(
                "List Tasks",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color:
                            task.isDone ? Colors.green[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.name,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        decoration:
                                            task.isDone
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                      ),
                                    ),
                                    Text(
                                      "Deadline: ${_dateFormatter.format(task.deadline)}",
                                      style: TextStyle(
                                        color:
                                            task.isDone
                                                ? Colors.green[800]
                                                : Colors.red,
                                      ),
                                    ),
                                    Text(
                                      task.isDone ? "Done" : "Not Done",
                                      style: TextStyle(
                                        color:
                                            task.isDone
                                                ? Colors.green
                                                : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Checkbox(
                                value: task.isDone,
                                onChanged: (value) => _taskStatus(task.id),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
