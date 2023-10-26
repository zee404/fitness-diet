// import 'package:fitness_diet/ui/widgets/Buttons/tinyLeftBtn.dart';
// import 'package:fitness_diet/ui/widgets/Buttons/tinyRightBtn.dart';
// import 'package:flutter/material.dart';

// class TinyBtnRow extends StatefulWidget {
//   final ValueChanged<String> onDateTimeChanged;

//   TinyBtnRow({Key key, this.onDateTimeChanged}) : super(key: key);
//   @override
//   _TinyBtnRowState createState() => _TinyBtnRowState();
// }

// class _TinyBtnRowState extends State<TinyBtnRow> {
//   // * U N I T   B U T T O N   C O N T R O L S
//   bool isGramSelected = false;
//   bool isTspSelected = false;
//   bool isCupsSelected = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//        Row(
//         children: [
//           //* G R A M S
//           Expanded(
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   isGramSelected = true;
//                   isTspSelected = false;
//                   isCupsSelected = false;
//                   widget.onDateTimeChanged("gram");
//                   print(
//                     " C U P S    S E L E C T E D: " +
//                         isCupsSelected.toString() +
//                         " T A B L E S P O O N    S E L E C T E D: " +
//                         isTspSelected.toString() +
//                         " G R A M S    S E L E C T E D: " +
//                         isGramSelected.toString(),
//                   );
//                 });
//               },
//               child: TinyLeftBtn(
//                 isSelected: isGramSelected,
//                 passedText: "Grams",
//               ),
//             ),
//           ),
//           SizedBox(width: 2),
//           //* T A B L E S P O O N
//           Expanded(
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   isGramSelected = false;
//                   isTspSelected = true;
//                   isCupsSelected = false;
//                   widget.onDateTimeChanged("tsp");
//                   print(
//                     " C U P S    S E L E C T E D: " +
//                         isCupsSelected.toString() +
//                         " T A B L E S P O O N    S E L E C T E D: " +
//                         isTspSelected.toString() +
//                         " G R A M S    S E L E C T E D: " +
//                         isGramSelected.toString(),
//                   );
//                 });
//               },
//               child: Container(
//                 color: isTspSelected == true ? Colors.brown : Colors.grey,
//                 child: Center(
//                   child: Text(
//                     "Tablespoon",
//                     style: TextStyle(
//                       color:
//                           isTspSelected == true ? Colors.white : Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 2),
//           //* C U P S
//           Expanded(
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   isGramSelected = false;
//                   isTspSelected = false;
//                   isCupsSelected = true;

//                   widget.onDateTimeChanged("cups");
//                   print(
//                     " C U P S    S E L E C T E D: " +
//                         isCupsSelected.toString() +
//                         " T A B L E S P O O N    S E L E C T E D: " +
//                         isTspSelected.toString() +
//                         " G R A M S    S E L E C T E D: " +
//                         isGramSelected.toString(),
//                   );
//                 });
//               },
//               child: TinyRightBtn(
//                 passedText: "Cups",
//                 isSelected: isCupsSelected,
//               ),
//             ),
//           ),
//         ],
//       ),
   
//     );
//   }
// }
