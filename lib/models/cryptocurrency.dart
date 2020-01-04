class Cryptocurrency {
  String name;
  String symbol;
  int rank;
  double price;

  Cryptocurrency({this.name, this.symbol, this.rank, this.price});

  factory Cryptocurrency.fromJson(Map<String, dynamic> json) {
    return Cryptocurrency(
        name: json['name'],
        symbol: json['symbol'],
        rank: json['cmc_rank'],
        price: json['quote']['USD']['price']);
  }
}
