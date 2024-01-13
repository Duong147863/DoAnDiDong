// import 'package:doandidongappthuongmai/components/ProductItem.dart';
// import 'package:flutter/material.dart';

// class SectionList extends StatefulWidget {
//   final List<String> buttonTexts;

//   const SectionList({Key? key, required this.buttonTexts}) : super(key: key);

//   @override
//   _ButtonListState createState() => _ButtonListState();
// }

// class _ButtonListState extends State<SectionList> {
//   int selectedButtonIndex = 0;

//   // Sample product data

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: 60),
//         Container(
//           height: 45,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: widget.buttonTexts.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       selectedButtonIndex = index;
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: selectedButtonIndex == index ? Colors.blue[200] : Colors.grey[100],
//                     side: BorderSide(color: Colors.black),
//                   ),
//                   child: Text(
//                     widget.buttonTexts[index],
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 8),
//           height: 210,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: productData[selectedButtonIndex].length,
//             itemBuilder: (context, index) {
//               var productDetails = productData[selectedButtonIndex][index];
//               return ProductItem(
//                 image: productDetails['image'],
//                 Name: productDetails['name'],
//                 price: productDetails['price'],
//                 promotion: productDetails['promotion'],
//               );
//             },
//           ),
//         ),
//         SizedBox(height: 10),
//         Text("Xem thêm sản phẩm bán chạy", style: TextStyle(decoration: TextDecoration.underline, color: Colors.green)),
//       ],
//     );
//   }
// }
