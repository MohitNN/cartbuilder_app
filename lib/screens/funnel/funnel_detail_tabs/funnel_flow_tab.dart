// import 'package:dotted_decoration/dotted_decoration.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
// import 'package:mint_bird_app/screens/downsell/API/get_user_downsell.dart';
// import 'package:mint_bird_app/screens/funnel/API/get_single_funnel_product.dart';
// import 'package:mint_bird_app/screens/funnel/API/update_funnel_details.dart';
// import 'package:mint_bird_app/screens/funnel/controller/funnel_controller.dart';
// import 'package:mint_bird_app/screens/funnel/funnel_detail_tabs/upsell_edit.dart';
// import 'package:mint_bird_app/screens/funnel/model/single_funnel_product_model.dart';
// import 'package:mint_bird_app/screens/upsell/API/get_user_upsell.dart';
// import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
// import 'package:mint_bird_app/utils/m_colors.dart';
// import 'package:mint_bird_app/widgets/loaders.dart';
// import 'package:mint_bird_app/widgets/popover.dart';
// import 'package:pagination_view/pagination_view.dart';
//
// class FunnelFlowTab extends StatefulWidget {
//   final String funnelId;
//
//   const FunnelFlowTab(this.funnelId, {Key key}) : super(key: key);
//
//   @override
//   _FunnelFlowTabState createState() => _FunnelFlowTabState();
// }
//
// class _FunnelFlowTabState extends State<FunnelFlowTab> {
//   FunnelController funnelController = Get.put(FunnelController());
//   List downSellsList;
//   bool isLoading = false;
//   PaginationViewType paginationViewType;
//   GlobalKey<PaginationViewState> key;
//   DashboardController dashboardController = Get.put(DashboardController());
//   UpsellController upsellController = Get.put(UpsellController());
//
//   @override
//   Widget build(BuildContext context) {
//     getSingleFunnelProductService(widget.funnelId);
//     return Stack(
//       children: [
//         SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: [
//                 StreamBuilder<List<FunnelsProduct1>>(
//                   stream: getSingleFunnelProductBloc.singleFunnelProductStream,
//                   builder: (context, snapshot) {
//                     funnelController.funnelProductList = snapshot.data.obs;
//                     return snapshot.hasData
//                         ? snapshot.data.length > 0
//                             ? ListView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 padding: EdgeInsets.symmetric(vertical: 20),
//                                 itemCount:
//                                     funnelController.funnelProducts.length,
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) {
//                                   return Column(
//                                     children: [
//                                       upSellCard(
//                                           funnelController
//                                               .funnelProductList[index],
//                                           index),
//                                       funnelController.funnelProducts.length ==
//                                               index + 1
//                                           ? SizedBox()
//                                           : Row(
//                                               children: [
//                                                 Container(
//                                                   margin: EdgeInsets.symmetric(
//                                                       horizontal: 12),
//                                                   height: 17.5,
//                                                   child: VerticalDivider(
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ],
//                                             )
//                                     ],
//                                   );
//                                 })
//                             : Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: Get.height / 5),
//                                 child: Text("No Funnel flow found"),
//                               )
//                         : appLoader;
//                   },
//                 ),
//                 InkWell(
//                   onTap: () {
//                     openUpSellList('upsell');
//                     // upsellController.dumData
//                     //     .add("Upsell #01 (\$67.00)");
//                   },
//                   child: Container(
//                     height: 79,
//                     decoration: DottedDecoration(
//                         shape: Shape.box,
//                         borderRadius: BorderRadius.circular(8),
//                         color: mBlue,
//                         strokeWidth: 2),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.add,
//                           size: 35,
//                           color: mBlue,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Add UpSell",
//                           style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w700,
//                               color: mBlue,
//                               fontSize: 20),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     openUpSellList('downSell');
//                   },
//                   child: Container(
//                     height: 79,
//                     decoration: DottedDecoration(
//                         shape: Shape.box,
//                         borderRadius: BorderRadius.circular(8),
//                         color: mBlue,
//                         strokeWidth: 2),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.add,
//                           size: 35,
//                           color: mBlue,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Add DownSell",
//                           style: GoogleFonts.poppins(
//                               fontWeight: FontWeight.w700,
//                               color: mBlue,
//                               fontSize: 20),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   height: 79,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.message_outlined,
//                         size: 35,
//                         color: mDividerColor,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         "Thank You Page",
//                         style: GoogleFonts.roboto(
//                             fontWeight: FontWeight.bold,
//                             color: mDividerColor,
//                             fontSize: 20),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 100,
//                 )
//               ],
//             ),
//           ),
//         ),
//         isLoading ? blurLoader : SizedBox()
//       ],
//     );
//   }
//
//   Widget upSellCard(FunnelsProduct1 data, int index) {
//     String name;
//     funnelController.allUpsellModel.value.response.forEach((element) {
//       if (element.id == data.upsell) {
//         name = element.upsellDetails.upsellName;
//       }
//     });
//     return Column(
//       children: [
//         Container(
//           height: 83,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0xff7676761A).withOpacity(0.2),
//                   blurRadius: 4,
//                   offset: Offset(0, 4),
//                 )
//               ]),
//           child: Row(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: mGreen,
//                   borderRadius: BorderRadius.horizontal(
//                     left: Radius.circular(6),
//                   ),
//                 ),
//                 width: 6.7,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 5),
//                 child: Icon(
//                   Icons.menu,
//                   color: mLightGrey,
//                 ),
//               ),
//               Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 5),
//                   child: SvgPicture.asset(
//                     "assets/icon/greenBox.svg",
//                     height: 35,
//                     color: mGreen,
//                   )),
//               SizedBox(
//                 width: 5,
//               ),
//               Expanded(
//                 child: Text(
//                   name ?? "",
//                   style: GoogleFonts.roboto(
//                       color: mTextboxTitleColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w300),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   upsellController.upsellLoads.value = 0.0;
//                   Get.to(
//                     () => UpsellEdit(
//                       name: name,
//                       upsellId: data.upsell,
//                       type: "fupsell",
//                     ),
//                   );
//                   // setState(() {
//                   //   isLoading = true;
//                   // });
//                   // getUpsellDetailsService(data.upsell).then((value) {
//                   //   setState(() {
//                   //     isLoading = false;
//                   //   });
//                   //   Get.to(() => UpSellDetail(
//                   //         upsellId: data.upsell,
//                   //         upsellName: value.upsell.upsellDetails.upsellName,
//                   //       ));
//                   // });
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(right: 14),
//                   padding: EdgeInsets.all(10),
//                   decoration:
//                       BoxDecoration(color: mLightGrey, shape: BoxShape.circle),
//                   child: Icon(
//                     Icons.edit,
//                     color: Color(0xffcccccc),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         data.downsell.length > 0
//             ? Row(
//                 children: [
//                   Obx(() {
//                     return Container(
//                       margin: EdgeInsets.symmetric(horizontal: 12),
//                       height: 17.5,
//                       child: VerticalDivider(
//                         color:
//                             funnelController.funnelProducts.length == index + 1
//                                 ? Colors.transparent
//                                 : Colors.black,
//                       ),
//                     );
//                   }),
//                   Container(
//                     margin: EdgeInsets.only(left: 100),
//                     alignment: Alignment.centerLeft,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 12.5,
//                           child: VerticalDivider(
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           height: 5,
//                           width: 5,
//                           decoration: BoxDecoration(
//                               border:
//                                   Border.all(color: Colors.black, width: 0.5),
//                               shape: BoxShape.circle),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               )
//             : SizedBox(),
//         data.downsell.length > 0
//             ? downSellCard(data.downsell.first, index)
//             : SizedBox()
//       ],
//     );
//   }
//
//   Widget downSellCard(Downsell data, int index) {
//     String name;
//     funnelController.allDownsellModel.value.response.forEach((element) {
//       if (element.id == data.downsell) {
//         name = element.downsellDetails.downsellName;
//       }
//     });
//     return Row(
//       children: [
//         Obx(() {
//           return Container(
//             margin: EdgeInsets.symmetric(horizontal: 12),
//             height: 83,
//             child: VerticalDivider(
//               color: funnelController.funnelProducts.length == index + 1
//                   ? Colors.transparent
//                   : Colors.black,
//             ),
//           );
//         }),
//         Expanded(
//           child: Container(
//             height: 83,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(6),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0xff7676761A).withOpacity(0.2),
//                     blurRadius: 4,
//                     offset: Offset(0, 4),
//                   )
//                 ]),
//             child: Row(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: mOrange,
//                     borderRadius: BorderRadius.horizontal(
//                       left: Radius.circular(6),
//                     ),
//                   ),
//                   width: 6.7,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 5),
//                   child: Icon(
//                     Icons.menu,
//                     color: mLightGrey,
//                   ),
//                 ),
//                 Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 5),
//                     child: SvgPicture.asset(
//                       "assets/icon/orangeBox.svg",
//                       height: 35,
//                       color: mOrange,
//                     )),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 Expanded(
//                   child: Text(
//                     name ?? "",
//                     style: GoogleFonts.roboto(
//                         color: mTextboxTitleColor,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w300),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Get.to(() => UpsellEdit(
//                           name: name,
//                           upsellId: data.downsell,
//                           type: "fdownsell",
//                         ));
//                     // setState(() {
//                     //   isLoading = true;
//                     // });
//                     // getDownSellDetailsService(data.downsell).then((value) {
//                     //   setState(() {
//                     //     isLoading = false;
//                     //   });
//                     //   Get.to(() => DownSellDetail(
//                     //         downSellId: data.downsell,
//                     //         downSellName:
//                     //             value.downsell.downsellDetails.downsellName,
//                     //       ));
//                     // });
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(right: 14),
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         color: mLightGrey, shape: BoxShape.circle),
//                     child: Icon(
//                       Icons.edit,
//                       color: Color(0xffcccccc),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
//
//   openUpSellList(String type) {
//     getUpSellListService(type);
//     showModalBottomSheet<int>(
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (context) {
//         dashboardController.currentPage.value = 0;
//         return Popover(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: SizedBox(
//               height: Get.height / 2,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(40),
//                       color: mLightGrey,
//                     ),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "Search Upsell",
//                         prefixIcon: Icon(Icons.search_rounded),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: StreamBuilder<List<Map>>(
//                       stream: getUpSellsListBloc.upDataListStream,
//                       builder: (context, snap) {
//                         List upSellsList = [];
//                         if (snap.hasData) {
//                           if (type == 'downSell') {
//                             funnelController.funnelProductList.forEach((value) {
//                               funnelController.allUpsellModel.value.response
//                                   .forEach((element) {
//                                 funnelController.funnelProducts.value
//                                     .forEach((element1) {
//                                   if (element1.downsell.length == 0 &&
//                                       element1.upsell == element.id &&
//                                       element.id == value.upsell) {
//                                     upSellsList.add({
//                                       "upsell_id": element.id,
//                                       "upsell_name":
//                                           element.upsellDetails.upsellName,
//                                       "upsell_price":
//                                           element.upsellDetails.upsellPrice,
//                                     });
//                                   }
//                                 });
//                                 // if (element.id == value.upsell) {
//                                 // upSellsList.add({
//                                 //   "upsell_id": element.id,
//                                 //   "upsell_name":
//                                 //       element.upsellDetails.upsellName,
//                                 //   "upsell_price":
//                                 //       element.upsellDetails.upsellPrice,
//                                 // });
//                                 // }
//                               });
//                             });
//                           } else {
//                             upSellsList = snap.data;
//                           }
//                           return StreamBuilder<List>(
//                             initialData: upSellsList,
//                             stream: getUpSellsListBloc.upSellsListStream,
//                             builder: (context, snapshot) {
//                               return (snapshot.hasData)
//                                   ? ListView.builder(
//                                       shrinkWrap: true,
//                                       padding:
//                                           EdgeInsets.symmetric(vertical: 20),
//                                       itemCount: snapshot.data.length,
//                                       itemBuilder: (context, index) {
//                                         return GestureDetector(
//                                           onTap: () {
//                                             Get.back();
//                                             (type == 'downSell')
//                                                 ? openDownSellList(snapshot
//                                                     .data[index]['upsell_id'])
//                                                 : addUpsellFunnelProducts(
//                                                     upsellId:
//                                                         snapshot.data[index]
//                                                             ['upsell_id'],
//                                                     upsellIndex:
//                                                         funnelController
//                                                             .funnelProducts
//                                                             .length,
//                                                   ).then((value) =>
//                                                     getSingleFunnelProductService(
//                                                         widget.funnelId));
//                                           },
//                                           child: upsellListCard(
//                                               snapshot.data[index]),
//                                         );
//                                       },
//                                     )
//                                   : Center(child: Text("No upsell found"));
//                             },
//                           );
//                         } else {
//                           return appLoader;
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   openDownSellList(String upsellId) {
//     showModalBottomSheet<int>(
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (context) {
//         dashboardController.currentPage.value = 0;
//         return Popover(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: SizedBox(
//               height: Get.height / 2,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(40),
//                       color: mLightGrey,
//                     ),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "Search Downsell",
//                         prefixIcon: Icon(Icons.search_rounded),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: FutureBuilder<List<Map>>(
//                         future: getUpSellListService('downsell'),
//                         builder: (context, snap) {
//                           if (snap.hasData) {
//                             downSellsList = snap.data;
//                             return StreamBuilder<List<Map>>(
//                               initialData: snap.data,
//                               stream: getDownSellsListBloc.downSellsListStream,
//                               builder: (context, snapshot) {
//                                 return (snapshot.hasData)
//                                     ? ListView.builder(
//                                         shrinkWrap: true,
//                                         padding:
//                                             EdgeInsets.symmetric(vertical: 20),
//                                         itemCount: snapshot.data.length,
//                                         itemBuilder: (context, index) {
//                                           return GestureDetector(
//                                             onTap: () {
//                                               Get.back();
//                                               addUpsellFunnelProducts(
//                                                 upsellId: upsellId,
//                                                 upsellIndex: funnelController
//                                                     .funnelProducts.length,
//                                                 downSellId: snapshot.data[index]
//                                                     ['downsell_id'],
//                                               ).then((value) =>
//                                                   getSingleFunnelProductService(
//                                                       widget.funnelId));
//                                             },
//                                             child: downSellListCard(
//                                                 snapshot.data[index]),
//                                           );
//                                         })
//                                     : Center(child: Text("No downsell found"));
//                               },
//                             );
//                           } else {
//                             return appLoader;
//                           }
//                         }),
//                   ),
//                   // PaginationView<DownSellDatum>(
//                   //   key: key,
//                   //   shrinkWrap: true,
//                   //
//                   //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   //   itemBuilder:
//                   //       (BuildContext context, DownSellDatum data, int index) =>
//                   //           Obx(() {
//                   //     return funnelController.downsellId.contains(data.id)
//                   //         ? SizedBox()
//                   //         : downSellListCard(data);
//                   //   }),
//                   //   // header: Text('Header text'),
//                   //   // footer: Text('Footer text'),
//                   //   paginationViewType: paginationViewType,
//                   //   // optional
//                   //   pageFetch: downSellPageFetch,
//                   //   onError: (dynamic error) => Center(
//                   //     child: Text('Some error occured'),
//                   //   ),
//                   //   onEmpty: Center(
//                   //     child: Text('No downsell found'),
//                   //   ),
//                   //   bottomLoader: appLoader,
//                   //   initialLoader: appLoader,
//                   // )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget upsellListCard(Map data) {
//     return Container(
//       margin: EdgeInsets.only(left: 10, right: 10, bottom: 7),
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xff2B2B2B29),
//             offset: Offset(0, 2),
//             blurRadius: 6,
//           )
//         ],
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               data['upsell_name'],
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//             decoration: BoxDecoration(
//                 color: Color(0xffFDEDB1),
//                 borderRadius: BorderRadius.circular(40)),
//             child: Text("\$${data['upsell_price']}"),
//           ),
//           SizedBox(width: 5),
//           Container(
//             padding: EdgeInsets.all(5),
//             decoration: BoxDecoration(
//                 color: Color(0xff00A3F5),
//                 borderRadius: BorderRadius.circular(40)),
//             child: Icon(
//               Icons.arrow_forward_ios_outlined,
//               size: 10,
//               color: Colors.white,
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget downSellListCard(Map data) {
//     return Container(
//       margin: EdgeInsets.only(left: 10, right: 10, bottom: 7),
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xff2B2B2B29),
//             offset: Offset(0, 2),
//             blurRadius: 6,
//           )
//         ],
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               data['downsell_name'] ?? '',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//             decoration: BoxDecoration(
//               color: Color(0xffFDEDB1),
//               borderRadius: BorderRadius.circular(40),
//             ),
//             child: Text("\$${data['downsell_price']}"),
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           Container(
//             padding: EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: Color(0xff00A3F5),
//               borderRadius: BorderRadius.circular(40),
//             ),
//             child: Icon(
//               Icons.arrow_forward_ios_outlined,
//               size: 10,
//               color: Colors.white,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
