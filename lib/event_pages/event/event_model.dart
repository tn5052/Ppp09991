import '/backend/backend.dart';
import '/my_flutter/my_flutter_util.dart';
import 'event_widget.dart' show EventWidget;
import 'package:flutter/material.dart';

class EventModel extends MyFlutterModel<EventWidget> {
  ///  Local state fields for this page.

  bool bBuyTicket = false;

  bool editFeedback = false;

  bool scanResultWindow = false;

  String? eventScanRef;

  String? userScanRef;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for Switch widget.
  bool? switchValue;
  var scanned = '';
  // Stores action output result for [Stripe Payment] action in Button widget.
  String? paymentId;
  // State field(s) for cb_termsNConditions widget.
  bool? cbTermsNConditionsValue;
  // State field(s) for RB_EventFeedback widget.
  double? rBEventFeedbackValue;
  // State field(s) for tf_eventFeedback widget.
  FocusNode? tfEventFeedbackFocusNode;
  TextEditingController? tfEventFeedbackTextController;
  String? Function(BuildContext, String?)?
      tfEventFeedbackTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  EventRatingRecord? qQEventRatingDoc;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  EventsRecord? eventDocL;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  EventsRecord? eventDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfEventFeedbackFocusNode?.dispose();
    tfEventFeedbackTextController?.dispose();
  }
}
