class AggregatedTrade {
  int tradeId;
  double price;
  double qty;
  int firstTradeId;
  int lastTradeId;
  int timestamp;
  bool isBuyerMaker;

  AggregatedTrade.fromMap(Map m)
      : tradeId = m['a'],
        price = double.parse(m['p']),
        qty = double.parse(m['q']),
        firstTradeId = m['f'],
        lastTradeId = m['l'],
        timestamp = m['T'],
        isBuyerMaker = m['m'];
}

class OrderbookOrder {
  double price;
  double qty;

  OrderbookOrder.fromList(List l)
      : price = double.parse(l[0]),
        qty = double.parse(l[1]);
}
