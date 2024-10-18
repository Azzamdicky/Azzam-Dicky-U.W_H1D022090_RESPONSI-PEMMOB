class Uang {
  int? id;
  String? currency;
  int? exchange_rate;
  String? symbol;
  Uang({this.id, this.currency, this.exchange_rate, this.symbol});
  factory Uang.fromJson(Map<String, dynamic> obj) {
    return Uang(
        id: obj['id'],
        currency: obj['currency'],
        exchange_rate: obj['exchange_rate'],
        symbol: obj['symbol']);
  }
}
