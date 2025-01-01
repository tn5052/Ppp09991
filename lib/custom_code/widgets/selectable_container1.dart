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

class SelectableContainer1 extends StatefulWidget {
  const SelectableContainer1({
    Key? key,
    this.width,
    this.height,
    this.selectedFillColor,
    this.unselectedFillColor,
    this.unselectedBorderColor,
    this.selectedBorderColor,
    this.borderThickness,
    this.isSelected = false, // Default isSelected to false
    this.isDisable = false, // Default isDisable to false
    required this.child, // Required child widget
  }) : super(key: key);

  final double? width;
  final double? height;
  final Color? selectedFillColor;
  final Color? unselectedFillColor;
  final Color? unselectedBorderColor;
  final Color? selectedBorderColor;
  final double? borderThickness;
  final bool isSelected; // Make isSelected non-nullable
  final bool isDisable; // Make isDisable non-nullable
  final Widget child; // Child widget

  @override
  State<SelectableContainer1> createState() => _SelectableContainer1State();
}

class _SelectableContainer1State extends State<SelectableContainer1> {
  late bool _isSelected; // Track isSelected internally in the state

  @override
  void initState() {
    super.initState();
    _isSelected =
        widget.isSelected; // Initialize _isSelected from widget's isSelected
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isDisable
          ? null
          : _toggleSelection, // Disable selection if isDisable is true
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: _isSelected
              ? widget.selectedFillColor
              : widget.unselectedFillColor,
          border: Border.all(
            color: _isSelected
                ? widget.selectedBorderColor ?? Colors.transparent
                : widget.unselectedBorderColor ?? Colors.transparent,
            width: widget.borderThickness ?? 0,
          ),
        ),
        child: widget.child, // Add child widget here
      ),
    );
  }

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected; // Toggle isSelected state
    });
  }
}
