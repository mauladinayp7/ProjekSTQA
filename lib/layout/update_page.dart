import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:prj2/layout/home_page.dart';

import '../model/contact.dart';

class UpdatePage extends StatefulWidget {
  UpdatePage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.index,
  });

  String name;
  String email;
  String phone;
  int index;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late Box<Contact> box;
  var formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    box = Hive.box('databaseContact');
    print("contactBox.length : ${box.values.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                controller: TextEditingController(text: widget.name),
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  widget.name = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: TextEditingController(text: widget.email),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  widget.email = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: TextEditingController(text: widget.phone),
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  hintText: 'Enter your phone',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  widget.phone = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();

                    Contact ct = Contact(
                        name: widget.name,
                        email: widget.email,
                        phone: widget.phone);
                    box.putAt(widget.index, ct);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                    setState(() {});
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
