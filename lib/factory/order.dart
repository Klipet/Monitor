class Order {
  final DateTime dateCreated;
  final DateTime? dateStarted;
  final DateTime? deliveryPlannedDate;
  final int deliveryType;
  final List<dynamic>? lines;
  final int number;
  final int state;
  final String uid;

  Order({
    required this.dateCreated,
    this.dateStarted,
    this.deliveryPlannedDate,
    required this.deliveryType,
    this.lines,
    required this.number,
    required this.state,
    required this.uid,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      dateCreated: DateTime.fromMillisecondsSinceEpoch(int.parse(json['DateCreated'].substring(6, json['DateCreated'].length - 7))),
      deliveryPlannedDate: json['DateStarted'] != null ? DateTime.fromMillisecondsSinceEpoch(int.parse(json['DateStarted'].replaceAll(RegExp(r'[^0-9]'), ''))) : null,
      deliveryType: json['DeliveryType'],
      number: json['Number'],
      state: json['State'],
      uid: json['Uid'],
    );
  }
}