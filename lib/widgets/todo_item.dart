import 'package:flutter/material.dart';
import '../models/todo.dart';

class ToDoItem extends StatefulWidget {
  final ToDo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onToDoChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onDeleteItem;
  // ignore: prefer_typing_uninitialized_variables
  final onUpDateItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
    required this.onUpDateItem
  }) : super(key: key);


  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  final _todoTextController =  TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          widget.onToDoChanged(widget.todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal:20 ,
            vertical: 5,
        ),
        tileColor: Colors.white,
        leading: Icon(
          widget.todo.isDone ? Icons.check_box:Icons.check_box_outline_blank ,
          color: Colors.blue,
        ),
        title: Text(
           widget.todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration:widget.todo.isDone? TextDecoration.lineThrough: null,
          ),
        ),
        trailing: Row(
        mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              height:35 ,
              width:35 ,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child:
              IconButton(
                color:Colors.white,
                iconSize: 15,
                icon: const Icon(Icons.edit),
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context)=> SimpleDialog(
                        children: [
                          TextField(
                            controller: TextEditingController(text: widget.todo.todoText),
                            onChanged: (value){
                                _todoTextController.text = value;
                            },


                          ),
                         ElevatedButton(
                             onPressed: () {
                               _todoTextController.text == '' ? const Text(
                                   'Can not post an empty content'
                               ):
                               widget.onUpDateItem(widget.todo.todoText,_todoTextController.text);
                               Navigator.pop(context);
                             },
                           child: const Text('UpDate'),
                             ),
                        ],
                      ),

                  );

                },

              ),
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin:const EdgeInsets.symmetric(vertical: 10),
              height:35 ,
              width:35 ,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child:
              IconButton(
                color:Colors.white,
                iconSize: 15,
                icon: const Icon(Icons.delete),
                onPressed: (){
                  widget.onDeleteItem(widget.todo.id);
                },

              ),
            ),
          ],
        ),

      ),
    );

  }
}
