class PointsHistoryModel {
  PointsHistoryModel({
    required this.customerId,
    required this.pointsBalance,
    required this.transactions,
    required this.count,
    required this.offset,
    required this.limit,
  });

  final String customerId;
  final num pointsBalance;
  final List<Transaction> transactions;
  final num count;
  final num offset;
  final num limit;

  factory PointsHistoryModel.fromJson(Map<String, dynamic> json) {
    return PointsHistoryModel(
      customerId: json["customer_id"] ?? "",
      pointsBalance: json["points_balance"] ?? 0,
      transactions: json["transactions"] == null
          ? []
          : List<Transaction>.from(
              json["transactions"]!.map((x) => Transaction.fromJson(x)),
            ),
      count: json["count"] ?? 0,
      offset: json["offset"] ?? 0,
      limit: json["limit"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "points_balance": pointsBalance,
    "transactions": transactions.map((x) => x?.toJson()).toList(),
    "count": count,
    "offset": offset,
    "limit": limit,
  };
}

class Transaction {
  Transaction({
    required this.id,
    required this.customerId,
    required this.points,
    required this.type,
    required this.source,
    required this.sourceId,
    required this.description,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final String id;
  final String customerId;
  final num points;
  final String type;
  final String source;
  final dynamic sourceId;
  final String description;
  final Metadata? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json["id"] ?? "",
      customerId: json["customer_id"] ?? "",
      points: json["points"] ?? 0,
      type: json["type"] ?? "",
      source: json["source"] ?? "",
      sourceId: json["source_id"],
      description: json["description"] ?? "",
      metadata: json["metadata"] == null
          ? null
          : Metadata.fromJson(json["metadata"]),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "points": points,
    "type": type,
    "source": source,
    "source_id": sourceId,
    "description": description,
    "metadata": metadata?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Metadata {
  Metadata({required this.adjustedBy, required this.adjustmentType});

  final String adjustedBy;
  final String adjustmentType;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      adjustedBy: json["adjusted_by"] ?? "",
      adjustmentType: json["adjustment_type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "adjusted_by": adjustedBy,
    "adjustment_type": adjustmentType,
  };
}
