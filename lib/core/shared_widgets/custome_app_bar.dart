// import 'package:flutter/material.dart';
// import '../utils/colors.dart';

// class CustomeAppbar extends StatelessWidget{
//   final bool isVisible;
//   final onTap;
//   VoidCallback? onPressed;

//   CustomeAppbar({
//     Key? key,
//     this.onPressed,
//     required this.isVisible,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Material(
//       child: Container(
//       height: screenHeight * 0.17,
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16,
//       ),
//       // margin: EdgeInsets.only(top: screenHeight * 0.012),
//       decoration: const BoxDecoration(
//               color: headerBackground,
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(35.0),
//                   bottomRight: Radius.circular(35.0))),
//       child: GestureDetector(
//         onTap: onPressed,
//         child:
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//           children: [

//           const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("current location"),
//                       Icon(Icons.arrow_drop_down)
//                     ],
//             ),

//           const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [Text("Addis Ababa, Eth")],
//                   ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//             IconButton(
//               iconSize: 25,
//               splashRadius: 25,
//               constraints: const BoxConstraints(minWidth: 60),
//               icon: Icon(
//                 isVisible ? Icons.close : Icons.search,
//               ),
//               onPressed: onTap,
//             ),

//            Container(
//             // color: backgroundGrey,
//             width:screenWidth * 0.52,
//             height: screenHeight * 0.04,

//             decoration:const BoxDecoration(
//               color: backgroundGrey,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(35.0),
//                         bottomRight: Radius.circular(35.0),
//                         topLeft: Radius.circular(35.0),
//                         topRight: Radius.circular(35.0),
//                       )),
//            ),

//           Container(
//             height: screenHeight * 0.04,
//             width: screenWidth * 0.23,
//             decoration: const BoxDecoration(
//                       color: questionText,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(35.0),
//                         bottomRight: Radius.circular(35.0),
//                         topLeft: Radius.circular(35.0),
//                         topRight: Radius.circular(35.0),
//                       )),
//             child:const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Icon(Icons.filter),
//                 Text("Filters")
//             ],
//             ),
//           ),
//         ]
//         ),
//           ]
//       ),
//     ),
//     )
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:kese_events/core/shared_widgets/filter_button.dart';
import 'package:kese_events/core/utils/fonts.dart';
import '../utils/colors.dart';

class CustomeAppbar extends StatelessWidget {
  final bool isVisible;
  final onTap;
  VoidCallback? onPressed;

  CustomeAppbar({
    Key? key,
    this.onPressed,
    required this.isVisible,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Material(
        child: Container(
      height: screenHeight * 0.15,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      // margin: EdgeInsets.only(top: screenHeight * 0.012),
      decoration: const BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0))),
      child: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
              "Current Location",
              style: TextStyle(
                color: whitishBackground,
                fontSize: 16, 
                fontFamily: Poppins

                ),
              
              ), 
              Icon(Icons.arrow_drop_down,
              color:whitishBackground
              )],
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Addis Ababa, ETH",
              style: TextStyle(
                  color: whitishBackground,
                  fontSize: 16,
                  fontFamily: Poppins
                ),
              )
              ],
          ),
          Row(
            
              children: [
                SizedBox(width: screenWidth * 0.038),
                IconButton(
                  icon: const Icon(
                    Icons.search_outlined,
                    color: whitishBackground,
                    size: 25,
                  ),
                  onPressed: onTap,
                ),
                Container(
                  width: screenWidth * 0.46,
                  height: screenHeight * 0.04,
                  child: TextFormField(
                    textAlign : TextAlign.start,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle:
                          TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontFamily: Poppins,
                            fontSize: 17, 
                            ),
                      border: const UnderlineInputBorder(
                      borderSide:  BorderSide(
                        style:BorderStyle.solid,
                        width: 1, 
                        color: whitishBackground
                      )),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                FilterButton(onPressed:onPressed)
              ]),
        ]),
      ),
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
