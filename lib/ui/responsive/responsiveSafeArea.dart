import 'package:flutter/material.dart';

typedef Responsive_Builder = Widget Function(
  BuildContext context,
  Size,
);

class ResponsiveSafeArea extends StatelessWidget {
  final Responsive_Builder responsiveBuilder;

  const ResponsiveSafeArea({
    Key key,
    @required Responsive_Builder builder,
  })  : responsiveBuilder = builder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return responsiveBuilder(
            context,
            constraints.biggest,
          );
        },
      ),
    );
  }
}
