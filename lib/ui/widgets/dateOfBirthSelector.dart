import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DateOfBirthSelector extends StatefulWidget {
  final ValueChanged<DateTime> onDateTimeChanged;
  Size deviceSize;

  DateOfBirthSelector({@required this.deviceSize, this.onDateTimeChanged});
  @override
  _DateOfBirthSelectorState createState() => _DateOfBirthSelectorState();
}

class _DateOfBirthSelectorState extends State<DateOfBirthSelector> {
  DateTime dateT;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.deviceSize.width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
                Radius.circular(widget.deviceSize.height * 0.11)),
            child: Container(
              height: widget.deviceSize.height * 0.036,
              width: widget.deviceSize.width * 0.62,
              color: Colors.white.withOpacity(0.7),
              //
              // >>>>>>>>> Date of birth
              //
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: widget.deviceSize.height * 0.01,
                    horizontal: widget.deviceSize.height * 0.02,
                  ),
                  border: new OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(widget.deviceSize.height * 0.15),
                  ),
                  // * DISPLAYING DATE
                  hintText: dateT == null
                      ? "Select a date of birth"
                      : formatDate(dateT, [dd, '-', mm, '-', yyyy]),

                  hintStyle: TextStyle(
                      color: Colors.brown.withOpacity(0.8),
                      fontSize: widget.deviceSize.height * 0.015),

                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(widget.deviceSize.height * 0.15),
                  ),
                  //
                  // >>>>>>>>> Calender Icon (Useless)
                  //
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.date_range,
                      size: widget.deviceSize.height * 0.015,
                      color: Colors.brown.withOpacity(0.7),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
          //
          // >>>>>>>>> Calender Icon ( F U N C T I O N A L )
          //
          Container(
            height: widget.deviceSize.height * 0.04,
            decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconButton(
                color: Colors.black.withOpacity(0.7),
                icon: Icon(
                  Icons.calendar_today,
                  size: widget.deviceSize.height * 0.02,
                  color: Colors.white.withOpacity(0.8),
                ),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  ).then((date) {
                    widget.onDateTimeChanged(date);
                    setState(() {
                      dateT = date;
                    });
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
