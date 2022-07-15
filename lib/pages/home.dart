import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String userToDO = '';
  List todoList = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    todoList.addAll(['By milk','Wash dishes','Купить ноутбук']);
  }

  void _menuOpen () {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('Меню'),),
          body: Row(
            children: [
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              }, child: Text('На главную')),
              Padding(padding: EdgeInsets.only(left: 15)),
              Text('Наше простое меню')
            ],
          )
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu_outlined),
            onPressed: _menuOpen,
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(todoList[index]),
                child:Card(
                  child: ListTile(
                      title: Text(todoList[index]),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_sweep,
                        color: Colors.deepOrangeAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          todoList.removeAt(index);
                        });
                      },
                    ),
                  ),
                ),
              onDismissed: (direction) {
                  setState(() {
                    todoList.removeAt(index);
                  });
              },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Добавить дел'),
              content: TextField(
                onChanged: (String value) {
                  userToDO = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: () {
                  setState(() {
                    todoList.add(userToDO);
                  });

                  Navigator.of(context).pop();
                },child: Text('Добавить'))
              ],
            );
          });
        },
        child: Icon(
            Icons.add_box,
            color:Colors.white
        )
      ),
    );
  }
}
