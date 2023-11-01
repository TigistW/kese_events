import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/core/utils/icons.dart';
import 'package:kese_events/features/authentication/bloc/secure_storage.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_in_page.dart';
import 'package:kese_events/features/profile/bloc/profile_bloc/profile_bloc.dart';
import 'package:kese_events/features/profile/presentation/widgets/display_image.dart';
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/user/user.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = "/profile_page";

  // final userProvider = UserProvider();
  // final UserProfile userProfile;
  final userHiveRepository = DependencyInjector.getUserHiveRepository()!;

  bool selected;
  ProfilePage({Key? key, required this.selected}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName = '';
  String lastName = '';
  String email = '';
  String profilePicture = '';
  bool isLoggedIn = false;
  bool _appBarShown = false;

  User user_profile = User(1, "Alemu", "Abebe", "astrid@gmail.com", "logo_ur", "0962636465");
  final SecureStorage _secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    _retrieveisLoggedIn();
    _getUser();
  }

  Future<User> _getUser() async {
    print("just getting user information");
    return await widget.userHiveRepository.getUser();
  }

  Future<void> _deleteUser() async {
    await widget.userHiveRepository.deleteUser();
  }

  Future<void> deleteToken() async {
    _secureStorage.deleteToken();
  }

  _retrieveisLoggedIn() async {
    isLoggedIn = await _secureStorage.hasToken();
  }

  String imageFile = 'https://picsum.photos/250?image=9';

  final ImagePicker _picker = ImagePicker();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    
    if (!widget.selected) {
     return Container(
      );
    }
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
        length: 2,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ProfileBloc>(
              create: (BuildContext context) => ProfileBloc(
                userHiveRepository: DependencyInjector.getUserHiveRepository()!,
               
              ),
            ),
          ],
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              shape: ContinuousRectangleBorder(
                  side: BorderSide(color: const Color.fromARGB(255, 125, 118, 118))),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              actions: [
                PopupMenuButton(
                    onSelected: (value) {
                      if (value == "Edit Profile") {
                        Navigator.pushNamed(context, '');
                      } else if (value == "Change Password") {
                        Navigator.pushNamed(context, '');
                      } else {
                        Row(
                          children: [
                            FutureBuilder<void>(
                                future: _deleteUser(),
                                builder: (context, snapshot) {
                                  return Container();
                                }),
                            FutureBuilder<void>(
                                future: deleteToken(),
                                builder: (context, snapshot) {
                                  return Container();
                                }),
                            FutureBuilder<void>(
                                future: _deleteUser(),
                                builder: (context, snapshot) {
                                  return Container();
                                }),

                          ],
                        );
                        Navigator.pop(context);
                        Navigator.pushNamed(context, SignInPage.routeName);
                      }
                    },
                    enabled: true,
                    itemBuilder: (context) => [
                          _buildPopupMenuItem('Edit Profile', editIcon, context,
                              TextStyle(color: Colors.black)),
                          _buildPopupMenuItem('Change Password', passwordIcon,
                              context, TextStyle(color: Colors.black)),
                          _buildPopupMenuItem('Log out', logoutIcon, context,
                              TextStyle(color: themeColor)),
                        ]),
              ],
            ),
            body: Container(
              // color: themeColor,
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: Column(
                children: [
                  FutureBuilder<User>(
                    future: _getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(".................................................");
                        var user = snapshot.data;
                        print(user);
                        return Column(children: [
                          DisplayImage(
                              imagePath: user?.profilePicture ?? imageFile,
                              hasEditIcon: false,
                              onPressed: () {
                                // TODO: make the image view expand
                              }),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                user?.firstName ?? "Hello",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(" "),
                              Text(
                                user?.lastName ?? "Someone",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user?.email ?? "@someone_email",
                                  style: TextStyle(
                                    color: fontGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]);
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  SizedBox(
                    height: 48,
                    child: AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      bottom: TabBar(
                        labelStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        indicatorColor: themeColor,
                        labelColor: detailTitleColor,
                        unselectedLabelColor: detailTitleColor,
                        tabs: [
                          Tab(
                            text: "Saved",
                          ),
                          Tab(
                            text: "Attended",
                          ),
                        ],
                      ),
                    ),
                  ),

                  // create widgets for each tab bar here
                  // MultiBlocProvider(
                  //   providers: [
                  //     // BlocProvider<UserMaterialBloc>(
                  //     //     create: (BuildContext context) => UserMaterialBloc(
                  //     //           materialRepository:
                  //     //               DependencyInjector.getMaterialRepository()!,
                  //     //           notificationCubit:
                  //     //               DependencyInjector.getNotificationCubit()!,
                  //     //         )),
                  //     // BlocProvider<UserLikeMaterialBloc>(
                  //     //   create: (BuildContext context) => UserLikeMaterialBloc(
                  //     //     materialRepository:
                  //     //         DependencyInjector.getMaterialRepository()!,
                  //     //     notificationCubit:
                  //     //         DependencyInjector.getNotificationCubit()!,
                  //     //   ),
                  //     // ),
                  //   ],
                    // child: FutureBuilder<User>(
                    //   future: _getUser(),
                    //   builder: (_, snapshot) {
                    //     User user = snapshot.data ??
                    //         User(0, "", "","","","");
                    //     User realUser = User(
                    //       user.id ?? 0,
                    //       user.firstName ?? "",
                    //       user.lastName ?? "",
                    //       user.email ?? "",
                    //       user.phoneNumber ?? "",
                    //       user.profilePicture ?? "",
                    //     );
                    //     return Expanded(
                    //       child: TabBarView(
                            
                    //         children: [
                              
                    //           // LikedMaterialList(
                    //           //   user: realUser,
                    //           // ),
                    //           // MaterialList(
                    //           //   user: realUser,
                    //           // ),
                    //         ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        )
        );
  }

  _getFromGallery() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (image != null) {
      setState(() {
        imageFile = image.path;
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      setState(() {
        imageFile = image.path;
      });
    }
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, Icon icon, BuildContext context, TextStyle? textStyle) {
    return PopupMenuItem(
      value: title,
      textStyle: textStyle,
      child: GestureDetector(
        child: Row(
          children: [
            icon,
            SizedBox(
              height: 10,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
