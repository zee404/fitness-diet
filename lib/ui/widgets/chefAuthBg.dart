import 'package:fitness_diet/ui/shared/imagesURLs.dart';
import 'package:flutter/material.dart';

class ChefAuthBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.4,
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(chefBGImage_1),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.blue.withOpacity(0.9),
              BlendMode.overlay,
            ),
          ),
        ),
      ),
    );
  }
}
