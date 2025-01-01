import '/my_flutter/my_flutter_util.dart';
import 'text_filed_component_widget.dart' show TextFiledComponentWidget;
import 'package:flutter/material.dart';

class TextFiledComponentModel extends MyFlutterModel<TextFiledComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TF_LinkText widget.
  FocusNode? tFLinkTextFocusNode;
  TextEditingController? tFLinkTextTextController;
  String? Function(BuildContext, String?)? tFLinkTextTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tFLinkTextFocusNode?.dispose();
    tFLinkTextTextController?.dispose();
  }
}
