class Order {
  String orderID;
  String custName;
  String phoneNo;
  List orderStatus;
  Map<String, dynamic> items;
  dynamic orderDate;
  dynamic shippedDate;
  Map<String, dynamic> shippingAddress;
  double total;
  String chefID;
  String custID;
  String dishID;
  List<dynamic> location;

  Order({
    this.orderID,
    this.custID,
    this.custName,
    this.phoneNo,
    this.shippedDate,
    this.orderStatus,
    this.items,
    this.orderDate,
    this.shippingAddress,
    this.total,
    this.chefID,
    this.dishID,
    this.location,
  });
}
