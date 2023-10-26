// ignore: must_be_immutable
import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/cartViewModel.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/custViews/ReceiptContainer.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardGradientAppBarText.dart';
import 'package:fitness_diet/ui/widgets/cartItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context);
    final _custData = Provider.of<CustData>(context);
    final _dishData = Provider.of<List<Dish>>(context);
    final _allChefsData = Provider.of<List<ChefData>>(context);

    // final _productdata = Provider.of<List<Product>>(context);

    return BaseView<CartViewModel>(
      onModelReady: (model) async {
        // model.verifyinvetory(_cart.items, _productdata, _cart.cartid);
      },
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Color(0xffe4d7cb),
            title: Row(
              children: [
                StandardGradientAppBarText(passedText: "Cart"),
                Spacer(),
                Text(
                  'Total Items : ' +
                      ConstantFtns().getCartLength(_custData, _cart).toString(),
                  // (_userData != null
                  //     ? _cart.items.length.toString()
                  //     : _cart.items.length.toString())

                  style: TextStyle(
                    fontSize: 15.0,
                    // fontFamily: fontBahnschrift,
                    color: Colors.brown.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              _custData != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: _dishData.length,
                      itemBuilder: (context, index) => model.state ==
                              ViewState.Busy
                          ? Loading()
                          : _cart.items.keys.contains(_dishData[index].dishID)
                              ? CartItemWidget(
                                  passedDish: _dishData[index],
                                  quantity: ConstantFtns().getquantity(
                                      _cart.items, _dishData[index].dishID),
                                )
                              : SizedBox(height: 0),
                    )
                  : Center(
                      child: Text(
                        "Cart is currently empty",
                        style: TextStyle(
                            // fontFamily: fontUniSans,
                            ),
                      ),
                    ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ReceiptContainer(isCartViewReceipt: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
