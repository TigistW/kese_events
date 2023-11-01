import 'package:kese_events/features/payment/bloc/payment/payment_state.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/user/user.dart';

abstract class PaymentEvent {}

class PaymentUserChanged extends PaymentEvent {
  final User? user;

  PaymentUserChanged({required this.user});
}

class PaymentEventChanged extends PaymentEvent {
  final Event? event;

  PaymentEventChanged({required this.event});
}

class PaymentVIPStatusChanged extends PaymentEvent {
  final bool isVip;

  PaymentVIPStatusChanged({required this.isVip});
}

class PaymentCurrencyChanged extends PaymentEvent {
  final String currency;

  PaymentCurrencyChanged({required this.currency});
}

class PaymentQuantityChanged extends PaymentEvent {
  final int quantity;

  PaymentQuantityChanged({required this.quantity});
}

class PaymentAttendanceMethodChanged extends PaymentEvent {
  final String attendanceMethod;

  PaymentAttendanceMethodChanged({required this.attendanceMethod});
}

class PaymentFormSubmitted extends PaymentEvent {
  final User user;
  final Event event;
  final bool is_vip;
  final String currency;
  final int quantity;
  final String attendanceMethod;

  PaymentFormSubmitted(
    {
    required this.user, 
    required this.event, 
    required this.is_vip, 
    required this.currency, 
    required this.quantity, 
    required this.attendanceMethod,});
}
