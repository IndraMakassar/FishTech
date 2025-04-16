import 'package:equatable/equatable.dart';

class Notifications extends Equatable{
  final String pondName;
  final String description;
  final String dateTime;
  final String status;

  Notifications({
    required this.pondName,
    required this.description,
    required this.dateTime,
    required this.status
  });

  @override
  List<Object?> get props => [pondName, description, dateTime, status];
}
