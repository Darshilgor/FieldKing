import 'package:field_king/Pages/chat.dart';
import 'package:field_king/Pages/home_page.dart';
import 'package:field_king/Pages/order_list.dart';
import 'package:field_king/Pages/profile.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({
    super.key,
  });

  @override
  State<HomePageView> createState() => _HomeState();
}

class _HomeState extends State<HomePageView> {
  int index = 0;
  PageStorageBucket bucket = PageStorageBucket();
  final List screens = const [
    HomePage(),
    Chat(),
    OrderList(),
    Profile(),
  ];
  Widget currentScreen = const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: false,
        currentIndex: index,
        onTap: (index) {
          setState(() {
            this.index = index;
            currentScreen = screens[index];
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind),
            label: '',
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: PageStorage(
  //       bucket: bucket,
  //       child: currentScreen,
  //     ),
  //     bottomNavigationBar: BottomNavigationBar(
  //       type: BottomNavigationBarType.shifting,
  //       selectedItemColor: Colors.blue,
  //       unselectedItemColor: Colors.black,
  //       showUnselectedLabels: false,
  //       currentIndex: index,
  //       onTap: (index) {
  //         setState(() {
  //           this.index = index;
  //           currentScreen = screens[index];
  //         });
  //       },
  //       items: const <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home),
  //           label: '',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.school),
  //           label: '',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.live_tv),
  //           label: '',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.assignment_ind),
  //           label: '',
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Future sendnotification() async {
  //   notificationservices.getdevicetoken().then(
  //     (value) async {
  //       var data = {
  //         'to': value.toString(),
  //         'priority': 'high',
  //         'notification': {
  //           'title': 'Gor',
  //           'body': 'Darshil',
  //         }
  //       };
  //       await http.post(
  //         Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //         body: jsonEncode(data),
  //         headers: {
  //           'Content-Type': 'application/json;charset=UTF-8',
  //           'Authorization':
  //               'Key=AAAAkFDq8M4:APA91bH_62mL7DqvHbvwKyPNB5GagygGFkWi0ugeuVn6ZJaMTdlgA0FLbPgKuIBmTCqu3wmrT-TgmLip1994v6MkgibGX8-bN06NTJccgOoC3K8dhGZMyYU85WHkI8O2A4TF7vp3QP9X'
  //         },
  //       );
  //     },
  //   );
  // }
}
