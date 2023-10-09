import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import Hive Flutter untuk database lokal.
import 'package:prj2/layout/home_page.dart';
import '../model/contact.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late Box<Contact> box;
  var formkey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? phone;

  @override
  void initState() {
    super.initState();
    
    // Menginisialisasi kotak Hive untuk data kontak.
    box = Hive.box('databaseContact');
    
    // Mencetak panjang kotak Hive (jumlah item di dalamnya).
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
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    name = value; // Menyimpan nilai nama saat berubah.
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    email = value; // Menyimpan nilai email saat berubah.
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    hintText: 'Enter your phone',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    phone = value; // Menyimpan nilai telepon saat berubah.
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save(); // Menyimpan semua nilai input.

                      // Membuat objek Contact dari input yang telah disimpan.
                      Contact ct = Contact(name: name!, email: email!, phone: phone!);
                      
                      // Menambahkan objek Contact ke kotak Hive.
                      box.add(ct);
                      
                      // Berpindah ke halaman utama setelah menyimpan data.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
