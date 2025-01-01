import '/my_flutter/my_flutter_choice_chips.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/form_field_controller.dart';
import '/my_flutter/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'cc_list_view_model.dart';
export 'cc_list_view_model.dart';

class CcListViewWidget extends StatefulWidget {
  const CcListViewWidget({
    super.key,
    this.parameter1,
    this.parameter2,
  });

  final DateTime? parameter1;
  final DateTime? parameter2;

  @override
  State<CcListViewWidget> createState() => _CcListViewWidgetState();
}

class _CcListViewWidgetState extends State<CcListViewWidget> {
  late CcListViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CcListViewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyFlutterChoiceChips(
      options: functions
          .newCustomFunction(widget.parameter1, widget.parameter2)!
          .map((label) => ChipData(label))
          .toList(),
      onChanged: (val) => safeSetState(() => _model.choiceChipsValues = val),
      selectedChipStyle: ChipStyle(
        backgroundColor: MyFlutterTheme.of(context).primary,
        textStyle: MyFlutterTheme.of(context).bodyMedium.override(
              fontFamily: 'Noto Serif',
              color: MyFlutterTheme.of(context).secondaryBackground,
              letterSpacing: 0.0,
            ),
        iconColor: MyFlutterTheme.of(context).primaryText,
        iconSize: 18.0,
        elevation: 4.0,
        borderRadius: BorderRadius.circular(16.0),
      ),
      unselectedChipStyle: ChipStyle(
        backgroundColor: MyFlutterTheme.of(context).primaryBackground,
        textStyle: MyFlutterTheme.of(context).bodyMedium.override(
              fontFamily: 'Noto Serif',
              color: MyFlutterTheme.of(context).secondaryText,
              letterSpacing: 0.0,
            ),
        iconColor: MyFlutterTheme.of(context).primaryBackground,
        iconSize: 18.0,
        elevation: 0.0,
        borderRadius: BorderRadius.circular(16.0),
      ),
      chipSpacing: 12.0,
      rowSpacing: 12.0,
      multiselect: true,
      initialized: _model.choiceChipsValues != null,
      alignment: WrapAlignment.start,
      controller: _model.choiceChipsValueController ??=
          FormFieldController<List<String>>(
        [],
      ),
      wrapped: false,
    );
  }
}
