// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class DropdownSimple extends StatefulWidget {
//   String dropDownInitialValue;
//   List<dynamic> passedDropdownList = List();
//   DropdownSimple(
//       {@required this.dropDownInitialValue, @required this.passedDropdownList});

//   @override
//   _DropdownSimpleState createState() => _DropdownSimpleState();
// }

// class _DropdownSimpleState extends State<DropdownSimple> {
//   @override
//   Widget build(BuildContext context) {
//     widget.passedDropdownList.insert(0, widget.dropDownInitialValue); // Merging intital value
//     final _deviceSize = MediaQuery.of(context).size;
//     return ClipRRect(
//       borderRadius: BorderRadius.all(
//         Radius.circular(_deviceSize.height * 0.15),
//       ),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: _deviceSize.width * 0.05),
//         height: _deviceSize.height * 0.04,
//         width: _deviceSize.width * 0.9,
//         color: Colors.white.withOpacity(0.7),
//         child: Center(
//           child: DropdownButton<String>(
//             value: widget.dropDownInitialValue,
//             // icon: Icon(Icons.arrow_downward),
//             //iconSize: 24,
//             elevation: 16,
//             style: TextStyle(
//                 color: Colors.brown.withOpacity(0.8),
//                 fontSize: _deviceSize.height * 0.02),

//             underline: Container(height: 0),
//             isExpanded: true,
//             onChanged: (String newValue) {
//               setState(() {
//                 newValue != "Select Category"
//                     ? _dishCatg = newValue
//                     : _dishCatg = null;
//                 dropDownInitialValue = newValue;
//               });
//             },

//             items: ctgNamesList.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
