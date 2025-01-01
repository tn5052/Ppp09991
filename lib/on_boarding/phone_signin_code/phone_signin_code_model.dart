import '/my_flutter/my_flutter_util.dart';
import 'phone_signin_code_widget.dart' show PhoneSigninCodeWidget;
import 'package:flutter/material.dart';

class PhoneSigninCodeModel extends MyFlutterModel<PhoneSigninCodeWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pinCodeController?.dispose();
  }
}
