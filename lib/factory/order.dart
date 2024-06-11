class Order {
  String assortimentName;
  String? comment;
  double count;
  DateTime dateCreated;
  DateTime? dateStarted;
  int deliveryType;
  String departmentTypeName;
  int minutesLeft;
  int number;
  int preparationRate;
  int state;
  String uid;

  Order({
    required this.assortimentName,
    this.comment,
    required this.count,
    required this.dateCreated,
    this.dateStarted,
    required this.deliveryType,
    required this.departmentTypeName,
    required this.minutesLeft,
    required this.number,
    required this.preparationRate,
    required this.state,
    required this.uid,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      assortimentName: json['AssortimentName'],
      comment: json['Comment'],
      count: json['Count'],
      dateCreated: DateTime.fromMillisecondsSinceEpoch(int.parse(json['DateCreated'].substring(6, json['DateCreated'].length - 7))),
      dateStarted: json['DateStarted'] != null ? DateTime.fromMillisecondsSinceEpoch(int.parse(json['DateStarted'].replaceAll(RegExp(r'[^0-9]'), ''))) : null,
      deliveryType: json['DeliveryType'],
      departmentTypeName: json['DepartmentTypeName'],
      minutesLeft: json['MinutesLeft'],
      number: json['Number'],
      preparationRate: json['PreparationRate'],
      state: json['State'],
      uid: json['Uid'],
    );
  }
}