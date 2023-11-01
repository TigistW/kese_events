
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  static const String routeName = '/checkout';
  final List<Object> response;


  const CheckoutPage({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
 // Initialize with the response data you want to display

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Checkout Successful!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Response Data:',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              widget.response[0] as String, // Display the response data here
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
