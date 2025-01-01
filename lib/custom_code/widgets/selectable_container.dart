// Automatic MyFlutter imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/my_flutter/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class SelectableContainer extends StatefulWidget {
  const SelectableContainer({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<SelectableContainer> createState() => _SelectableContainerState();
}

class _SelectableContainerState extends State<SelectableContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
