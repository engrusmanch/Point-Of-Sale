class Payment {
  String? id;
  String? paymentType;
  double? amount;
  String? transactionDetails;
  DateTime? timestamp;

  Payment({
    this.id,
    this.paymentType,
    this.amount,
    this.transactionDetails,
    this.timestamp,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      paymentType: json['payment_type'],
      amount: json['amount']?.toDouble(),
      transactionDetails: json['transaction_details'],
      timestamp: DateTime.tryParse(json['timestamp'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'payment_type': paymentType,
      'amount': amount,
      'transaction_details': transactionDetails,
      'timestamp': timestamp?.toIso8601String(),
    };
  }
}
