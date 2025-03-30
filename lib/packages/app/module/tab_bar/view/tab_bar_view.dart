import 'package:field_king/packages/app/module/cart/view/cart_view.dart';
import 'package:field_king/packages/app/module/chat/view/chat_view.dart';
import 'package:field_king/packages/app/module/home_screen/view/home_screen_view.dart';
import 'package:field_king/packages/app/module/profile/view_profile/view/view_profile_view.dart';
import 'package:field_king/packages/app/module/tab_bar/controller/tab_bar_controller.dart';
import 'package:field_king/packages/config.dart';

final GlobalKey<ScaffoldState> homeViewScaffoldKey = GlobalKey<ScaffoldState>();

class TabBarScreenView extends StatelessWidget {
  TabBarScreenView({super.key});

  final controller = Get.put<TabbarController>(TabbarController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Obx(
        () => Scaffold(
          key: homeViewScaffoldKey,
          extendBody: true,
          // drawer: _buildDrawer(context),
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: [
              HomeScreenView(),
              ChatView(),
              // CartView(),
              ProfileView(),
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: controller.currentIndex.value == 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: SvgPicture.asset(
                          Assets.home,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.currentIndex.value = 0;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                          bottom: 10,
                          top: 10,
                        ),
                        child: Text(
                          'Home',
                          style: controller.currentIndex.value == 0
                              ? TextStyle().semiBold18.textColor(
                                    AppColor.blackColor,
                                  )
                              : TextStyle().medium16.textColor(
                                    AppColor.blackColor,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Visibility(
                      visible: controller.currentIndex.value == 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 2,
                        ),
                        child: SvgPicture.asset(
                          Assets.chat,
                          width: 27,
                          height: 27,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.currentIndex.value = 1;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                          bottom: 10,
                          top: 10,
                        ),
                        child: Text(
                          'Chat',
                          style: controller.currentIndex.value == 1
                              ? TextStyle().semiBold18.textColor(
                                    AppColor.blackColor,
                                  )
                              : TextStyle().medium16.textColor(
                                    AppColor.blackColor,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Visibility(
                //       visible: controller.currentIndex.value == 2,
                //       child: Padding(
                //         padding: const EdgeInsets.only(
                //           bottom: 1,
                //         ),
                //         child: SvgPicture.asset(
                //           Assets.cart,
                //           width: 28,
                //           height: 28,
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         controller.currentIndex.value = 2;
                //       },
                //       child: Padding(
                //         padding: const EdgeInsets.only(
                //           left: 5,
                //           right: 10,
                //           bottom: 10,
                //           top: 10,
                //         ),
                //         child: Text(
                //           'Cart',
                //           style: controller.currentIndex.value == 2
                //               ? TextStyle().semiBold18.textColor(
                //                     AppColor.blackColor,
                //                   )
                //               : TextStyle().medium16.textColor(
                //                     AppColor.blackColor,
                //                   ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Visibility(
                      visible: controller.currentIndex.value == 2,
                      child: SvgPicture.asset(
                        Assets.profile,
                        width: 27,
                        height: 27,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.currentIndex.value = 2;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 10,
                          bottom: 10,
                          top: 10,
                        ),
                        child: Text(
                          'Profile',
                          style: controller.currentIndex.value == 2
                              ? TextStyle().semiBold18.textColor(
                                    AppColor.blackColor,
                                  )
                              : TextStyle().medium16.textColor(
                                    AppColor.blackColor,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SalomonBottomBarItem _buildSalomonBottomBarItem(
  //     {required String iconPath, title}) {
  //   return SalomonBottomBarItem(
  //     icon: SvgPicture.asset(
  //       iconPath,
  //       colorFilter: ColorFilter.mode(
  //         blackWhite(),
  //         BlendMode.srcIn,
  //       ),
  //     ),
  //     title: Text(
  //       title,
  //       style: textStyle600(
  //         fontSize: 12,
  //         color: blackWhite(isOpposite: true),
  //       ),
  //     ),
  //     selectedColor: primaryBlackWhite(),
  //     activeIcon: SvgPicture.asset(
  //       iconPath,
  //       colorFilter: ColorFilter.mode(
  //         blackWhite(isOpposite: true),
  //         BlendMode.srcIn,
  //       ),
  //     ),
  //   );
  // }

  // Theme _buildDrawer(BuildContext context) {
  //   return Theme(
  //     data: ThemeData(useMaterial3: false),
  //     child: Drawer(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.zero,
  //       ),
  //       backgroundColor: primaryBlackWhite(),
  //       child: Column(
  //         children: <Widget>[
  //           Container(
  //             height: 100,
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //               color: primaryBlackWhite(),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: !tc.isDarkMode.value
  //                       ? blackWhite(isOpposite: true).withOpacity(0.16)
  //                       : Colors.transparent,
  //                   blurRadius: 8.4,
  //                   blurStyle: BlurStyle.normal,
  //                   spreadRadius: -3,
  //                   offset: const Offset(0, 4),
  //                 ),
  //               ],
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(
  //                 vertical: 15,
  //                 horizontal: 20,
  //               ),
  //               child: Align(
  //                 alignment: Alignment.bottomLeft,
  //                 child: SvgPicture.asset(
  //                   tc.isDarkMode.value
  //                       ? IconPath.darkModeDrawerLogoIcon
  //                       : IconPath.lightModeDrawerLogoIcon,
  //                   width: 120,
  //                   height: 55,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Container(),
  //           Expanded(
  //             child: ListView(
  //               physics: const BouncingScrollPhysics(),
  //               shrinkWrap: true,
  //               padding: EdgeInsets.zero,
  //               children: <Widget>[
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 DrawerTile(
  //                   onTap: () {
  //                     FocusScope.of(context).unfocus();
  //                     Get.back();
  //                     homeViewController.currentIndex.value = 0;
  //                   },
  //                   title: "Home",
  //                   iconPath: IconPath.drawerhomeIcon,
  //                 ),
  //                 DrawerTile(
  //                   onTap: () async {
  //                     Get.back();
  //                     if (Preference.getIsLogin() == null ||
  //                         Preference.getIsLogin() == false) {
  //                       showLoginDialog(
  //                         context,
  //                         // googleLoginBackFunction: () async {
  //                         //   // Get.find<HomeViewController>().getIsLoginAndLoginType();
  //                         //   // final controller = Get.find<HomeScreenViewController>();
  //                         //   // controller.getIsLoginAndProfileImage();
  //                         //   // await gc.getCity();
  //                         //   await  refreshControllerVariables();
  //                         //   EasyLoading.dismiss();
  //                         //   Get.back();
  //                         // },
  //                         facebookLoginBackFunction: () {
  //                           Get.find<HomeViewController>()
  //                               .getIsLoginAndLoginType();
  //                           Get.find<HomeScreenViewController>().onInit();
  //                           Get.back();
  //                         },
  //                       );
  //                     } else {
  //                       await Future.delayed(const Duration(milliseconds: 200));
  //                       homeViewController.currentIndex.value = 0;
  //                       Get.find<HomeScreenViewController>()
  //                           .focusNode
  //                           .value
  //                           .requestFocus();
  //                     }
  //                   },
  //                   title: "AI Assistant",
  //                   iconPath: IconPath.drawerAiIconSvg,
  //                   // isPng: true,
  //                 ),
  //                 DrawerTile(
  //                   onTap: () {
  //                     Get.back();
  //                     if (Preference.getIsLogin() == null ||
  //                         Preference.getIsLogin() == false) {
  //                       showLoginDialog(
  //                         context,
  //                         // googleLoginBackFunction: () async {
  //                         //   // Get.find<HomeViewController>().getIsLoginAndLoginType();
  //                         //   // final controller = Get.find<HomeScreenViewController>();
  //                         //   // controller.getIsLoginAndProfileImage();
  //                         //   // await gc.getCity();
  //                         //   await  refreshControllerVariables();
  //                         //   EasyLoading.dismiss();
  //                         //   Get.back();
  //                         // },
  //                         facebookLoginBackFunction: () {
  //                           Get.find<HomeViewController>()
  //                               .getIsLoginAndLoginType();
  //                           Get.find<HomeScreenViewController>().onInit();
  //                           Get.back();
  //                         },
  //                       );
  //                     } else {
  //                       Get.toNamed(Routes.hotelView)?.then(
  //                         (value) => homeViewController.currentIndex.value = 0,
  //                       );
  //                     }
  //                     // homeViewController.currentIndex.value = 0;
  //                     // homeViewController.currentIndex.value = 0;
  //                   },
  //                   title: "Hotels",
  //                   iconPath: IconPath.drawerHotelIconSvg,
  //                   // isPng: true,
  //                 ),
  //                 DrawerTile(
  //                   onTap: () {
  //                     Get.back();
  //                     if (Preference.getIsLogin() == null ||
  //                         Preference.getIsLogin() == false) {
  //                       showLoginDialog(
  //                         context,
  //                         // googleLoginBackFunction: () async {
  //                         //   // Get.find<HomeViewController>().getIsLoginAndLoginType();
  //                         //   // final controller = Get.find<HomeScreenViewController>();
  //                         //   // controller.getIsLoginAndProfileImage();
  //                         //   // await gc.getCity();
  //                         //   await  refreshControllerVariables();
  //                         //   EasyLoading.dismiss();
  //                         //   Get.back();
  //                         // },
  //                         facebookLoginBackFunction: () {
  //                           Get.find<HomeViewController>()
  //                               .getIsLoginAndLoginType();
  //                           Get.find<HomeScreenViewController>().onInit();
  //                           Get.back();
  //                         },
  //                       );
  //                     } else {
  //                       Get.toNamed(Routes.searchFlightView)?.then(
  //                         (value) => homeViewController.currentIndex.value = 0,
  //                       );
  //                     }
  //                     // homeViewController.currentIndex.value = 0;
  //                   },
  //                   title: "Flights",
  //                   iconPath: IconPath.drawerFlightIconSvg,
  //                   // isPng: true,
  //                 ),
  //                 DrawerTile(
  //                   onTap: () {
  //                     Get.back();
  //                     if (homeViewController.isLogin.value == true) {
  //                       Get.toNamed(Routes.itineraryList)?.then(
  //                         (value) => homeViewController.currentIndex.value = 0,
  //                       );
  //                     } else {
  //                       showLoginDialog(
  //                         context,
  //                         // googleLoginBackFunction: () async {
  //                         //   // final controller = Get.find<HomeScreenViewController>();
  //                         //   // controller.getIsLoginAndProfileImage();
  //                         //   // await gc.getCity();
  //                         //   // homeViewController.getIsLoginAndLoginType();
  //                         //
  //                         //   await  refreshControllerVariables();
  //                         //   EasyLoading.dismiss();
  //                         //   Get.back();
  //                         // },
  //                         facebookLoginBackFunction: () {
  //                           Get.find<HomeScreenViewController>().onInit();
  //                           homeViewController.getIsLoginAndLoginType();
  //                           Get.back();
  //                         },
  //                       );
  //                     }
  //                   },
  //                   title: "Itinerary",
  //                   iconPath: IconPath.drawerSaveIconSvg,
  //                   // isPng: true,
  //                 ),
  //                 DrawerTile(
  //                   onTap: () {
  //                     Get.back();
  //                     Get.toNamed(
  //                       Routes.reviewListScreen,
  //                       arguments: {
  //                         "isShowAllReview": true,
  //                         "id": Preference.getUserId(),
  //                       },
  //                     )?.then(
  //                       (value) => homeViewController.currentIndex.value = 0,
  //                     );
  //                     // homeViewController.currentIndex.value = 0;
  //                   },
  //                   title: "Reviews",
  //                   iconPath: IconPath.drawerFeedBackIconSvg,
  //                   // isPng: true,
  //                 ),
  //                 DrawerTile(
  //                   onTap: () {
  //                     Get.back();
  //                     Get.toNamed(
  //                       Routes.forumScreen,
  //                       arguments: {
  //                         'isShowAllThread': true,
  //                         "id": Preference.getUserId(),
  //                       },
  //                     )?.then(
  //                       (value) => homeViewController.currentIndex.value = 0,
  //                     );
  //                   },
  //                   title: "Forum",
  //                   iconPath: IconPath.drawerForumIcon,
  //                 ),
  //                 DrawerTile(
  //                   onTap: () {
  //                     Get.back();
  //                     if (homeViewController.isLogin.value == true) {
  //                       Get.toNamed(
  //                         Routes.visitedPlaceMapScreen,
  //                         arguments: {
  //                           'userID': Preference.getUserId(),
  //                         },
  //                       )?.then(
  //                         (value) => homeViewController.currentIndex.value = 0,
  //                       );
  //                     } else {
  //                       showLoginDialog(
  //                         context,
  //                         // googleLoginBackFunction: () async {
  //                         //   // final controller = Get.find<HomeScreenViewController>();
  //                         //   // controller.getIsLoginAndProfileImage();
  //                         //   // await gc.getCity();
  //                         //   // homeViewController.getIsLoginAndLoginType();
  //                         //
  //                         //   await  refreshControllerVariables();
  //                         //   EasyLoading.dismiss();
  //                         //   Get.back();
  //                         // },
  //                         facebookLoginBackFunction: () {
  //                           Get.find<HomeScreenViewController>().onInit();
  //                           homeViewController.getIsLoginAndLoginType();
  //                           Get.back();
  //                         },
  //                       );
  //                     }
  //                   },
  //                   title: "Countries Visited",
  //                   iconPath: IconPath.countriesVisitedIcon,
  //                   // isPng: true,
  //                 ),
  //                 Visibility(
  //                   visible: homeViewController.isLogin.value,
  //                   child: DrawerTile(
  //                     onTap: () {
  //                       Get.back();
  //                       Get.toNamed(
  //                         Routes.editProfileScreen,
  //                         arguments: EditProfileArguments(
  //                           loginType: 'simple',
  //                           source: 'edit',
  //                         ),
  //                       )?.then(
  //                         (value) => homeViewController.currentIndex.value = 0,
  //                       );
  //                       // homeViewController.currentIndex.value = 0;
  //                     },
  //                     title: "Edit Profile",
  //                     iconPath: IconPath.dreaserEditProfileSvg,
  //                     // isPng: true,
  //                   ),
  //                 ),
  //                 Visibility(
  //                   visible: homeViewController.isLogin.value,
  //                   child: DrawerTile(
  //                     onTap: () {
  //                       Get.back();
  //                       Get.toNamed(Routes.changePasswordScreen)?.then(
  //                         (value) => homeViewController.currentIndex.value = 0,
  //                       );
  //                       // homeViewController.currentIndex.value = 0;
  //                     },
  //                     title: "Change Password",
  //                     iconPath: IconPath.drawerChangePasswordIconSvg,
  //                     // isPng: true,
  //                   ),
  //                 ),
  //                 DrawerTile(
  //                   onTap: () {},
  //                   title: "Contact Us",
  //                   iconPath: IconPath.drawerContactIconSvg,
  //                   // isPng: true,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Visibility(
  //             visible: homeViewController.isLogin.value,
  //             child: DrawerTile(
  //               onTap: () async {
  //                 logOutFunction(
  //                   context: context,
  //                   backFunction: () {
  //                     Get.back();
  //                   },
  //                 );
  //               },
  //               title: "Logout",
  //               iconPath: IconPath.logoutIconSvg,
  //               // isPng: true,
  //             ),
  //           ),
  //           const SizedBox(height: 20),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
