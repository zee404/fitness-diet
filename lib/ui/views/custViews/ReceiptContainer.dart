import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/enums/dialogTypes.dart';
import 'package:fitness_diet/core/enums/orderStatus.dart';
import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/orderViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/custViews/orderSummaryView.dart';
import 'package:fitness_diet/ui/views/custViews/orderView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/bigLightGreenBtn.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardReceiptBigText.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardReceptSmallText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ReceiptContainer extends StatefulWidget {
  bool isCartViewReceipt;
  Map<String, dynamic> shippingAddr;
  ReceiptContainer({@required this.isCartViewReceipt, this.shippingAddr});
  @override
  _ReceiptContainerState createState() => _ReceiptContainerState();
}

double deliveryFee = 60;

class _ReceiptContainerState extends State<ReceiptContainer> {
  DialogService _dialogService = locator<DialogService>();
  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context);
    final _dishData = Provider.of<List<Dish>>(context);
    // final _dishData = Provider.of<List<Product>>(context);
    final _custData = Provider.of<CustData>(context);
    final _planData = Provider.of<Plan>(context);

    double subtotal = ConstantFtns().getTotal(_custData, _cart, _dishData);
    Widget navigateToOrderViewBtn = InkWell(
      onTap: () {
        // bool check =
        //     verifyinvetory(_cart.items, _dishData, _custData.cartID);
        // if (check) {
        print(
            '----------------------- go to Order view from receipt container --------------');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OrderView(),
          ),
        );
        // } else {
        //   _dialogService.showDialog(
        //       title: 'Alert :(',
        //       description:
        //           "we are sory the product is not available in the quantity you requested ...",
        //       buttonTitle: "its ok ",
        //       dialogType: Dialog_Types.PLAN_SUCCESS);
        // }
      },
      child: BigLightGreenBtn(
        passedText: "Checkout",
        isDisabled: false,
      ),
    );

    return BaseView<OrderViewModel>(
      onModelReady: (model) {
        // model.verifyInventory(_cart.items, _dishData, _cart.cartid);
      },
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, deviceSize) => Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: deviceSize.height * 0.25,
            width: deviceSize.width,
            padding: EdgeInsets.symmetric(horizontal: 27),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00),
                  color: Colors.black,
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(42),
                topRight: Radius.circular(42),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StandardReceiptSmallText(
                  passedText: "Sub-total: ",
                  passedPrice: subtotal.toString(),
                ),
                // StandardReceiptSmallText(
                //   passedText: "Total Saved:",
                //   passedPrice:
                //       getTotalSaved(_custData, _cart, _cart, _dishData)
                //           .toString(),
                // ),
                StandardReceiptSmallText(
                  passedText: "Delivery fee: ",
                  passedPrice: subtotal > 4000 ? '0' : deliveryFee.toString(),
                ),
                StandardReceiptBigText(
                  passedText: "Total",
                  passedPrice: (subtotal + deliveryFee).toString(),

                  // subtotal -
                  //             getTotalSaved(
                  //                 _custData, _cart, _cart, _dishData) >
                  //         4000
                  //     ? (subtotal -
                  //             getTotalSaved(
                  //                 _custData, _cart, _cart, _dishData))
                  //         .toString()
                  //     : ((subtotal -
                  //                 getTotalSaved(_custData, _cart, _cart,
                  //                     _dishData)) +
                  //             deliveryFee)
                  //         .toString(),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 5.0,
                ),
                SizedBox(height: 3.0),
                _custData != null
                    ? _cart.items.length != 0
                        ? widget.isCartViewReceipt
                            ? navigateToOrderViewBtn
                            : InkWell(
                                onTap: () async {
                                  // >>>>>> If error
                                  model.hasErrorMessage
                                      ? WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (_) => _showErrorMessage(
                                                    context,
                                                    model.errorMessage,
                                                  ))
                                      : Container();

                                  double _total = subtotal + deliveryFee;

                                  if (widget.shippingAddr != null &&
                                      widget.shippingAddr.keys.first != null &&
                                      widget.shippingAddr.values.first !=
                                          null &&
                                      _custData.custContactNo != null) {
                                    print(" A D D R E S S : " +
                                        widget.shippingAddr.toString());
                                    String orderID = await model.createOrder(
                                      _custData.custId,
                                      _custData.custName,
                                      widget.shippingAddr,
                                      _custData.custContactNo,
                                      [
                                        ConstantFtns().getEnumValue(Order_Status
                                            .ORDER_PLACED
                                            .toString())
                                      ],
                                      _cart.items,
                                      _dishData,
                                      _total,
                                      _custData.cartID,
                                      _planData,
                                    );

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderSummaryView(
                                          orderID: orderID,
                                          orderStatus: [
                                            ConstantFtns().getEnumValue(
                                                Order_Status.ORDER_PLACED
                                                    .toString())
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    await _dialogService.showDialog(
                                      title: 'Alert',
                                      description:
                                          "Address or contact number not found. Kindly enter a valid info before starting an order",
                                      buttonTitle: "OK",
                                      dialogType: Dialog_Types.SMALL_ERROR,
                                    );
                                  }
                                },
                                child: BigLightGreenBtn(
                                  passedText: "Place order",
                                  isDisabled: false,
                                ),
                              )
                        : BigLightGreenBtn(
                            passedText: "Add items first",
                            isDisabled: true,
                          )
                    : _cart.items.length != 0
                        ? widget.isCartViewReceipt
                            ? navigateToOrderViewBtn
                            : BigLightGreenBtn(
                                passedText: "Sign-in required",
                                isDisabled: true,
                              )
                        : BigLightGreenBtn(
                            passedText: "Place order",
                            isDisabled: true,
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showErrorMessage(BuildContext context, String error) async {
    showModalBottomSheet(
      context: (context),
      builder: (context) => UIHelper().showErrorButtomSheet(context, error),
    );
  }
}
