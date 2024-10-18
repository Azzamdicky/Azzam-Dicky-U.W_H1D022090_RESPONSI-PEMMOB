import 'package:flutter/material.dart';
import '../bloc/uang_bloc.dart';
import '../widget/warning_dialog.dart';
import '../model/uang.dart';
import 'uang_form.dart';
import 'uang_page.dart';

// ignore: must_be_immutable
class UangDetail extends StatefulWidget {
  Uang? uang;

  UangDetail({Key? key, this.uang}) : super(key: key);

  @override
  _UangDetailState createState() => _UangDetailState();
}

class _UangDetailState extends State<UangDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Keuangan'),
        backgroundColor: Colors.blueGrey, // Warna latar belakang AppBar
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white, // Background putih
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Currency : ${widget.uang!.currency}",
                style: const TextStyle(
                    fontSize: 20.0, color: Colors.blueGrey), // Warna teks
              ),
              const SizedBox(height: 10), // Memberikan jarak antara teks
              Text(
                "Exchange rate : ${widget.uang!.exchange_rate}",
                style: const TextStyle(
                    fontSize: 18.0, color: Colors.black87), // Warna teks
              ),
              const SizedBox(height: 10),
              Text(
                "Symbol : ${widget.uang!.symbol}",
                style: const TextStyle(
                    fontSize: 18.0, color: Colors.black87), // Warna teks
              ),
              const SizedBox(height: 20),
              _tombolHapusEdit()
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text(
            "EDIT",
            style: TextStyle(color: Colors.white),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.green, // Warna tombol Edit
            side: const BorderSide(color: Colors.green), // Border warna hijau
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UangForm(
                  uang: widget.uang!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10), // Memberikan jarak antara tombol
        // Tombol Hapus
        OutlinedButton(
          child: const Text(
            "DELETE",
            style: TextStyle(color: Colors.white),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.red, // Warna tombol Hapus
            side: const BorderSide(color: Colors.red), // Border warna merah
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text("Ya", style: TextStyle(color: Colors.white)),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.red, // Warna tombol konfirmasi hapus
            side: const BorderSide(color: Colors.red),
          ),
          onPressed: () {
            UangBloc.deleteUang(id: widget.uang!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UangPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text("Batal", style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
