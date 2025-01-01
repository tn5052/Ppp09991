import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'filter_button_model.dart';
export 'filter_button_model.dart';

class FilterButtonWidget extends StatefulWidget {
  /// filter the search button
  const FilterButtonWidget({super.key});

  @override
  State<FilterButtonWidget> createState() => _FilterButtonWidgetState();
}

class _FilterButtonWidgetState extends State<FilterButtonWidget> {
  late FilterButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
      child: Material(
        color: Colors.transparent,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0x17FFFFFF),
            borderRadius: BorderRadius.circular(12.0),
            shape: BoxShape.rectangle,
          ),
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0x52FFFFFF),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        5.0, 5.0, 5.0, 5.0),
                    child: FaIcon(
                      FontAwesomeIcons.slidersH,
                      color: MyFlutterTheme.of(context).secondaryBackground,
                      size: 12.0,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(3.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Filters',
                    style: MyFlutterTheme.of(context).bodyMedium.override(
                          fontFamily: 'Noto Serif',
                          color: MyFlutterTheme.of(context).secondaryBackground,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
