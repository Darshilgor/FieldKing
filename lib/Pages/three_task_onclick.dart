// import 'package:flutter/material.dart';

// class ThreeTaskOnClick extends StatefulWidget {
//   const ThreeTaskOnClick({super.key});

//   @override
//   State<ThreeTaskOnClick> createState() => _ThreeTaskOnClickState();
// }

// class _ThreeTaskOnClickState extends State<ThreeTaskOnClick> {
//   bool selected = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 45, 45, 45),
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 45, 45, 45),
//         title: Text(
//           'Andrew',
//           style: TextStyle(
//             fontSize: 22,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.symmetric(
//           vertical: 20,
//           horizontal: 10,
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(
//               100,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.white.withOpacity(0.5),
//                 spreadRadius: 2,
//                 blurRadius: 10,
//                 offset: Offset(0, 2), // changes the direction of shadow
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(
//               15,
//             ),
//             child: Icon(
//               Icons.add,
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             secondpage_title_container(context),
//             Align(
//               alignment: selected == true
//                   ? Alignment.centerRight
//                   : Alignment.centerLeft,
//               child: Container(
//                 width: (MediaQuery.of(context).size.width / 2) - 10,
//                 height: 5,
//                 decoration: BoxDecoration(
//                   color: Colors.orange,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(
//                       10,
//                     ),
//                     bottomRight: Radius.circular(
//                       10,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             secondpage_serachbar(),
//             SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 20,
//                 itemBuilder: (context, index) {
//                   return secondpage_listview_container();
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Padding secondpage_listview_container() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         vertical: 5,
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey,
//           borderRadius: BorderRadius.circular(
//             10,
//           ),
//         ),
//         width: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 10,
//             vertical: 10,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 33,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Envior Groups',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text('Gas Engineer, Crane Operator,Woodcutter.')
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 10,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(
//                       10,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.red.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 10,
//                         offset: Offset(0, 2), // changes the direction of shadow
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     'Disconnect',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Container secondpage_serachbar() {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         vertical: 13,
//         horizontal: 10,
//       ),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(
//           10,
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Search',
//             style: TextStyle(
//               fontSize: 16,
//             ),
//           ),
//           Icon(
//             Icons.search_rounded,
//           ),
//         ],
//       ),
//     );
//   }

//   Container secondpage_title_container(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(
//             10,
//           ),
//           topRight: Radius.circular(
//             10,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           InkWell(
//             onTap: () {
//               selected = false;
//               setState(() {});
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                 vertical: 18,
//                 horizontal: 15,
//               ),
//               width: MediaQuery.of(context).size.width / 2 - 10,
//               child: Center(
//                 child: Text(
//                   'My MESHHH',
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               selected = true;
//               setState(() {});
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                 vertical: 18,
//                 horizontal: 15,
//               ),
//               width: MediaQuery.of(context).size.width / 2 - 10,
//               child: Center(
//                 child: Text(
//                   'MESHHH Network',
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
