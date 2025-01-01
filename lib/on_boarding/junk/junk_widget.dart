import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import 'package:flutter/material.dart';
import 'junk_model.dart';
export 'junk_model.dart';

class JunkWidget extends StatefulWidget {
  const JunkWidget({super.key});

  @override
  State<JunkWidget> createState() => _JunkWidgetState();
}

class _JunkWidgetState extends State<JunkWidget> {
  late JunkModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JunkModel());

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
      ),
    );
  }
}
