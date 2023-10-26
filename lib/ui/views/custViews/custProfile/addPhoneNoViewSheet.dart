import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custProfileViewmodel.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFeildWithPrefix.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPhoneNoSheet extends StatefulWidget {
  @override
  _AddPhoneNoSheetState createState() => _AddPhoneNoSheetState();
}

class _AddPhoneNoSheetState extends State<AddPhoneNoSheet> {
  // ignore: unused_field
  TextEditingController _phoneNocontroler = TextEditingController();

  Color _color = Colors.white;
  Color _textcolor = Colors.black;
  // DateTime _dateOfBirth;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final _custData = Provider.of<CustData>(context);
    final deviceSize = MediaQuery.of(context).size;

    return BaseView<CustProfileViewModel>(
      builder: (context, model, child) => Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(30),
          height: deviceSize.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: ListView(
            children: <Widget>[
              // ---------------------------------------------------- H E A D E R   T E X T
              Text(
                "Add contact NO",
                style: TextStyle(
                  color: Color(0xff99CA96),
                  fontSize: 25,
                  fontFamily: "Montserrat",
                ),
              ),
              // ---------------------------------------------------- C U S T    P R O F I L E   C H A N G E

              // // ---------------------------------------------------- E D I T   C U S T    I N F O
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //
                  // >>>>>>>>>   A  D  D  R  E  S --T  I  T  L  E --   L A B E L
                  //

                  SizedBox(height: deviceSize.height * 0.02),
                  Container(
                    child: Text(
                      "Contact NO: ",
                      style: TextStyle(
                        color: Color(0xff99CA96),
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.01),
                  //
                  // >>>>>>>>>  C  O  N  T  A  C  T  N  O   -- T E X T F E I L D
                  //
                  TextFeildWithPrefix(
                    controller: _phoneNocontroler,
                    deviceSize: deviceSize,
                    isTypeInt: true,
                    preIcon: Icons.phone_android,
                    hintText: 'eg:03********* ,',
                    isObscureText: false,
                  ),
                  //
                  // >>>>>>>>>   A  R  E  A    L A B E L
                  //

                  SizedBox(height: deviceSize.height * 0.02),
                ],
              ),

              // ---------------------------------------------------- D O N E   B U T T O N

              FlatButton(
                onPressed: () {
                  if (_phoneNocontroler == null) {
                    print('field cannot be empty ');
                  } else {
                    bool check = model.addphoneNO(
                        _custData.custId, _phoneNocontroler.text, context);

                    check ? Navigator.pop(context) : null;
                  }
                  // model.updaetAddress(_custData.custId,);
                  // }
                },
                child: Container(
                  width: deviceSize.width * 0.3,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
