import 'package:fitness_diet/ui/responsive/sizingInformation.dart';
import 'package:fitness_diet/ui/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
      BuildContext context, SizingInformation sizingInformation) builder;
  const ResponsiveBuilder({Key key, this.builder}) : super(key: key);


  

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(builder: (context, boxSizing) {
      var sizingInformation = SizingInformation(
        orientation: mediaQuery.orientation,
        deviceScreenType: getDeviceType(mediaQuery),
        screenSize: mediaQuery.size,
        localWidgetSize: Size(boxSizing.maxWidth, boxSizing.maxHeight),
      );

      return builder(context, sizingInformation);
    });
  }
}
