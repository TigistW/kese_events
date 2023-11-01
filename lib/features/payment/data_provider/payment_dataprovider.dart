
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kese_events/features/payment/bloc/payment/payment_state.dart';
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/user/user.dart';

class PaymentDataProvider {
  final http.Client httpClient;
  PaymentDataProvider(
    this.httpClient,
    
    );

  Future<String> paymentInitialization( {
    required bool is_vip, 
    required User user,
    required Event event,
    required String currency,
    required String attendanceMethod,
    required int quantity

    
    }) async {
    print("in payment dp");
    print(user);
    final config = await DependencyInjector.getAppConfig();

    try{
      print("here");
        final response = await httpClient.post(
          Uri.parse('http://192.168.43.250:8000/transaction/payment/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "user_profile_id": user.id, 
            "event_id": event.id,
            "quantity":quantity,
            'currency':currency}),
        );  
      print(response.statusCode);
      if (response.body != null) {
        print(response.body);
      return response.body;
      } else {
        
        throw Exception('Failed to get checkout url');
      }
    }
    catch(e) {
      print(e.toString());
      return throw e.toString();
    }
  }
  }