import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

   String _selectedDate = "Select a date";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Page", style: TextStyle(fontSize: 24),), centerTitle: true,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Task Date:")
                  , Text(_selectedDate)],),
                  IconButton(onPressed: (){}, icon: Icon(Icons.calendar_today, color: Colors.blue,) )
                ],
              )
            ]
          ),)),
    );
  }
}