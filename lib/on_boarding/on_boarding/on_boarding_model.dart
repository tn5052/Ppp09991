import '/my_flutter/my_flutter_util.dart';
import 'on_boarding_widget.dart' show OnBoardingWidget;
import 'package:flutter/material.dart';

class OnBoardingModel extends MyFlutterModel<OnBoardingWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
