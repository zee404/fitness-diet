import 'dart:async';
import 'dart:typed_data';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/viewmodels/delivViewModel.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingNoBg.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardLinkText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// ignore: must_be_immutable
class UpdateOrderStatusView extends StatefulWidget {
  Order passedOrder;
  UpdateOrderStatusView({@required this.passedOrder});
  @override
  _UpdateOrderStatusViewState createState() => _UpdateOrderStatusViewState();
}

class _UpdateOrderStatusViewState extends State<UpdateOrderStatusView> {
  // >>>>>> orderStatusInfo Below
  GlobalKey<SimpleGroupedChipsState<int>> chipKey =
      GlobalKey<SimpleGroupedChipsState<int>>();
  List _updatedStatusList;
  List<int> _statusListValues = [1, 2, 3, 4, 5, 6];
  List<String> _statusListText = [
    "Order Placed   ",
    "Order Processed   ",
    "Order Dispatched   ",
    "Order Completed   ",
    "Order Cancelled   ",
    "Order Failed   ",
  ];

  // >>>>>> Location Info
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  // this set will hold my markers
  Set<Marker> _markers = {};

  PolylinePoints polylinePoints = PolylinePoints();
  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(34.195317, 73.235871),
    zoom: 10,
  );

// ------------------------------------------------------------------------------
  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

// >>>>>>>>>> U P D A T E   R E A L  - T I M E   M A R AK E R   L O C A T I O N

  void updateMarkerAndCircle(
      LocationData newLocalData, Uint8List imageData) async {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      // >>>>>>>>>>>>> First Marker
      marker = Marker(
        markerId: MarkerId("1"),
        position: latlng,
        rotation: newLocalData.heading,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData),
      );
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
      _markers.add(marker);
    });
    // >>>>>>>>>>>>> Second Marker
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/images/locationIcon.png");
    Uint8List _img2 = byteData.buffer.asUint8List();
    _markers.add(Marker(
      markerId: MarkerId("2"),
      position: LatLng(
        widget.passedOrder.location[0],
        widget.passedOrder.location[1],
      ),
      infoWindow: InfoWindow(
        title: "Order destination",
      ),
      icon: BitmapDescriptor.fromBytes(_img2),
      visible: true,
    ));
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(
              new CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(newLocalData.latitude, newLocalData.longitude),
                tilt: 0,
                zoom: 18.00,
              ),
            ),
          );
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BaseView<DelivViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Order ID: " + widget.passedOrder.orderID),
          backgroundColor: Colors.brown,
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --------------------------- M A P S
                Expanded(
                  flex: 6,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: initialLocation,
                    markers: Set.of((marker != null) ? _markers : []),
                    circles: Set.of((circle != null) ? [circle] : []),
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                  ),
                ),
                // --------------------------- G E T   L O C A T I O N
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () async {
                      getCurrentLocation();
                      await model.updateOrderStatus(
                        [1, 2, 3],
                        widget.passedOrder.orderID,
                      );
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Start Delivery"),
                          SizedBox(width: 5),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: deviceSize.height * 0.04,
                            width: deviceSize.height * 0.04,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child:
                                Center(child: Icon(Icons.location_searching)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 5),
                        child: StandardHeadingNoBg(
                            passedText: "Update order status"),
                      ),
                      Divider(height: 2, thickness: 2),
                      SizedBox(height: 15),
                      // >>>>>>>>>>>>>>>>>>>>>>>>>>  O R D E R   S T A T U S
                      Center(
                        child: SimpleGroupedChips<int>(
                          isMultiple: true,
                          preSelection: model.getOrderStatusPreSelectedList(
                              widget.passedOrder),
                          key: chipKey,
                          isScrolling: false,
                          values: _statusListValues,
                          itemTitle: _statusListText,
                          backgroundColorItem: Colors.black26,
                          onItemSelected: (selected) {
                            print("selected " + selected.toString());
                            setState(() {
                              _updatedStatusList = selected;
                            });
                            // _updatedStatusList.add(selected);

                            print("---> _updatedStatusList inside checkBox: " +
                                _updatedStatusList.toString());
                          },
                        ),
                      ),
                      _updatedStatusList != null
                          ? Center(
                              child: InkWell(
                                onTap: () async {
                                  bool result = await model.updateOrderStatus(
                                      _updatedStatusList,
                                      widget.passedOrder.orderID);
                                },
                                child: StandardLinkText(
                                  passedText: "Update status",
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
            model.state == ViewState.Busy ? Loading() : SizedBox()
          ],
        ),
      ),
    );
  }
}
