import '/components/bottom_navbar_basic1/bottom_navbar_basic1_widget.dart';
import '/components/floating_button_basic1/floating_button_basic1_widget.dart';
import '/my_flutter/my_flutter_util.dart';
import 'bottom_nav_bar1_widget.dart' show BottomNavBar1Widget;
import 'package:flutter/material.dart';

class BottomNavBar1Model extends MyFlutterModel<BottomNavBar1Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for bottomNavbarBasic1 component.
  late BottomNavbarBasic1Model bottomNavbarBasic1Model;
  // Model for floatingButtonBasic1 component.
  late FloatingButtonBasic1Model floatingButtonBasic1Model;

  @override
  void initState(BuildContext context) {
    bottomNavbarBasic1Model =
        createModel(context, () => BottomNavbarBasic1Model());
    floatingButtonBasic1Model =
        createModel(context, () => FloatingButtonBasic1Model());
  }

  @override
  void dispose() {
    bottomNavbarBasic1Model.dispose();
    floatingButtonBasic1Model.dispose();
  }
}
