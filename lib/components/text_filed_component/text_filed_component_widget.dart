import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import 'package:flutter/material.dart';
import 'text_filed_component_model.dart';
export 'text_filed_component_model.dart';

class TextFiledComponentWidget extends StatefulWidget {
  const TextFiledComponentWidget({
    super.key,
    String? linkText,
    this.linkEditParameter,
  }) : linkText = linkText ?? 'https://www.Jaaneabubaker.com';

  final String linkText;
  final bool? linkEditParameter;

  @override
  State<TextFiledComponentWidget> createState() =>
      _TextFiledComponentWidgetState();
}

class _TextFiledComponentWidgetState extends State<TextFiledComponentWidget> {
  late TextFiledComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TextFiledComponentModel());

    _model.tFLinkTextTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      widget.linkText,
      'https://www.Jaaneabubaker.com',
    ));
    _model.tFLinkTextFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.95,
      decoration: BoxDecoration(
        color: MyFlutterTheme.of(context).secondaryBackground,
      ),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.95,
        child: TextFormField(
          controller: _model.tFLinkTextTextController,
          focusNode: _model.tFLinkTextFocusNode,
          autofocus: false,
          readOnly: widget.linkEditParameter!,
          obscureText: false,
          decoration: InputDecoration(
            labelText: 'link',
            labelStyle: MyFlutterTheme.of(context).labelMedium.override(
                  fontFamily: 'Noto Serif',
                  letterSpacing: 0.0,
                ),
            hintStyle: MyFlutterTheme.of(context).labelMedium.override(
                  fontFamily: 'Noto Serif',
                  letterSpacing: 0.0,
                ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyFlutterTheme.of(context).primary,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyFlutterTheme.of(context).secondaryText,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyFlutterTheme.of(context).error,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyFlutterTheme.of(context).error,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          style: MyFlutterTheme.of(context).labelLarge.override(
                fontFamily: 'Noto Serif',
                color: MyFlutterTheme.of(context).primary,
                letterSpacing: 0.0,
              ),
          validator:
              _model.tFLinkTextTextControllerValidator.asValidator(context),
        ),
      ),
    );
  }
}
