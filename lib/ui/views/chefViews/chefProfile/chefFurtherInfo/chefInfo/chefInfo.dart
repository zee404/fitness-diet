import 'package:date_format/date_format.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/ui/widgets/standardInfoDisplayWithBullets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChefInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    final deviceSize = MediaQuery.of(context).size;
    return StreamBuilder<List<ChefData>>(
      stream: DatabaseService().getSingleChefData(user.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ChefData _chefData = snapshot.data[0];
          return Container(
            //  color: Colors.amber,
            margin: EdgeInsets.only(left: 20),
            height: deviceSize.height * 0.2,
            width: deviceSize.width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                standardInfDisplaywithBullets(
                    "Bio: ",
                    _chefData.chefBio != null
                        ? _chefData.chefBio.toString()
                        : "",
                    deviceSize),
                standardInfDisplaywithBullets(
                    "Phone no:  ",
                    _chefData.chefPhNo != null
                        ? _chefData.chefPhNo.toString()
                        : "",
                    deviceSize),
                standardInfDisplaywithBullets(
                    "Date of Birth:  ",
                    _chefData.chefDateOfBirth != null
                        ? formatDate(
                            _chefData.chefDateOfBirth, [dd, '-', mm, '-', yyyy])
                        : "",
                    deviceSize),
                // Row(
                //   children: <Widget>[
                //     Constants().standardTextStyle1("Phone no: "),
                //     Constants().standardTextStyle2(_chefData[0].chefPhNo != null
                //         ? _chefData[0].chefPhNo.toString()
                //         : ""),
                //   ],
                // ),
                // Row(
                //   children: <Widget>[
                //     Constants().standardTextStyle1("Date of Birth: "),
                //     Constants().standardTextStyle2(_chefData[0].chefDateOfBirth !=
                //             null
                //         ? formatDate(
                //             _chefData[0].chefDateOfBirth, [dd, '-', mm, '-', yyyy])
                //         : ""),
                //   ],
                // ),
              ],
            ),
          );
        } else {
          return Container(
            child: Text("No data"),
          );
        }
      },
    );
  }
}
