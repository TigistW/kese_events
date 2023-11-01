import 'package:kese_events/features/payment/bloc/payment/payment_state.dart';
import 'package:kese_events/features/payment/data_provider/payment_dataprovider.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/user/user.dart';

class PaymentRepository {
  final PaymentDataProvider _paymentDataProvider;
  PaymentRepository(
    this._paymentDataProvider,
  );

  Future<String> paymentInitiation({
    required User user,
    required Event event,
    required int quantity,
    required String currency,
    required String attendanceMethod,
    required bool is_vip
  }) async {
    print("in payment repo");
    return await _paymentDataProvider.paymentInitialization(
    is_vip: is_vip,
    event: event,
    user:user,
    quantity: quantity,
    currency: currency,
    attendanceMethod: attendanceMethod
    );
  }
  }