
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kese_events/core/shared_widgets/custome_app_bar.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_bloc.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_event.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_state.dart';
import 'package:kese_events/features/event/presentation/widgets/event_list_content.dart';
import 'package:kese_events/features/event/presentation/widgets/home_all_contents.dart';
import 'package:kese_events/features/event/presentation/widgets/home_content.dart';
import 'package:kese_events/features/profile/presentation/screens/profile_page.dart';
import 'package:kese_events/injector.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/homepage";
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisible = false;
  int isSelected = 0;
  late bool isLoggedIn = false;
  bool _appBarShown = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            setState(() {
              isSelected = 0;
              _appBarShown = true;
            });
            return Future.value(false);
          },
          child: Scaffold(
            appBar: _appBarShown == true
                ?  PreferredSize(
                    preferredSize: Size.fromHeight(screenHeight * 0.27),
                    child: CustomeAppbar(
                    onPressed: () => Navigator.pushNamed(
                        context, ''),
                    isVisible: isVisible,
                    onTap: () {
                      setState(() {
                        context.read<EventBloc>().add(EventInitial() as EventEvent);
                        isVisible = !isVisible;
                      });
                    }
                    )
                ):null,

            backgroundColor: Colors.white,
            body: IndexedStack(
              index: isSelected,
              children: [
                AllHomeContents(),
                EventListContent(),
                ProfilePage(selected:isSelected == 2),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: bottomNavigationBackground,
              selectedItemColor: bottomNavigationSelectedColor,
              currentIndex: isSelected,
              onTap: (index) {

                
                if (index == 1 || index == 2) {
                  _appBarShown = false;
                }
                if (index == 0) {
                  _appBarShown = true;
                }

                 setState(() {
                    isSelected = index;
                    if (isSelected == 0) {
                      _appBarShown = true;
                    }
                  });
              },

              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: "Discover"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }
// }
}
