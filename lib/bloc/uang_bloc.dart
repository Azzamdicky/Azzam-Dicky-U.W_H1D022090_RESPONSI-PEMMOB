import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '../model/uang.dart';

class UangBloc {
  static Future<List<Uang>> getUangs() async {
    String apiUrl = ApiUrl.listUang;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listUang = (jsonObj as Map<String, dynamic>)['data'];
    List<Uang> uangs = [];
    for (int i = 0; i < listUang.length; i++) {
      uangs.add(Uang.fromJson(listUang[i]));
    }
    return uangs;
  }

  static Future addUang({Uang? uang}) async {
    String apiUrl = ApiUrl.createUang;

    var body = {
      "currency": uang!.currency,
      "exchange_rate": uang.exchange_rate,
      "symbol": uang.symbol
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateUang({required Uang uang}) async {
    String apiUrl = ApiUrl.updateUang(uang.id!);
    print(apiUrl);

    var body = {
      "currency": uang.currency,
      "exchange_rate": uang.exchange_rate,
      "symbol": uang.symbol
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteUang({int? id}) async {
    String apiUrl = ApiUrl.deleteUang(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
