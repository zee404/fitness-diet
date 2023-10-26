import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ConstantFtns extends BaseViewModel {
  // ------------------------------------------- I M A G E   F U N C T I O N S
  Future<File> cropImgFile(PickedFile picked) async {
    File croppedImg = await ImageCropper.cropImage(
      sourcePath: picked.path,
      aspectRatio: CropAspectRatio(ratioX: 1.3, ratioY: 1.0),
    );
    print("---------> Cropped image inside AddDishViewModel: " +
        croppedImg.toString());
    return croppedImg;
  }

  Future<File> getImgFile(ImageSource source, Size deviceSize) async {
    setState(ViewState.Busy);
    print("-----> 'getImgFile' function reached from inside ConstantFtns");
    ImagePicker imgPick = ImagePicker();
    File croppedImageFile;
    print("image.path");
    PickedFile picked = await imgPick.getImage(
        source: source,
        maxWidth: deviceSize.width,
        // maxHeight: deviceSize.height * 0.1,
        preferredCameraDevice: CameraDevice.front);
    if (picked != null) {
      croppedImageFile = await cropImgFile(picked);
    }
    //_navigationService.goBack();
    setState(ViewState.Idle);
    return croppedImageFile;
  }

  Future<String> uploadFile(File _filePath) async {
    var completer = Completer<String>();
    print("-----> 'uploadFile' function reached from inside ConstantFtns");
    //  String fileBasename = _filePath.path.split('/').last;

    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('dishPics/$_filePath}');
    StorageUploadTask uploadTask = storageReference.putFile(_filePath);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      completer.complete(fileURL);
      print("fileURL inside 'uploadFtns inside ConstantFtns'= " +
          fileURL.toString());
      print("completer.future 'uploadFtns inside ConstantFtns'= " +
          completer.future.toString());
    });
    String _imgURl = await completer.future;
    return _imgURl;
  }

  //
  //----------------------------------------  C  A  R  T -- F  U  N  C  T I  O  N  S -------------------------

  int getCartLength(
    CustData _custData,
    Cart _cart,
  ) {
    int length = 0;
    if (_custData != null) {
      _cart.items.forEach((key, value) {
        length = length + value;
      });

      // length = _useCart.items.length;
    }

    return length;
  }

  int getquantity(Map<String, dynamic> items, String dishID) {
    print('inside get quantity function product id is  ' + dishID);
    print('*****************items length in get quatity function ' +
        items.length.toString());
    int quan = 0;
    items.forEach((key, value) {
      print('key in items is ' + key.toString());
      if (key == dishID) {
        // print('product id found ' + value.toString());
        String str = value.toString();

        int i = int.parse(str);
        quan = i;
        print('product id found ' + quan.toString());
        return i;
      }
    });
    return quan;
  }

  double getTotal(CustData _custData, Cart _cart, List<Dish> _dishData) {
    double subtotal = 0;
    print('******************inside get total function in receipt container ');

    if (_custData != null) {
      for (int i = 0; i < _dishData.length; i++) {
        if (_cart.items.keys.contains(_dishData[i].dishID)) {
          int _singlePrice =
              // checkOffer(_dishData[i].price, _dishData[i].salePrice)
              //     ? _dishData[i].salePrice
              //     :
              _dishData[i].dishPrice;

          subtotal = subtotal +
              _singlePrice * getquantity(_cart.items, _dishData[i].dishID);
        }
      }
    }

    return subtotal;
  }

  String getEnumValue(String enumvalue) {
    String newenum = enumvalue.toString().split('.').last;
    return newenum;
  }

  String getStringAfterCharacter(String _completeString, String _char) {
    return _completeString.substring(
        _completeString.indexOf(_char) + 1, _completeString.length);
  }

  String getStringBeforeCharacter(String _completeString, String _char) {
    return _completeString.substring(0, _completeString.indexOf(_char) - 1);
  }
  //* ---------------------------------------- I N G R   U N I T   C O N V E R T E R
// >>>>>   ½ cup (3.55oz) --- 100g --- 6.67 tsp
// >>>>> 1 gram = 0.067 tsp  1 tsp = 15 grams
// >>>>> 1 tsp = 0.0625 cup  1 cup = 16 tsp
// >>>>> 1 cup = 219 gram (Generalized)  1 gram = 0.0046 cups

  double gramsToTablespoon(double _gramValue) {
    return _gramValue / 6.67;
  }

  double tablespoonToGram(double _tableSpoonValue) {
    return _tableSpoonValue * 6.67;
  }

  double gramsToCups(double _gramValue) {
    return (_gramValue * 219) / 100;
  }

  double cupsToGram(double _cupValue) {
    return (_cupValue / 219) * 100;
  }

  double tablespoonToCup(double _tableSpoonValue) {
    return _tableSpoonValue * 16;
  }

  double cupsToTablespoon(double _cupsValue) {
    return _cupsValue / 16;
  }

////
  ///
  ///

  // ------------------------------------------- L O G I C    H E L P E R    F U N C T I O N S

  // List<dynamic> extractSingleFeildListFromProviderList(
  //     List<dynamic> _providerList, dynamic feildName) {
  //   print("+++++++++++ Feild name: " + feildName);
  //   List<dynamic> _newExtractedList = List<dynamic>();
  //   for (int i = 0; i < _providerList.length; i++) {
  //     print("_providerList[i].ctgName " + _providerList[i].);
  //     _newExtractedList.add(_providerList[i].ctgName);
  //   }
  //   return _newExtractedList;
  // }

  String removeStringTypeListBrackets(String _passedList) =>
      _passedList.toString().replaceAll('[', '').replaceAll(']', '');

  String removeStringTypeListCurlyBrackets(String _passedList) =>
      _passedList.toString().replaceAll('{', '').replaceAll('}', '');
}
