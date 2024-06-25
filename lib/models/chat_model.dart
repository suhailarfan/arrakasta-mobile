class ChatMessage {
  int? id;
  int? fromId;
  int? toId;
  String? message;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  ChatMessage({
    this.id,
    this.fromId,
    this.toId,
    this.message,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    message = json['message'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_id'] = fromId;
    data['to_id'] = toId;
    data['message'] = message;
    data['read_at'] = readAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
