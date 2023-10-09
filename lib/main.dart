import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; /// Import Hive Flutter untuk database lokal.
import 'package:prj2/layout/form_page.dart'; /// Import halaman formulir.
import 'package:prj2/layout/home_page.dart'; /// Import halaman utama.
import 'package:prj2/model/contact.dart'; /// Import model Contact.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter(); /// Inisialisasi Hive untuk Flutter.

  Hive.registerAdapter(ContactAdapter()); /// Daftarkan adapter untuk model Contact.

  await Hive.openBox<Contact>('databaseContact'); /// Buka kotak Hive untuk data kontak.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Metode Build untuk membangun pohon widget
  @override
  Widget build(BuildContext context) {
    /// Material app, mengonfirmasi tampilan keseluruhan aplikasi
    return MaterialApp(
      debugShowCheckedModeBanner: false, /// Sembunyikan banner mode debug.
      /// Judul aplikasi yang ditampilkan pada switcher tugas OS
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue, /// Tema aplikasi dengan warna utama biru.
      ),
      home: const HomePage(), /// Halaman utama aplikasi.
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++; /// Menambahkan nilai _counter saat tombol ditekan.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), /// Menampilkan judul halaman.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:', /// Teks statis.
            ),
            Text(
              '$_counter', /// Menampilkan nilai _counter.
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, /// Menjalankan _incrementCounter saat tombol ditekan.
        tooltip: 'Increment',
        child: const Icon(Icons.add), /// Menampilkan ikon tambah.
      ),
    );
  }
}
