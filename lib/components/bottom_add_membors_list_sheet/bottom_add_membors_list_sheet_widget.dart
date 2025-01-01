import '/backend/backend.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'bottom_add_membors_list_sheet_model.dart';
export 'bottom_add_membors_list_sheet_model.dart';

class BottomAddMemborsListSheetWidget extends StatefulWidget {
  const BottomAddMemborsListSheetWidget({super.key});

  @override
  State<BottomAddMemborsListSheetWidget> createState() =>
      _BottomAddMemborsListSheetWidgetState();
}

class _BottomAddMemborsListSheetWidgetState
    extends State<BottomAddMemborsListSheetWidget> {
  late BottomAddMemborsListSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomAddMemborsListSheetModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0x52908787),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0.0, 1.0),
        child: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.8,
          decoration: BoxDecoration(
            color: MyFlutterTheme.of(context).secondaryBackground,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 6.0, 20.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  width: 60.0,
                  child: Divider(
                    thickness: 3.0,
                    color: Color(0x9457636C),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: const Color(0x7E394147),
                        width: 1.8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Search',
                                labelStyle: MyFlutterTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Noto Serif',
                                      letterSpacing: 0.0,
                                    ),
                                hintStyle: MyFlutterTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Noto Serif',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              style: MyFlutterTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    color:
                                        MyFlutterTheme.of(context).primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FaIcon(
                            FontAwesomeIcons.search,
                            color: MyFlutterTheme.of(context).primary,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder<List<UsersRecord>>(
                  stream: queryUsersRecord(),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: SpinKitRipple(
                            color: MyFlutterTheme.of(context).primary,
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                    List<UsersRecord> listViewUsersRecordList = snapshot.data!;

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewUsersRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewUsersRecord =
                            listViewUsersRecordList[listViewIndex];
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 55.0,
                                    height: 55.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      listViewUsersRecord.photoUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listViewUsersRecord.displayName,
                                          style: MyFlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                          child: Text(
                                            listViewUsersRecord.email,
                                            style: MyFlutterTheme.of(context)
                                                .labelSmall
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Theme(
                                data: ThemeData(
                                  checkboxTheme: const CheckboxThemeData(
                                    visualDensity: VisualDensity.standard,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    shape: CircleBorder(),
                                  ),
                                  unselectedWidgetColor:
                                      MyFlutterTheme.of(context).secondaryText,
                                ),
                                child: Checkbox(
                                  value: _model.checkboxValueMap[
                                      listViewUsersRecord] ??= false,
                                  onChanged: (newValue) async {
                                    safeSetState(() => _model.checkboxValueMap[
                                        listViewUsersRecord] = newValue!);
                                  },
                                  side: BorderSide(
                                    width: 2,
                                    color: MyFlutterTheme.of(context)
                                        .secondaryText,
                                  ),
                                  activeColor:
                                      MyFlutterTheme.of(context).primary,
                                  checkColor: MyFlutterTheme.of(context).info,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
