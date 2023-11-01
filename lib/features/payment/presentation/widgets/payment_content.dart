
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/core/shared_widgets/custome_button_auth.dart';
import 'package:kese_events/core/shared_widgets/shared_widgets.dart';
import 'package:kese_events/features/authentication/presentation/screens/onboarding_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_up_email_page.dart';
import 'package:kese_events/features/event/presentation/screens/home_page.dart';
import 'package:kese_events/features/payment/bloc/payment/payment_bloc.dart';
import 'package:kese_events/features/payment/bloc/payment/payment_event.dart';
import 'package:kese_events/features/payment/bloc/payment/payment_state.dart';
import 'package:kese_events/features/payment/presentation/screens/Checkout_page.dart';
import 'package:kese_events/features/profile/repository/user_hive_repository.dart';
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/user/organizer.dart';
import 'package:kese_events/models/user/user.dart';
import '../../../../core/utils/utils.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class PaymentContent extends StatefulWidget {

  final Event event;
  final userHiveRepository = DependencyInjector.getUserHiveRepository()!;
  static final _formKey = GlobalKey<FormState>();

  PaymentContent({Key? key, required this.event}) : super(key: key);

  @override
  _PaymentContentState createState() => _PaymentContentState();
}

class _PaymentContentState extends State<PaymentContent> {

  // final _controller = ValueNotifier<bool>(false);
    void validate() {
    print(PaymentContent._formKey.currentState!.validate());
  }

  
Event event = Event(
                  createdDate: "createdDate",
                  updatedDate: "updatedDate",
                  id: 1,
                  name: "hhhh",
                  description: "description",
                  eventEndDate: DateTime.now(),
                  eventStartDate: DateTime.now(),
                  price: 123456,
                  thumbnail: "thumbnail",
                  organizerId: Organizer(
                    id: 1,
                     name: "name",
                     profilePicture: "profilePicture", 
                     website: "website", 
                     contactEmail: "contactEmail", 
                     description: "description"
                     ), tags: [], location: '', capacity: 12);
   
  bool is_vip = false;
  String currency = "ETB";
  String attendanceMethod = "INPERSON";
  String paymentMethod = "CHAPA";
  String phoneNumber = "";
  int quantity = 1;
  late User user;

  final quantityController = TextEditingController(text: '1');

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

    @override
  void initState() {
    super.initState();
    _initializeData();
    
    quantityController.addListener(updateTotalPrice);
  }

  double updateTotalPrice() {
    final newQuantity = int.tryParse(quantityController.text) ?? 0;
    final newTotalPrice = calculatePrice(newQuantity, event.price);
    return newTotalPrice;
    
  }

  Future<void> _initializeData() async {
    final event = await _getEvent();
    final userData = await _getUser();

    setState(() {
      this.event = event;
      this.user = userData;
    });
  }

  Future<Event> _getEvent() async {
    final event = widget.event;
    print(event.price);
    return event;
  }

  Future<User> _getUser() async {
    final user = await widget.userHiveRepository.getUser();
    return user;
  }

  void _handlePaymentFormSubmit() {
    print("in handle form submit");
    if (PaymentContent._formKey.currentState!.validate()) {
      PaymentContent._formKey.currentState!.save();
    context
        .read<PaymentBloc>()
        .add(PaymentFormSubmitted(
          user: user,
          event:event,
          quantity: quantity,
          currency: currency,
          is_vip: is_vip,
          attendanceMethod: attendanceMethod)
          );
      
    }
  }

    double calculatePrice(int quantity, double price) {
    // Your price calculation logic goes here
    // For example, you can use a simple formula:
    // double price = quantity * 10.0; // Price per unit is $10
    // You can also include logic based on the selected payment method.
    return quantity * price * 10000; // Sample price calculation
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
     List<String> paymentMethods = ['Method 1', 'Method 2', 'Method 3', 'Method 4'];

    // Create a variable to hold the selected payment method
    String selectedPaymentMethod;
    // Validators validator = Validators();

    return Container(
      // color: Colors.blue,
      child: Form(
        key: PaymentContent._formKey,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight *0.01,
            ),
            Row(
            children: [
              Expanded(
                flex: 2,
                child: Text("Payment Method"),
              ),
              Expanded(
                flex: 3,
                child: DropdownButtonFormField<String>(
                    value: paymentMethod,
                    items:const [
                      DropdownMenuItem<String>(
                        value: 'CHAPA',
                        child: Row(
                          children: [
                            Icon(Icons.payment),
                            Text('Chapa'),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'TELEBIRR',
                        child: Row(
                          children: [
                            Icon(Icons.payment),
                            Text('Tele Birr'),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        // setState(() {
                          paymentMethod = newValue;
                        // });
                      }
                    },
                     decoration: InputDecoration(
                      hintText: 'Select Payment Method',
                      labelText: 'Payment Method', // Add a label
                      border: OutlineInputBorder(), // Define the border
                      contentPadding: EdgeInsets.all(10.0), // Adjust the padding
                    ),
                ),
                  )]
            
              ),
               SizedBox(
              height: screenHeight *0.01,
            ),
            Row(
            children: [
              Expanded(
                flex: 2, // Adjust the flex value as needed to control the width ratio
                child: Text("Phone Number"),
              ),
              Expanded(
                flex: 3, // Adjust the flex value as needed to control the width ratio
                child: CustomTextField(
                  hintText: '0912345678',
                  prefixIcon: Icon(Icons.phone),
                  onChanged: (value) {
                    // setState(() {
                          phoneNumber = value;
                        // });
                  },
                ),
              ),
            ],
          ),
           SizedBox(
              height: screenHeight *0.01,
            ),
            Row(
            children: [
              Expanded(
                flex: 2, // Adjust the flex value as needed to control the width ratio
                child: Text("Quantity"),
              ),
              Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(
                      hintText: '5',
                      prefixIcon: Icon(Icons.numbers),
                      border: OutlineInputBorder(),
          
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
            ],
          ),
           SizedBox(
              height: screenHeight *0.01,
            ),
         

       
            Row(
                children: [
                  Expanded(
                    flex: 2, // Adjust the flex value as needed to control the width ratio
                    child: Text("Total Price"),
                  ),
                  Expanded(
                    flex: 3, // Adjust the flex value as needed to control the width ratio
                    child: Text(
                      "Price: \$${updateTotalPrice().toStringAsFixed(2)}",
            
                    ),
                  ),
                ],
              ),

          
          ]
      )
        )
        );

    // return BlocListener<PaymentBloc, PaymentState>(
    //   bloc: BlocProvider.of<PaymentBloc>(context),
    //   listener: (BuildContext context, state) {
    //     print(state.formState);
    //     if (state.formState is SubmissionSuccessWithData) {
    //       final res= (state.formState as SubmissionSuccessWithData).response;
    //       print(res);
    //     Navigator.pushNamed(context, CheckoutPage.routeName, arguments: res);
    //       }},
    //   child: Form(
    //       key: _formKey,
    //       child: Container(
    //         padding: EdgeInsets.only(
    //           left: screenWidth * 0.1,
    //           right: screenWidth * 0.1,
    //         ),
    //         child: Column(
    //           children: [
               
    //             BlocBuilder<PaymentBloc, PaymentState>(
    //               builder: (context, state) {
    //                 return CustomNumberField(
    //                     hintText: '5',
    //                     prefixIcon: emailIcon,
    //                     onChanged: (value) {
    //                         quantity = value as int;
    //                       }
    //                     );
    //               },
    //             ),

    //             BlocBuilder<PaymentBloc, PaymentState>(
    //               builder: (context, state) {
    //                 return DropdownButtonFormField<bool>(
    //                     value: is_vip,
    //                     items: const [
    //                       DropdownMenuItem<bool>(
    //                         value: true,
    //                         child: Text('Yes'),
    //                       ),
    //                       DropdownMenuItem<bool>(
    //                         value: false,
    //                         child: Text('No'),
    //                       ),
    //                     ],
    //                     onChanged: (bool? newValue) {
    //                       if (newValue != null) {
    //                         is_vip = newValue;
    //                       }
    //                     },
    //                   );
    //               },
    //             ),
    //             BlocBuilder<PaymentBloc, PaymentState>(
    //               builder: (context, state) {
    //             return DropdownButtonFormField<String>(
    //                 value: currency,
    //                 items:const [
    //                   DropdownMenuItem<String>(
    //                     value: 'ETB',
    //                     child: Text('ETB'),
    //                   ),
    //                   DropdownMenuItem<String>(
    //                     value: 'USD',
    //                     child: Text('USD'),
    //                   ),
    //                 ],
    //                 onChanged: (String? newValue) {
    //                   if (newValue != null) {
    //                     // setState(() {
    //                       currency = newValue;
    //                     // });
    //                   }
    //                 },
    //               );
    //               }
    //             ),

    //             BlocBuilder<PaymentBloc, PaymentState>(
    //               builder: (context, state) {
    //               return DropdownButtonFormField<String>(
    //                 value: attendanceMethod,
    //                 items: const[
    //                   DropdownMenuItem<String>(
    //                     value: "ONLINE",
    //                     child: Text('Online'),
    //                   ),
    //                   DropdownMenuItem<String>(
    //                     value: "INPERSON",
    //                     child: Text('In-Person'),
    //                   ),
    //                 ],
    //                 onChanged: (String? newValue) {
    //                   if (newValue != null) {
    //                     // setState(() {
    //                       attendanceMethod = newValue;
    //                     // });
    //                   }
    //                 },
    //               );
    //               }),


    //           FutureBuilder<User>(
    //             future: _getUser(),
    //             builder: (context, snapshot) {
    //               if (snapshot.connectionState == ConnectionState.done) {
    //                 user = snapshot.data!;
    //                 return Text(user.firstName as String);
    //               } else {
    //                 return Center(child: CircularProgressIndicator());
    //               }
    //             },
    //           ),

    //           FutureBuilder<Event>(
    //             future: _getEvent(),
    //             builder: (context, snapshot) {
    //               if (snapshot.connectionState == ConnectionState.done) {
    //                 event = snapshot.data!;
    //                 return Text(event.name as String);
    //               } else {
    //                 return Center(child: CircularProgressIndicator());
    //               }
    //             },
    //           ),
            
    //           BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
    //               return state.formState is SubmissionFailed
    //                   ? Container(
    //                       padding: const EdgeInsets.all(20),
    //                       child: const Text(
    //                         'Submission failed, please try again.',
    //                         style: TextStyle(
    //                             color: choiceMarkerWrong, fontFamily: 'Roboto'),
    //                       ),
    //                     )
    //                   : Container();
    //             }),

    //             SizedBox(
    //               height: screenHeight * 0.03,
    //             ),
    //           BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
    //               return state.formState is FormSubmitting
    //                   ? const CircularProgressIndicator()
    //                   : CustomButtonAuth(
    //                     labelText: 'Buy',
    //                     icon: Icon(Icons.arrow_forward, color: blackText,),
    //                     onPressed: _handlePaymentFormSubmit,);
    //             }),
    //             SizedBox(
    //               height: screenHeight * 0.027,
    //             ),
               
    //           ],
    //         ),
    //       )
    //   ),
    // );
  }
}
