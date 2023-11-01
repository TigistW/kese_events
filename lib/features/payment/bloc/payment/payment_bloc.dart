import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kese_events/core/utils/form_submission_state.dart';
import 'package:kese_events/features/event/repository/event_repository.dart';
import 'package:kese_events/features/payment/bloc/payment/payment_event.dart';
import 'package:kese_events/features/payment/bloc/payment/payment_state.dart';
import 'package:kese_events/features/payment/repository/payment_repository.dart';
import 'package:kese_events/features/profile/repository/user_hive_repository.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;
  final UserHiveRepository userHiveRepository;
  final EventRepository eventDetailRepository;

   PaymentBloc({required this.paymentRepository,
   required this.userHiveRepository,
    required this.eventDetailRepository}
  ) : super(PaymentState()){

    on<PaymentUserChanged>(
      (event, emit) {
        emit(state.copyWith(user: event.user));
      },
    ); 

    on<PaymentEventChanged>(
      (event, emit) {
        emit(state.copyWith(event: event.event));
      },
    ); 

     on<PaymentVIPStatusChanged>(
      (event, emit) {
        emit(state.copyWith(is_vip: event.isVip));
      },
    ); 

     on<PaymentCurrencyChanged>(
      (event, emit) {
        emit(state.copyWith(currency: event.currency));
      },
    ); 

    on<PaymentQuantityChanged>(
      (event, emit) {
        emit(state.copyWith(quantity: event.quantity));
      },
    ); 

    on<PaymentAttendanceMethodChanged>(
      (event, emit) {
        emit(state.copyWith(attendanceMethod: event.attendanceMethod));
      },
    );

    on<PaymentFormSubmitted>(
      (event, emit) async {
        emit(state.copyWith(formState: FormSubmitting()));
        try {
          
          final response = await paymentRepository.paymentInitiation(
            user: event.user,
            event:event.event,
            quantity:event.quantity,
            currency: event.currency,
            attendanceMethod: event.attendanceMethod,
            is_vip: event.is_vip
            );
            print(response);
            Map<String, dynamic> jsonResponse = json.decode(response);
            String checkoutUrl = jsonResponse['data']['data']['checkout_url'];
            List<Object> urlList = [checkoutUrl];
         
          emit(state.copyWith(formState: SubmissionSuccessWithData(urlList)));

          print(state.formState);
        } catch (e) {
          print(e.toString());
          emit(state.copyWith(formState: SubmissionFailed(Exception(e))));
        }
      },
    );

  }
  }

