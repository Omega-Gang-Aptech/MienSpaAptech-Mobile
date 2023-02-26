class ItemPaypal {
  ItemPaypal({
    required this.name,
    required this.quantity,
    required this.price,
    this.currency = "USD",
  });

  String name;
  String quantity;
  String price;
  String currency;
}
