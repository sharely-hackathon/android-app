class RewardModel {
  RewardModel({
    required this.customerId,
    required this.pointsBalance,
    required this.availableTasks,
  });

  final String customerId;
  final num pointsBalance;
  final List<AvailableTask> availableTasks;

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      customerId: json["customer_id"] ?? "",
      pointsBalance: json["points_balance"] ?? 0,
      availableTasks: json["available_tasks"] == null
          ? []
          : List<AvailableTask>.from(
              json["available_tasks"]!.map((x) => AvailableTask.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "points_balance": pointsBalance,
    "available_tasks": availableTasks.map((x) => x?.toJson()).toList(),
  };
}

class AvailableTask {
  AvailableTask({
    required this.id,
    required this.taskUuid,
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.pointsReward,
    required this.targetValue,
    required this.maxCompletions,
    required this.currentCompletions,
    required this.userMaxCompletions,
    required this.startDate,
    required this.endDate,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.progress,
  });

  final String id;
  final String taskUuid;
  final String title;
  final String description;
  final String type;
  final String status;
  final num pointsReward;
  final num targetValue;
  final dynamic maxCompletions;
  final num currentCompletions;
  final num userMaxCompletions;
  final DateTime? startDate;
  final dynamic endDate;
  final dynamic metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final Progress? progress;

  factory AvailableTask.fromJson(Map<String, dynamic> json) {
    return AvailableTask(
      id: json["id"] ?? "",
      taskUuid: json["task_uuid"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      type: json["type"] ?? "",
      status: json["status"] ?? "",
      pointsReward: json["points_reward"] ?? 0,
      targetValue: json["target_value"] ?? 0,
      maxCompletions: json["max_completions"],
      currentCompletions: json["current_completions"] ?? 0,
      userMaxCompletions: json["user_max_completions"] ?? 0,
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: json["end_date"],
      metadata: json["metadata"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      progress: json["progress"] == null
          ? null
          : Progress.fromJson(json["progress"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_uuid": taskUuid,
    "title": title,
    "description": description,
    "type": type,
    "status": status,
    "points_reward": pointsReward,
    "target_value": targetValue,
    "max_completions": maxCompletions,
    "current_completions": currentCompletions,
    "user_max_completions": userMaxCompletions,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate,
    "metadata": metadata,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "progress": progress?.toJson(),
  };
}

class Progress {
  Progress({
    required this.currentProgress,
    required this.targetProgress,
    required this.status,
    required this.completionPercentage,
    required this.canClaim,
  });

  final num currentProgress;
  final num targetProgress;
  final String status;
  final num completionPercentage;
  final bool canClaim;

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      currentProgress: json["current_progress"] ?? 0,
      targetProgress: json["target_progress"] ?? 0,
      status: json["status"] ?? "",
      completionPercentage: json["completion_percentage"] ?? 0,
      canClaim: json["can_claim"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "current_progress": currentProgress,
    "target_progress": targetProgress,
    "status": status,
    "completion_percentage": completionPercentage,
    "can_claim": canClaim,
  };
}
