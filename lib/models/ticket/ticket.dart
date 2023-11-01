import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/user/user.dart';

enum eventAttendanceType{
   inPerson,
   liveStream;
}

class Ticket{
  final String id;
  final User userId;
  final Event eventId;
  final eventAttendanceType attendanceType;
  final bool priceFree;
  final int quantity;

  Ticket({
    required this.id,
    required this.eventId,
    required this.attendanceType,
    required this.priceFree,
    required this.quantity,
    required this.userId
  });

  factory Ticket.fromMap(Map<String, dynamic> map){
    return Ticket (
      id: map['id'] ?? '',
      userId: map['userId'],
      eventId: map['eventId'],
      attendanceType: map['attendanceType'],
      priceFree: map['price_free'] as bool,
      quantity: map['quantity'] as int,
    );
  }
}