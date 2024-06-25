class CoinModel {
  int? id;
  int? userId;
  int total;
  bool isCollected;

  CoinModel({
    this.id,
    this.userId,
    this.total = 0,
    this.isCollected = false,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'],
      userId: json['user_id'],
      total: json['total'] ?? 0,
      isCollected: json['is_collected'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'total': total,
      'is_collected': isCollected ? 1 : 0,
    };
  }
}
