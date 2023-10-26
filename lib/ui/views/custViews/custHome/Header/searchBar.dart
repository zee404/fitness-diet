import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  // SearchBar(this.animationVal);
  // double animationVal;
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //  final deviceSize = MediaQuery.of(context).size;

    return ResponsiveSafeArea(
      builder: (context, deviceSize) => Theme(
        // TO CHANGE THE TEXT FEILD BORDER, TEXT COLOR on focus
        data: Theme.of(context).copyWith(primaryColor: Colors.black),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(33)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(3.00, 3.00),
                  color: Color(0xff000000),
                  blurRadius: 6,
                ),
              ],
            ),
            height: deviceSize
                .height, // Ignore this, It is because parent is layout builder
            child: TextFormField(
              enabled: false,
              style: TextStyle(color: Colors.black), // Text written color
              controller: _controller,
              cursorColor: Colors.black,
              maxLines: 1,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                fillColor: Colors.black,
                labelText: "What are you looking for?",
                labelStyle: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: deviceSize.height * 0.4,
                ),
                //
                // >>>>>>>>> S E A R C H   I C O N
                //
                prefixIcon: IconButton(
                  hoverColor: Colors.brown,
                  padding:
                      EdgeInsets.symmetric(horizontal: deviceSize.width * 0.03),
                  color: Colors.black.withOpacity(0.5),
                  icon: Icon(
                    Icons.search,
                    size: deviceSize.height * 0.6,
                  ),
                  onPressed: () {
                    // Search functionality here
                  },
                ),
                //
                // >>>>>>>>> F i l t e r  I C O N
                //
                suffixIcon: IconButton(
                  hoverColor: Colors.brown,
                  padding:
                      EdgeInsets.symmetric(horizontal: deviceSize.width * 0.06),
                  color: Colors.black.withOpacity(0.8),
                  icon: Icon(
                    Icons.filter_list,
                    size: deviceSize.height * 0.6,
                  ),
                  onPressed: () => _controller.clear(),
                ),

                //______ To adjust label hist text to top
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide(
                      color: Colors.brown,
                      width: 0.7,
                      style: BorderStyle.solid),
                ),
              ),
            ),
          ),
        ),

        //   ClipRRect(
        //     borderRadius: BorderRadius.all(Radius.circular(33)),
        //     child: Container(
        //       height: deviceSize.height * 0.065,
        //       color: Colors.white,
        //       //          color: Colors.white.withOpacity(0.7 + 1-animationVal/10),

        //       child: TextFormField(
        // maxLines: 1,
        // style: TextStyle(color: Colors.black), // Text written color
        // controller: _controller,
        // cursorColor: Colors.black,

        //         decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.auto,
        // fillColor: Colors.black,
        // filled: false,
        // labelText: "What are you looking for?",
        // labelStyle: TextStyle(
        //     color: Colors.black.withOpacity(0.7), fontSize: 14),
        // //
        // // >>>>>>>>> S E A R C H   I C O N
        // //
        // prefixIcon: IconButton(
        //   color: Colors.black.withOpacity(0.5),
        //   icon: Icon(Icons.search),
        //   onPressed: () {
        //     // Filtering functionality here
        //   },
        // ),
        // //
        // >>>>>>>>> C L E A R   I C O N

        // suffixIcon: Row(
        //   // added line
        //   mainAxisSize: MainAxisSize.min, // added line

        //   children: <Widget>[
        //     IconButton(
        //       color: Colors.black.withOpacity(0.5),
        //       icon: Icon(Icons.cancel),
        //       onPressed: () => _controller.clear(),
        //     ),
        //     IconButton(
        //       color: Colors.black.withOpacity(0.8),
        //       icon: Icon(Icons.filter_list),
        //       onPressed: () => _controller.clear(),
        //     ),
        //   ],
        // ),
        // suffixIcon: IconButton(
        //   color: Colors.black.withOpacity(0.8),
        //   icon: Icon(Icons.filter_list),
        //   onPressed: () => _controller.clear(),
        // ),
        // //_______________________________________
        // // enabledBorder: OutlineInputBorder(
        // //   borderRadius: BorderRadius.circular(33),
        // //   borderSide: const BorderSide(color: Colors.black, width: 0.7),
        // // ),
        // //______ To adjust label hist text to top
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(33),
        //   borderSide:
        //       const BorderSide(color: Colors.white, width: 0.7),
        // ),
        //         ),
        //       ),
        //     ),
        //   ),
      ),
    );
  }
}
