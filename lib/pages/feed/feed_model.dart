import '/my_flutter/my_flutter_util.dart';
import 'feed_widget.dart' show FeedWidget;
import 'package:flutter/material.dart';

class FeedModel extends MyFlutterModel<FeedWidget> {
  ///  Local state fields for this page.

  bool postNewPopup = false;

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
