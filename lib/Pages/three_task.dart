// import 'package:field_king/Pages/three_task_onclick.dart';
// import 'package:flutter/material.dart';

// class ThreeTask extends StatefulWidget {
//   const ThreeTask({super.key});

//   @override
//   State<ThreeTask> createState() => _ThreeTaskState();
// }

// class _ThreeTaskState extends State<ThreeTask> {
//   final ScrollController _verticalScrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Three Task'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 10,
//             vertical: 10,
//           ),
//           child: Column(
//             children: [
//               firstpage_firstcontainer(context),
//               SizedBox(
//                 height: 10,
//               ),
//               firstpage_completedproject_container(),
//               SizedBox(
//                 height: 10,
//               ),
//               firstpage_project_container(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Container firstpage_project_container() {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 2,
//           color: Colors.grey,
//         ),
//         borderRadius: BorderRadius.circular(
//           20,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 10,
//           vertical: 10,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Projects',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       '2 Project',
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.orange,
//                         borderRadius: BorderRadius.circular(
//                           5,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(
//                           3,
//                         ),
//                         child: Icon(
//                           Icons.add,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             projectWidget(),
//             SizedBox(
//               height: 10,
//             ),
//             projectWidget(),
//           ],
//         ),
//       ),
//     );
//   }

//   Container firstpage_completedproject_container() {
//     return Container(
//       height: 550,
//       decoration: BoxDecoration(
//           border: Border.all(
//             width: 2,
//             color: Colors.grey,
//           ),
//           borderRadius: BorderRadius.circular(
//             20,
//           )),
//       width: double.infinity,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 10,
//           vertical: 5,
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 8,
//               ),
//               child: completedproject_title_row(),
//             ),
//             Expanded(
//               child: Scrollbar(
//                 controller: _verticalScrollController,
//                 thickness: 5,
//                 thumbVisibility: true,
//                 child: ListView.builder(
//                   controller: _verticalScrollController,
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return completedproject_listviewbuilder_container();
//                   },
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Padding completedproject_listviewbuilder_container() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         vertical: 5,
//       ),
//       child: Container(
//         height: 160,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(
//             20,
//           ),
//           border: Border.all(
//             color: Colors.grey,
//             width: 2,
//           ),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 7,
//                       vertical: 10,
//                     ),
//                     child: Container(
//                       height: 130,
//                       decoration: BoxDecoration(
//                         color: Colors.yellow,
//                         borderRadius: BorderRadius.circular(
//                           20,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'image',
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 4,
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   right: 10,
//                   top: 10,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Keydrop Props',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: 'Project Period: ',
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: '04/02/2024 to 04/03/2024',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ]),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         bottom: 10,
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 10,
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       for (int i = 0; i < 3; i++)
//                                         Align(
//                                           widthFactor: 0.5,
//                                           child: Container(
//                                             padding: EdgeInsets.all(
//                                                 2), // Border width
//                                             decoration: BoxDecoration(
//                                               color:
//                                                   Colors.orange, // Border color
//                                               shape: BoxShape.circle,
//                                             ),
//                                             child: CircleAvatar(
//                                               radius: 20,
//                                               child: Text(i.toString()),
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: Colors.orange,
//                                       borderRadius: BorderRadius.circular(
//                                         10,
//                                       )),
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: 13,
//                                     vertical: 10,
//                                   ),
//                                   child: Text(
//                                     'View details',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Row completedproject_title_row() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Completed Projects',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.orange,
//             borderRadius: BorderRadius.circular(
//               5,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(
//               2,
//             ),
//             child: Icon(
//               Icons.add,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget firstpage_firstcontainer(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(
//             20,
//           ),
//           border: Border.all(
//             color: Colors.grey,
//             width: 2,
//           )),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 10,
//           vertical: 5,
//         ),
//         child: Column(
//           children: [
//             firstcontainer_title_row(context),
//             SizedBox(
//               height: 10,
//             ),
//             firstcontainer_second_row()
//           ],
//         ),
//       ),
//     );
//   }

//   Container firstcontainer_second_row() {
//     return Container(
//       height: 110,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: Column(
//               children: [
//                 Container(
//                   child: CircleAvatar(
//                     radius: 37,
//                     child: Text(index.toString()),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   width: 74,
//                   child: Text(
//                     'datadatadatadata',
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Row firstcontainer_title_row(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Text(
//               'My MESHHH ',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Text(
//               '(18 Connections)',
//               style: TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ThreeTaskOnClick()));
//               },
//               child: Text(
//                 'See all',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

// Widget projectWidget() {
//   return Column(
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Jdj',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.orange,
//               borderRadius: BorderRadius.circular(
//                 5,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(
//                 3,
//               ),
//               child: Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Project ID:1111',
//             style: TextStyle(
//               fontSize: 16,
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.orange,
//               borderRadius: BorderRadius.circular(
//                 5,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(
//                 3,
//               ),
//               child: Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             Icons.location_on_outlined,
//           ),
//           Expanded(
//             child: Text(
//               'data salfjdk jkf dfjds fkdsf;ldsjfkd sjf;ladsjkf dsklf;jsk;lfdsl',
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//               textAlign: TextAlign.justify,
//             ),
//           ),
//         ],
//       ),
//       Text(
//         'Project Period: 10/05/2024 to 25/05/2024',
//         style: TextStyle(
//           fontSize: 16,
//         ),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(
//                 10,
//               ),
//               color: Colors.orange,
//             ),
//             padding: EdgeInsets.symmetric(
//               horizontal: 13,
//               vertical: 8,
//             ),
//             child: Text(
//               'Invite MESHHH',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: const Color.fromARGB(255, 243, 90, 79),
//               borderRadius: BorderRadius.circular(
//                 10,
//               ),
//             ),
//             padding: EdgeInsets.all(
//               5,
//             ),
//             child: Icon(
//               Icons.delete,
//             ),
//           ),
//         ],
//       ),
//       SizedBox(
//         height: 8,
//       ),
//       Divider(
//         height: 1,
//         thickness: 2,
//       )
//     ],
//   );
// }
