import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kese_events/features/event/presentation/screens/event_detail_page.dart';
import 'package:kese_events/models/event/event.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class EventListCard extends StatelessWidget {
  final Event data;
  const EventListCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
      elevation: 5,
      shadowColor: Color.fromARGB(255, 235, 235, 235),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 6, 6, 6),
        width: screenWidth * 0.65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          children: [
            Stack(
              children: [
              Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 3),
                  child: Card(
                    shadowColor: whitishBackground,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(15.0)), // if you need this
                    ),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.pushNamed(context, EventDetailPage.routeName,
                            arguments: data)
                      },
                      child: CachedNetworkImage(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.15,
                        imageUrl: data.thumbnail,
                        errorWidget: (context, url, error) =>
                            Image.asset(data.thumbnail),
                        // SvgPicture.string(logo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
             
            ]),
            Container(
                padding: EdgeInsets.fromLTRB(5, 10, 6, 10),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      // "${data.eventStartDate.weekday}, ${data.eventStartDate.month} ${data.eventEndDate.day} ${data.eventEndDate.hour}" ,
                      "${DateFormat('E, MMM d • h:mm a').format(data.eventStartDate)}",
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: blackText,
                                  fontSize: screenWidth * 0.045,
                                  fontFamily: Poppins,
                                  fontWeight: FontWeight.w400,
                                  // height: 1.00,
                                ),
                              ),
                    Text(
                      data.name,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: blackText,
                                  fontSize: screenWidth * 0.07,
                                  fontFamily: Poppins,
                                  fontWeight: FontWeight.w400,
                                  // height: 1.00,
                                ),
                              ),
                        
                        Text(
                              "+20 Going",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                color: themeColor,
                                fontSize: screenWidth * 0.05,
                                fontFamily: Poppins,
                                fontWeight: FontWeight.w400,
                              ),
                                                      ),
                            
                      
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: fontGrey,
                        ),
                        Text(
                              data.location,
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                color: fontGrey,
                                fontSize: screenWidth * 0.04,
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
    );
  }
}
