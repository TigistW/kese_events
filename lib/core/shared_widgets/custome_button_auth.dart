import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/core/utils/constants.dart';
import 'package:kese_events/core/utils/fonts.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_up_email_page.dart';
class CustomButtonAuth extends StatelessWidget {
  final String labelText;
  final Icon icon;
  final VoidCallback? onPressed;
  final bool enabled; // New property to enable/disable the button
  const CustomButtonAuth({
    Key? key,
    required this.labelText,
    required this.icon,
    this.onPressed,
    this.enabled = true, // Default to true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: themeColor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text(
              labelText,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: Poppins,
                fontSize: 20,
              ),
            ),
            InkWell(
              onTap: onPressed,
              child: Container(
                width: screenHeight * 0.037,
                height: screenHeight * 0.037,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeColorDarker,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        onPressed: enabled ? onPressed : null, // Enable or disable the button
      ),
    );
  }
}

// class CustomButtonAuth extends StatelessWidget {
//   final String labelText;
//   final Icon icon;
//   final VoidCallback? onPressed;
//   const CustomButtonAuth(
//       {Key? key, required this.labelText, required this.icon, this.onPressed})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Container(
//       alignment: Alignment.centerRight,
//       child: ElevatedButton(
//         // style: ElevatedButton.styleFrom(
//         //   primary: themeColor,
//         // ),
//         style: ElevatedButton.styleFrom(
//           // maximumSize: Size(10, 10),
//           backgroundColor: themeColor,
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
//           shape: RoundedRectangleBorder(
//             borderRadius:
//                 BorderRadius.circular(12.0), // Adjust the radius as needed
//           ),
//           // foregroundColor: themeColor
//           ),
//         child:  Row(
//           mainAxisSize: MainAxisSize.max, 
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children:  [
//             SizedBox(),
//             Text(
//                 labelText,
//                 style:   TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: Poppins,
//                     fontSize: 20),
//               ),  
//           InkWell(
//       onTap: onPressed,
//       child: Container(
//         width: screenHeight * 0.037, 
//         height: screenHeight * 0.037,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: themeColorDarker,
//         ),
//         child: Center(
//           child: Icon(
//             Icons.arrow_forward,
//             color: Colors.white, 
//           ),
//         ),
//       ),
//     )
//         ]
//         ),
//         onPressed: onPressed,
//       ),
//     );
//   }
// }


class CustomButtonGoogleAuth extends StatelessWidget {
  final String labelText;
  final VoidCallback? onPressed;
  const CustomButtonGoogleAuth(
      {Key? key, required this.labelText, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          // maximumSize: Size(10, 10),
          elevation: 5,
          backgroundColor: whitishBackground,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12.0), // Adjust the radius as needed
          ),
          // foregroundColor: themeColor
          ),
        child:  Row(
          mainAxisSize: MainAxisSize.max, 
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:  [
             CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 15,
                  child:SvgPicture.string(google_icon, height: screenHeight * 0.05625
                  )
                  ),
            Text(
                labelText,
                style:   TextStyle(
                    color: blackText,
                    fontWeight: FontWeight.w400,
                    fontFamily: Poppins,
                    fontSize: 18),
              ), 
              SizedBox()

        ]
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class HaveAnAccount extends StatelessWidget {
  final String labelText;
  final String labelText2;
  final VoidCallback? onPressed;
  const HaveAnAccount(
      {Key? key, required this.labelText, this.onPressed, required this.labelText2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return  Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(labelText, 
                     style: TextStyle(
                    fontFamily: Poppins,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: fontGrey),
               ),
                      TextButton(
                      child:  Text(
                        labelText2,
                        style: TextStyle(
                          fontFamily: Poppins,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: themeColor),
                      ),
                      onPressed: onPressed
                    ),
                    ]
                    ),
          )
          ;
          }
          }