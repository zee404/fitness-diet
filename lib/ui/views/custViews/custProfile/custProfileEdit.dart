import 'dart:io';
import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custProfileEditViewModel.dart';
import 'package:fitness_diet/ui/shared/constants.dart';
import 'package:fitness_diet/ui/shared/imagesURLs.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/authBtnStyle.dart';
import 'package:fitness_diet/ui/widgets/dateOfBirthSelector.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFeildWithPrefix.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CustProfileEdit extends StatefulWidget {
  @override
  _CustProfileEditState createState() => _CustProfileEditState();
}

class _CustProfileEditState extends State<CustProfileEdit> {
  DateTime _dateOfBirth;
  // ignore: unused_field
  TextEditingController _custContactNoController = TextEditingController();
  TextEditingController _custNameController = TextEditingController();

  File _custPic;
  // DateTime _dateOfBirth;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _custData = Provider.of<CustData>(context);
    final deviceSize = MediaQuery.of(context).size;

    return BaseView<CustProfileEditViewModel>(
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
                "Edit your profile",
                style: TextStyle(
                  color: Constants().headerTextColor1,
                  fontSize: 25,
                  fontFamily: "Montserrat",
                ),
              ),
              // ---------------------------------------------------- C U S T    P R O F I L E   C H A N G E
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  _custPic != null
                      ? Container(
                          height: deviceSize.height * 0.12,
                          width: deviceSize.height * 0.12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(File(_custPic.path)),
                              //   image: AssetImage(custBGImage_1),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          height: deviceSize.height * 0.12,
                          width: deviceSize.height * 0.12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(chefBGImage_1),
                              //   image: AssetImage(custBGImage_1),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  Container(
                    margin: EdgeInsets.only(
                        top: deviceSize.height * 0.09,
                        left: deviceSize.width * 0.14),
                    child: FlatButton(
                      onPressed: () => showBottomSheet(
                        // shape: boxS,
                        backgroundColor: Colors.lightBlueAccent,
                        context: context,
                        builder: (context) => Container(
                          width: deviceSize.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              // ListTile(
                              //   title: Text("Pick from Gallery"),
                              // onTap: () async {
                              //   File custPic = await ConstantFtns().getImgFile(
                              //       ImageSource.gallery, deviceSize);
                              //   print("------- custPic inside AddDishVIew:" +
                              //       custPic.toString());
                              //   setState(() {
                              //     _custPic = custPic;
                              //     print("------- _dishPic AddDishVIew:" +
                              //         custPic.toString());
                              //   });
                              // },
                              // ),
                              FlatButton(
                                onPressed: () async {
                                  File custPic = await ConstantFtns()
                                      .getImgFile(
                                          ImageSource.gallery, deviceSize);
                                  print("------- custPic inside AddDishVIew:" +
                                      custPic.toString());
                                  setState(() {
                                    _custPic = custPic;
                                    print("------- _dishPic AddDishVIew:" +
                                        custPic.toString());
                                  });
                                },
                                child: Text("Pick from Gallery"),
                              ),
                              FlatButton(
                                onPressed: () async {
                                  File custPic = await ConstantFtns()
                                      .getImgFile(
                                          ImageSource.camera, deviceSize);
                                  print("------- custPic inside AddDishVIew:" +
                                      custPic.toString());
                                  setState(() {
                                    _custPic = custPic;
                                    print("------- _dishPic AddDishVIew:" +
                                        custPic.toString());
                                  });
                                },
                                child: Text("Take a Picture"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ),
                  )
                ],
              ),
              // ---------------------------------------------------- E D I T   C U S T    I N F O
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //
                  // >>>>>>>>> U S E R N A M E    L A B E L
                  //
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      "Enter username: ",
                      style: TextStyle(
                        color: Constants().headerTextColor1,
                      ),
                    ),
                  ),
                  SizedBox(height: deviceSize.height * 0.01),
                  //
                  // >>>>>>>>> U S E R N A M E   T E X T F E I L D
                  //
                  TextFeildWithPrefix(
                    controller: _custNameController,
                    deviceSize: deviceSize,
                    isTypeInt: false,
                    preIcon: Icons.account_circle,
                    hintText: _custData.custName,
                    isObscureText: false,
                  ),
                  //
                  // >>>>>>>>> R E S I D E N C E    L A B E L
                  //
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Change Contact NO: ",
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
                    controller: _custContactNoController,
                    deviceSize: deviceSize,
                    isTypeInt: true,
                    preIcon: Icons.contact_phone_rounded,
                    hintText: _custData.custContactNo.toString(),
                    isObscureText: false,
                  ),
                  //
                  // >>>>>>>>> D A T E   O F   B I R T H   D R O P D O W N
                  //
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "Date of birth: ",
                          style: TextStyle(
                            color: Constants().headerTextColor1,
                          ),
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.01),
                      DateOfBirthSelector(
                        deviceSize: deviceSize,
                        onDateTimeChanged: (newDateTime) {
                          _dateOfBirth = newDateTime;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: deviceSize.height * 0.01),
                  // Container(
                  //   padding: EdgeInsets.only(top: 10, bottom: 10),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Text("Date of birth: "),
                  //       Text(_date == null ? "Old DOB" : _date.toString()),
                  //       Spacer(),
                  //       InkResponse(
                  //         onTap: () => _selectDate(context),
                  //         child: Icon(Icons.calendar_today),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),

              // ---------------------------------------------------- D O N E   B U T T O N

              FlatButton(
                onPressed: () => model.updateCustData(_custNameController.text,
                    _custContactNoController.text, _dateOfBirth, _custPic),
                child: AuthBtnStyle(deviceSize: deviceSize, passedText: "Done"),
              ),

              // FlatButton(
              //   onPressed: () async {
              //     // if (_formKey.currentState.validate()) {
              //     //   await DatabaseService(uid: user.uid).updateCustData({
              //     //     'custName': _custNameController ?? _custData.custName,
              //     //     //      _custContactNoController ?? _custData.residence,
              //     //     //  _dateOfBirth ?? _custData.dateOfBirth,
              //     //   });
              //     //   Navigator.pop(context);
              //     // }
              //   },
              //   child: Container(
              //     width: deviceSize.width * 0.3,
              //     padding: EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //       color: Colors.green.withOpacity(0.8),
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(30),
              //       ),
              //     ),
              //     child: Center(
              //       child: Text(
              //         "Done",
              //         style: TextStyle(
              //             color: Constants().headerTextColor1,
              //             fontFamily: 'Montserrat'),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
