import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

   String _selectedDate = "Select a date";
   final TextEditingController _nameController = TextEditingController();



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
              ),
              Form(
                child: Row( children: [
              Expanded(
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    label: Text("First Name"),
                    hintText: "Enter your first name"
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "task tidak boleh kosong";
                    }
                    return null;
                  } ,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                ),
                FilledButton(onPressed: (){
                }, child: Text("Submit"))
                ]
                ,)
              ),
            ]
          ),)),
    );
  }
}