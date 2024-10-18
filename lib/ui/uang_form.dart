import 'package:flutter/material.dart';
import '../bloc/uang_bloc.dart';
import '../widget/warning_dialog.dart';
import '../model/uang.dart';
import 'uang_page.dart';

// ignore: must_be_immutable
class UangForm extends StatefulWidget {
  Uang? uang;
  UangForm({Key? key, this.uang}) : super(key: key);
  @override
  _UangFormState createState() => _UangFormState();
}

class _UangFormState extends State<UangForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH UANG";
  String tombolSubmit = "SIMPAN";
  final _currencyUangTextboxController = TextEditingController();
  final _exchangerateUangTextboxController = TextEditingController();
  final _symbolUangTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.uang != null) {
      setState(() {
        judul = "UBAH UANG";
        tombolSubmit = "UBAH";
        _currencyUangTextboxController.text = widget.uang!.currency!;
        _exchangerateUangTextboxController.text =
            widget.uang!.exchange_rate.toString();
        _symbolUangTextboxController.text = widget.uang!.symbol!;
      });
    } else {
      judul = "TAMBAH UANG";
      tombolSubmit = "SIMPAN";
    }
  }

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
        scaffoldBackgroundColor: Colors.blueGrey[900],
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headlineSmall: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
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
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(judul),
          backgroundColor: Colors.blue[800],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _currencyUangTextField(),
                  _exchangerateUangTextField(),
                  _symbolUangTextField(),
                  _buttonSubmit()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _currencyUangTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Currency Uang",
      ),
      keyboardType: TextInputType.text,
      controller: _currencyUangTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Currency uang harus diisi";
        }
        return null;
      },
    );
  }

  Widget _exchangerateUangTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Exchange Rate",
      ),
      keyboardType: TextInputType.text,
      controller: _exchangerateUangTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Exchange rate harus diisi";
        }
        return null;
      },
    );
  }

  Widget _symbolUangTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Symbol Uang",
      ),
      keyboardType: TextInputType.text,
      controller: _symbolUangTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Symbol uang harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.blueAccent),
      ),
      child:
          Text(tombolSubmit, style: const TextStyle(color: Colors.blueAccent)),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.uang != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Uang createUang = Uang(id: null);
    createUang.currency = _currencyUangTextboxController.text;
    createUang.exchange_rate =int.parse(_exchangerateUangTextboxController.text);
    createUang.symbol = _symbolUangTextboxController.text;
    UangBloc.addUang(uang: createUang).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const UangPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Uang updateUang = Uang(id: widget.uang!.id!);
    updateUang.currency = _currencyUangTextboxController.text;
    updateUang.exchange_rate =
        int.parse(_exchangerateUangTextboxController.text);
    updateUang.symbol = _symbolUangTextboxController.text;
    UangBloc.updateUang(uang: updateUang).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const UangPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
