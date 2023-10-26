import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custProfileViewmodel.dart';
import 'package:fitness_diet/ui/shared/constants.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/authBtnStyle.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFeildWithPrefix.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFieldWithPrefixDisabled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddAddressView extends StatefulWidget {
  String addressTitle;

  AddAddressView({
    this.addressTitle,
  });
  @override
  _AddAddressViewState createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  // ignore: unused_field
  TextEditingController _addressHousecontroler = TextEditingController();
  TextEditingController _addresstitleControler = TextEditingController();
  TextEditingController _addressAreacontroler = TextEditingController();
  TextEditingController _addressCitytroler = TextEditingController();

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
          height: deviceSize.height * 0.6,
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
                "Add Address",
                style: TextStyle(
                  color: Constants().headerTextColor1,
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
                      "Address Title: ",
                      style: TextStyle(
                        color: Constants().headerTextColor1,
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.01),
                  //
                  // >>>>>>>>>   A  D  D  R  E  S  --- T  I  T  L  E -- T E X T F E I L D
                  //
                  widget.addressTitle == null
                      ? TextFeildWithPrefix(
                          controller: _addresstitleControler,
                          deviceSize: deviceSize,
                          isTypeInt: false,
                          preIcon: Icons.map,
                          hintText: 'eg:Home,Office,Others',
                          isObscureText: false,
                        )
                      : TextFeildWithPrefixDisabled(
                          controller: _addresstitleControler,
                          deviceSize: deviceSize,
                          isTypeInt: false,
                          preIcon: Icons.map,
                          hintText: widget.addressTitle,
                          isObscureText: false),
                  //
                  // >>>>>>>>>   A  R  E  A    L A B E L
                  //

                  SizedBox(height: deviceSize.height * 0.02),
                  Container(
                    child: Text(
                      "Flat,House,OfficeNo : ",
                      style: TextStyle(
                        color: Constants().headerTextColor1,
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.01),
                  //
                  // >>>>>>>>>   A  R  E  A   T E X T F E I L D
                  //
                  TextFeildWithPrefix(
                    controller: _addressHousecontroler,
                    deviceSize: deviceSize,
                    isTypeInt: false,
                    preIcon: Icons.map,
                    hintText: 'eg:Street 2 ,',
                    isObscureText: false,
                  ),

                  //
                  // >>>>>>>>> R E S I D E N C E    L A B E L
                  //
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Area,Colony,Sector,Street: ",
                      style: TextStyle(
                        color: Constants().headerTextColor1,
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.01),
                  //
                  // >>>>>>>>> R E S I D E N C E   T E X T F E I L D
                  //
                  TextFeildWithPrefix(
                    controller: _addressAreacontroler,
                    deviceSize: deviceSize,
                    isTypeInt: false,
                    preIcon: Icons.home,
                    hintText: 'eg janahabad',
                    isObscureText: false,
                  ),
                  //

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "City ",
                      style: TextStyle(
                        color: Constants().headerTextColor1,
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.01),
                  //
                  // >>>>>>>>> C  I  T  Y   T E X T F E I L D*******************************************************
                  //

                  TextFeildWithPrefixDisabled(
                      controller: null,
                      deviceSize: deviceSize,
                      isTypeInt: false,
                      preIcon: Icons.location_city,
                      hintText: 'Abbottabad',
                      isObscureText: false),
                  SizedBox(height: deviceSize.height * 0.02),
                ],
              ),

              // ---------------------------------------------------- D O N E   B U T T O N

              FlatButton(
                onPressed: () {
                  if (_addresstitleControler == null ||
                      _addressHousecontroler == null ||
                      _addressAreacontroler == null) {
                    print('field cannot be empty ');
                  } else {
                    model.updaetAddress(
                      _custData.custId,
                      widget.addressTitle == null
                          ? _addresstitleControler.text
                          : widget.addressTitle,
                      _addressHousecontroler.text,
                      _addressAreacontroler.text,
                      'Abbottabad',
                    );
                    Navigator.pop(context);
                  }
                  // model.updaetAddress(_custData.custId,);
                  // }
                },
                child: AuthBtnStyle(deviceSize: deviceSize, passedText: "Done"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
