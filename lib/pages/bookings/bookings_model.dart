import '/backend/backend.dart';
import '/my_flutter/my_flutter_util.dart';
import 'bookings_widget.dart' show BookingsWidget;
import 'package:flutter/material.dart';

class BookingsModel extends MyFlutterModel<BookingsWidget> {
  ///  Local state fields for this page.

  bool postNewbottomPopup = true;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // State field(s) for tf_events widget.
  FocusNode? tfEventsFocusNode;
  TextEditingController? tfEventsTextController;
  String? Function(BuildContext, String?)? tfEventsTextControllerValidator;
  // Algolia Search Results from action on tf_events
  List<EventsRecord>? algoliaSearchResults = [];
  // State field(s) for tf_mentors widget.
  FocusNode? tfMentorsFocusNode;
  TextEditingController? tfMentorsTextController;
  String? Function(BuildContext, String?)? tfMentorsTextControllerValidator;
  List<UsersRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    tfEventsFocusNode?.dispose();
    tfEventsTextController?.dispose();

    tfMentorsFocusNode?.dispose();
    tfMentorsTextController?.dispose();
  }
}
