import 'package:equatable/equatable.dart';

class NotifModel extends Equatable{
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final String status;

  const NotifModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.status
  });

  @override
  List<Object?> get props => [title, body, createdAt, status];

  factory NotifModel.fromJson(Map<String, dynamic> data) {
  return NotifModel(
    id: data["id"]?.toString() ?? '', // Convert to string and provide default
    title: data["title"]?.toString() ?? 'No Title',
    body: data["body"]?.toString() ?? 'No Content',
    createdAt: data["created_at"] != null
      ? DateTime.parse(data["created_at"].toString())
      : DateTime.now(),
    status: data["status"]?.toString() ?? 'unread'
  );
}

  Map<String, dynamic> toJson(){
    return{
      "title" : title,
      "body" : body,
      "status": status,
    };
  }
}