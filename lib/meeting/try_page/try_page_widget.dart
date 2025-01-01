import '/components/text_filed_component/text_filed_component_widget.dart';
import '/my_flutter/my_flutter_choice_chips.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/form_field_controller.dart';
import '/my_flutter/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'try_page_model.dart';
export 'try_page_model.dart';

class TryPageWidget extends StatefulWidget {
  const TryPageWidget({super.key});

  @override
  State<TryPageWidget> createState() => _TryPageWidgetState();
}

class _TryPageWidgetState extends State<TryPageWidget> {
  late TryPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TryPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: MyFlutterTheme.of(context).primaryBackground,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: 120.0,
                height: 120.0,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://picsum.photos/seed/799/600',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.69, -0.7),
              child: Container(
                width: 63.0,
                decoration: BoxDecoration(
                  color: MyFlutterTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.star,
                      color: MyFlutterTheme.of(context).tertiary,
                      size: 24.0,
                    ),
                    Text(
                      '5.0',
                      style: MyFlutterTheme.of(context).bodyMedium.override(
                            fontFamily: 'Noto Serif',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            wrapWithModel(
              model: _model.textFiledComponentModel,
              updateCallback: () => safeSetState(() {}),
              child: const TextFiledComponentWidget(),
            ),
            MyFlutterChoiceChips(
              options: functions
                  .newCustomFunction(getCurrentTimestamp, getCurrentTimestamp)!
                  .map((label) => ChipData(label))
                  .toList(),
              onChanged: (val) =>
                  safeSetState(() => _model.choiceChipsValues = val),
              selectedChipStyle: ChipStyle(
                backgroundColor: MyFlutterTheme.of(context).secondary,
                textStyle: MyFlutterTheme.of(context).bodyMedium.override(
                      fontFamily: 'Noto Serif',
                      color: MyFlutterTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                    ),
                iconColor: MyFlutterTheme.of(context).primaryText,
                iconSize: 18.0,
                elevation: 4.0,
                borderRadius: BorderRadius.circular(16.0),
              ),
              unselectedChipStyle: ChipStyle(
                backgroundColor: MyFlutterTheme.of(context).alternate,
                textStyle: MyFlutterTheme.of(context).bodyMedium.override(
                      fontFamily: 'Noto Serif',
                      color: MyFlutterTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                    ),
                iconColor: MyFlutterTheme.of(context).secondaryText,
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
              wrapped: true,
            ),
          ],
        ),
      ),
    );
  }
}
