import 'package:equatable/equatable.dart';
import 'package:kese_events/core/utils/form_submission_state.dart';
import 'package:kese_events/core/utils/validators.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/user/user.dart';

class PaymentState extends Equatable {
  final User? user;
  final Event? event;
  final bool is_vip;
  final String currency;
  final int quantity;
  final String attendanceMethod;
  final FormSubmissionState formState;
  PaymentState({
  this.user, 
  this.event, 
  this.is_vip = false, 
  this.currency = "ETB", 
  this.quantity=1 , 
  this.attendanceMethod = "INPERSON", 
  this.formState = const InitialFormStatus()});

  PaymentState copyWith({
    User? user,
    Event? event,
    bool? is_vip,
    String? currency,
    int? quantity,
    String? attendanceMethod,
    FormSubmissionState? formState,
  }) {
    return PaymentState(
      user: user ?? this.user,
      event: event ?? this.event,
      is_vip: is_vip ?? this.is_vip,
      currency: currency ?? this.currency,
      quantity: quantity ?? this.quantity,
      attendanceMethod: attendanceMethod ?? this.attendanceMethod,
      formState: formState ?? this.formState,
    );
  }

  @override
  List<Object> get props => [this.formState, this.attendanceMethod, this.currency, this.is_vip, this.quantity];
}