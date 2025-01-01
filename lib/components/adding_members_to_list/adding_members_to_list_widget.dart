import '/backend/backend.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'adding_members_to_list_model.dart';
export 'adding_members_to_list_model.dart';

class AddingMembersToListWidget extends StatefulWidget {
  const AddingMembersToListWidget({super.key});

  @override
  State<AddingMembersToListWidget> createState() =>
      _AddingMembersToListWidgetState();
}

class _AddingMembersToListWidgetState extends State<AddingMembersToListWidget> {
  late AddingMembersToListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddingMembersToListModel());

    _model.textController ??= TextEditingController(text: 'thisnis');
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
        color: Color(0xAB8A8A8A),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0.0, 0.0),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.85,
          height: MediaQuery.sizeOf(context).height * 0.7,
          decoration: BoxDecoration(
            color: MyFlutterTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        8.0, 6.0, 0.0, 0.0),
                    child: RichText(
                      textScaler: MediaQuery.of(context).textScaler,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '',
                            style:
                                MyFlutterTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Noto Serif',
                                      letterSpacing: 0.0,
                                    ),
                          ),
                          const TextSpan(
                            text: '  Speakers',
                            style: TextStyle(),
                          )
                        ],
                        style: MyFlutterTheme.of(context).bodyMedium.override(
                              fontFamily: 'Noto Serif',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Container(
                    width: 350.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E4EA),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: StreamBuilder<List<UsersRecord>>(
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
                        List<UsersRecord> rowUsersRecordList = snapshot.data!;

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(rowUsersRecordList.length,
                                (rowIndex) {
                              final rowUsersRecord =
                                  rowUsersRecordList[rowIndex];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 1.0,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Container(
                                    width: 80.0,
                                    height: 90.0,
                                    decoration: BoxDecoration(
                                      color: MyFlutterTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 80.0,
                                          height: 90.0,
                                          decoration: BoxDecoration(
                                            color: MyFlutterTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0),
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  width: 45.0,
                                                  height: 45.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    valueOrDefault<String>(
                                                      rowUsersRecord.photoUrl,
                                                      'https://firebasestorage.googleapis.com/v0/b/jaane-event-1.appspot.com/o/jaany.jpg?alt=media&token=8f3402b0-3afe-4ae4-81c1-6682bfa5f9ee',
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              AutoSizeText(
                                                rowUsersRecord.displayName,
                                                maxLines: 2,
                                                style:
                                                    MyFlutterTheme.of(context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              1.1, -1.2),
                                          child: Icon(
                                            Icons.cancel,
                                            color: MyFlutterTheme.of(context)
                                                .error,
                                            size: 24.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.search,
                        color: MyFlutterTheme.of(context).secondaryText,
                        size: 28.0,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 0.0, 0.0),
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'search',
                              labelStyle:
                                  MyFlutterTheme.of(context).bodySmall.override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                              hintStyle: MyFlutterTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    color: MyFlutterTheme.of(context)
                                        .secondaryBackground,
                                    letterSpacing: 0.0,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyFlutterTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyFlutterTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyFlutterTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: MyFlutterTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            style: MyFlutterTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Noto Serif',
                                  color: MyFlutterTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                ),
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 0.0, 0.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xAD57636C),
                              borderRadius: BorderRadius.circular(12.0),
                              shape: BoxShape.rectangle,
                            ),
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5.0, 5.0, 5.0, 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0x52FFFFFF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5.0, 5.0, 5.0, 5.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.slidersH,
                                        color: MyFlutterTheme.of(context)
                                            .secondaryBackground,
                                        size: 12.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            3.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Filters',
                                      style: MyFlutterTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            color: MyFlutterTheme.of(context)
                                                .secondaryBackground,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                          color: MyFlutterTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'https://picsum.photos/seed/726/600',
                                width: 80.0,
                                height: 90.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8.0, 8.0, 0.0, 0.0),
                                  child: Text(
                                    'Hello World',
                                    style: MyFlutterTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
