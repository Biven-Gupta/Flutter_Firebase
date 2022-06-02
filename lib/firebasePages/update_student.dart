import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudent extends StatefulWidget {
  final String id;
  const UpdateStudent({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  final _formKey = GlobalKey<FormState>();
  // var name = '';
  // var email = '';
  // var password = '';
  bool? _passwordVisibility;

  CollectionReference students =
      FirebaseFirestore.instance.collection('Students');

  Future<void> updateUser(id, name, email, password) {
    return students
        .doc(id)
        .update({'name': name, 'email': email, 'password': password})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  //
  // final name = TextEditingController();
  // final email = TextEditingController();
  // final password = TextEditingController();

  clearAll() {
    // nameC.clear();
    // emailC.clear();
    // passwordC.clear();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Student"),
      ),
      body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Students')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var data = snapshot.data!.data();
              var name = data!['name'];
              var email = data['email'];
              var password = data['password'];
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      initialValue: name,
                      onChanged: (value) => name = value,
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: 'Name: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      initialValue: email,
                      onChanged: (value) => email = value,
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          labelText: 'Email: ',
                          filled: true,
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      initialValue: password,
                      onChanged: (value) => password = value,
                      autofocus: false,
                      obscureText: !_passwordVisibility!,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.lock_rounded),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisibility = !_passwordVisibility!;
                              });
                            },
                            icon: Icon(
                              _passwordVisibility!
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.blueGrey,
                            ),
                          ),
                          labelText: 'Password: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        } else if (value.length < 6) {
                          return 'Password too Short';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                updateUser(widget.id, name, email, password);
                                clearAll();
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            clearAll();
                          },
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
