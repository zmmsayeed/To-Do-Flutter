import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Todo List', home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  // function called on click on add todo button
  _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() {
        _todoItems.add(task);
        // this is to add the divider -> if (index.isOdd) return Divider();
        _todoItems.add("");
      });
    }
  }

  _askDelete() {
    print("Do you want to delete this?");
    // return showDialog<void>(
    //   context: context,
    //   barrierDismissible: false, // user must tap button!
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('Delete?'),
    //       content: Text("Are you sure you want to delete this task?"),
    //       actions: [
    //         FlatButton(onPressed: null, child: Text('No')),
    //         FlatButton(onPressed: null, child: Text('Yes'))
    //       ],
    //     );
    //   },
    // );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText) {
    return ListTile(
      title: Text(todoText, style: TextStyle(fontSize: 18.0)),
      onTap: _askDelete,
      onLongPress: _askDelete,
    );
  }

  // Building the whole todo list
  Widget _buildTodoList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        if (index.isOdd) return Divider();
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        } else {
          return null;
        }
      },
    );
  }

  _pushToAddScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(title: Text('Add New Task')),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: EdgeInsets.all(16.0)),
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
          onPressed: _pushToAddScreen,
          tooltip: 'Add Task',
          child: Icon(Icons.add)),
    );
  }
}
