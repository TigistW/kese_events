import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/features/event/presentation/screens/event_detail_page.dart';
import 'package:kese_events/models/event/event.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event data;
  const EventCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(context, EventDetailPage.routeName,
            arguments: data)
      },
      child: Card(
        color: Color.fromARGB(255, 255, 255, 255),
        margin: EdgeInsets.fromLTRB(15,10,0,15),
        elevation:5,
        shadowColor: Color.fromARGB(255, 235, 235, 235),
        child: Container(
            margin: EdgeInsets.fromLTRB(6, 6, 6, 6),
            width: screenWidth * 0.65,
            decoration: BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                      decoration: const BoxDecoration(
                      // color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 3),
                      child: Card(
                          shadowColor: whitishBackground,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          // elevation: 5,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)), // if you need this
                          ),
                          child: 
                               
                            CachedNetworkImage(
                              width: screenWidth * 0.65,
                              height: screenHeight * 0.2,
                              imageUrl: data.thumbnail,
                              errorWidget: (context, url, error) =>
                                  Image.asset(data.thumbnail),
                                  // SvgPicture.string(logo),
                              fit: BoxFit.cover,
                            ),
                                  
                      )
                      ),
                              Align(
                                // heightFactor: screenHeight * 0.05,
                                // widthFactor: screenWidth * 0.05,
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                  decoration: BoxDecoration(
                                    color: whitishBackground.withOpacity(0.7),
                                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                                  ),
                                  height: screenHeight * 0.07,
                                  width: screenHeight * 0.07,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                      Text("${data.eventStartDate.day}",
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight:FontWeight.w900,
                                        color: themeColor
                                      ),),
                                      Text("${DateFormat.MMM().format(data.eventStartDate)}",
                                      style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: themeColor),
                        )
                                     ],
                                  ),
                                  ),
                                  )
                ]),
                      
                      Container(
                          padding: EdgeInsets.fromLTRB(15, 10, 6, 10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            // color: Colors.red
                            ),
                          // width: screenWidth / 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    data.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: blackText,
                                      fontSize: screenWidth * 0.08,
                                      fontFamily: Poppins,
                                      fontWeight: FontWeight.w400,
                                      // height: 1.00,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // Icon
                                  Text(
                                    "+20 Going",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: themeColor,
                                      fontSize: screenWidth * 0.05,
                                      fontFamily: Poppins,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: fontGrey,
                                  ),
                                  Text(
                                    data.location,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: fontGrey,
                                      fontSize: screenWidth * 0.05,
                                      fontFamily: Poppins,
                                      fontWeight: FontWeight.w300,
                                      // height: 1.00,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                          ),
                    ],
                 
              ),
                
          
          
        ),
      ),
    );
  }
}
