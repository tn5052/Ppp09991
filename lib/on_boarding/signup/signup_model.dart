import '/my_flutter/my_flutter_util.dart';
import 'signup_widget.dart' show SignupWidget;
import 'package:flutter/material.dart';

class SignupModel extends MyFlutterModel<SignupWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // State field(s) for cPassword widget.
  FocusNode? cPasswordFocusNode;
  TextEditingController? cPasswordTextController;
  late bool cPasswordVisibility;
  String? Function(BuildContext, String?)? cPasswordTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    cPasswordVisibility = false;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    cPasswordFocusNode?.dispose();
    cPasswordTextController?.dispose();
  }
}
