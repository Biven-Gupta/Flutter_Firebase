import 'package:flutter/material.dart';

import 'add_student.dart';
import 'list_student.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Flutter FireStore CRUD'),
            ElevatedButton.icon(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudent(),
                  ),
                )
              },
              label: Text('Add',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  )),
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      body: ListStudent(),
    );
  }
}
