class Report {
  String? id;
  String? reportType;
  DateTime? dateRangeStart;
  DateTime? dateRangeEnd;
  Map<String, dynamic>? salesData;
  Map<String, dynamic>? inventoryMetrics;

  Report({
    this.id,
    this.reportType,
    this.dateRangeStart,
    this.dateRangeEnd,
    this.salesData,
    this.inventoryMetrics,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      reportType: json['report_type'],
      dateRangeStart: DateTime.tryParse(json['date_range_start'] ?? ''),
      dateRangeEnd: DateTime.tryParse(json['date_range_end'] ?? ''),
      salesData: json['sales_data'],
      inventoryMetrics: json['inventory_metrics'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'report_type': reportType,
      'date_range_start': dateRangeStart?.toIso8601String(),
      'date_range_end': dateRangeEnd?.toIso8601String(),
      'sales_data': salesData,
      'inventory_metrics': inventoryMetrics,
    };
  }
}
