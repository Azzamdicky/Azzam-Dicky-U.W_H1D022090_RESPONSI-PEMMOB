import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/uang_bloc.dart';
import '../model/uang.dart';
import 'uang_detail.dart';
import 'uang_form.dart';
import 'login_page.dart';

class UangPage extends StatefulWidget {
  const UangPage({Key? key}) : super(key: key);

  @override
  _UangPageState createState() => _UangPageState();
}

class _UangPageState extends State<UangPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[800],
        colorScheme: ColorScheme.dark(
          primary: Colors.blue[800]!,
          secondary: Colors.blueAccent,
        ),
        fontFamily: 'Roboto', // Menggunakan font Roboto
        scaffoldBackgroundColor: Colors.blueGrey[900],
        textTheme: const TextTheme(
          headlineSmall:
              TextStyle(color: Colors.white), // Warna teks pada AppBar
          bodyMedium: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white), // Untuk tombol
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.blueAccent),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Warna tombol
            foregroundColor: Colors.white, // Warna teks pada tombol
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('List Keuangan'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UangForm()));
                },
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Logout'),
                trailing: const Icon(Icons.logout),
                onTap: () async {
                  await LogoutBloc.logout().then((value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false)
                      });
                },
              )
            ],
          ),
        ),
        body: FutureBuilder<List>(
          future: UangBloc.getUangs(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListUang(
                    list: snapshot.data,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ListUang extends StatelessWidget {
  final List? list;

  const ListUang({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemUang(
            uang: list![i],
          );
        });
  }
}

class ItemUang extends StatelessWidget {
  final Uang uang;

  const ItemUang({Key? key, required this.uang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UangDetail(
                      uang: uang,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(uang.exchange_rate.toString()),
          subtitle: Text(uang.symbol!),
          trailing: Text(uang.currency!),
        ),
      ),
    );
  }
}
