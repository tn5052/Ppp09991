import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/my_flutter/my_flutter_animations.dart';
import '/my_flutter/my_flutter_choice_chips.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/form_field_controller.dart';
import 'dart:math' as math;
import 'package:badges/badges.dart' as badges;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:text_search/text_search.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (valueOrDefault(currentUserDocument?.status, '') == 'ban') {
        context.goNamed(
          'ban_Page',
          extra: <String, dynamic>{
            kTransitionInfoKey: const TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      }
    });

    _model.tfSimpleSearchTextController ??= TextEditingController();
    _model.tfSimpleSearchFocusNode ??= FocusNode();

    animationsMap.addAll({
      'iconOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ShakeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 2000.0.ms,
            hz: 10,
            offset: const Offset(0.0, 0.0),
            rotation: 0.087,
          ),
        ],
      ),
      'iconOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 250.0.ms,
            begin: 0.0,
            end: -0.25,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.0, -1.0),
                    child: Container(
                      width: double.infinity,
                      height: 65.0,
                      decoration: BoxDecoration(
                        color: MyFlutterTheme.of(context).primary,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                30.0, 0.0, 30.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(),
                                  child: FutureBuilder<int>(
                                    future: queryInAppNotificationsRecordCount(
                                      queryBuilder:
                                          (inAppNotificationsRecord) =>
                                              inAppNotificationsRecord.where(
                                        'mentor',
                                        isEqualTo: currentUserReference,
                                      ),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: SpinKitRipple(
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              size: 50.0,
                                            ),
                                          ),
                                        );
                                      }
                                      int badgeCount = snapshot.data!;

                                      return badges.Badge(
                                        badgeContent: Text(
                                          valueOrDefault<String>(
                                            formatNumber(
                                              badgeCount,
                                              formatType: FormatType.compact,
                                            ),
                                            '0',
                                          ),
                                          style: MyFlutterTheme.of(context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                color: Colors.white,
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        showBadge: true,
                                        shape: badges.BadgeShape.circle,
                                        badgeColor:
                                            MyFlutterTheme.of(context).error,
                                        elevation: 4.0,
                                        padding: const EdgeInsets.all(5.0),
                                        position: badges.BadgePosition.topEnd(),
                                        animationType:
                                            badges.BadgeAnimationType.scale,
                                        toAnimate: true,
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.showNotification =
                                                !_model.showNotification;
                                            safeSetState(() {});
                                            if (animationsMap[
                                                    'iconOnActionTriggerAnimation1'] !=
                                                null) {
                                              await animationsMap[
                                                      'iconOnActionTriggerAnimation1']!
                                                  .controller
                                                  .forward(from: 0.0);
                                            }
                                          },
                                          child: Icon(
                                            Icons.notifications_rounded,
                                            color: MyFlutterTheme.of(context)
                                                .secondaryBackground,
                                            size: 30.0,
                                          ),
                                        ).animateOnActionTrigger(
                                          animationsMap[
                                              'iconOnActionTriggerAnimation1']!,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            28.0, 0.0, 20.0, 0.0),
                                    child: TextFormField(
                                      controller:
                                          _model.tfSimpleSearchTextController,
                                      focusNode: _model.tfSimpleSearchFocusNode,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.tfSimpleSearchTextController',
                                        const Duration(milliseconds: 2000),
                                        () async {
                                          await queryEventsRecordOnce()
                                              .then(
                                                (records) => _model
                                                        .simpleSearchResults1 =
                                                    TextSearch(
                                                  records
                                                      .map(
                                                        (record) =>
                                                            TextSearchItem
                                                                .fromTerms(
                                                                    record, [
                                                          record.name,
                                                          record.description,
                                                          record.summery,
                                                          record.managerName,
                                                          record.displayName,
                                                          record
                                                              .combinedCategories
                                                        ]),
                                                      )
                                                      .toList(),
                                                )
                                                        .search(valueOrDefault<
                                                            String>(
                                                          '${_model.choiceChipsValue}${valueOrDefault<String>(
                                                            _model
                                                                .tfSimpleSearchTextController
                                                                .text,
                                                            '*',
                                                          )}',
                                                          '*',
                                                        ))
                                                        .map((r) => r.object)
                                                        .toList(),
                                              )
                                              .onError((_, __) => _model
                                                  .simpleSearchResults1 = [])
                                              .whenComplete(
                                                  () => safeSetState(() {}));
                                        },
                                      ),
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'search',
                                        labelStyle: MyFlutterTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              color: MyFlutterTheme.of(context)
                                                  .secondaryBackground,
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
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        suffixIcon:
                                            _model.tfSimpleSearchTextController!
                                                    .text.isNotEmpty
                                                ? InkWell(
                                                    onTap: () async {
                                                      _model
                                                          .tfSimpleSearchTextController
                                                          ?.clear();
                                                      await queryEventsRecordOnce()
                                                          .then(
                                                            (records) => _model
                                                                    .simpleSearchResults1 =
                                                                TextSearch(
                                                              records
                                                                  .map(
                                                                    (record) =>
                                                                        TextSearchItem.fromTerms(
                                                                            record,
                                                                            [
                                                                          record
                                                                              .name,
                                                                          record
                                                                              .description,
                                                                          record
                                                                              .summery,
                                                                          record
                                                                              .managerName,
                                                                          record
                                                                              .displayName,
                                                                          record
                                                                              .combinedCategories
                                                                        ]),
                                                                  )
                                                                  .toList(),
                                                            )
                                                                    .search(valueOrDefault<
                                                                        String>(
                                                                      '${_model.choiceChipsValue}${valueOrDefault<String>(
                                                                        _model
                                                                            .tfSimpleSearchTextController
                                                                            .text,
                                                                        '*',
                                                                      )}',
                                                                      '*',
                                                                    ))
                                                                    .map((r) =>
                                                                        r.object)
                                                                    .toList(),
                                                          )
                                                          .onError((_, __) =>
                                                              _model.simpleSearchResults1 =
                                                                  [])
                                                          .whenComplete(() =>
                                                              safeSetState(
                                                                  () {}));

                                                      safeSetState(() {});
                                                    },
                                                    child: const Icon(
                                                      Icons.clear,
                                                      size: 22,
                                                    ),
                                                  )
                                                : null,
                                      ),
                                      style: MyFlutterTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            color: MyFlutterTheme.of(context)
                                                .secondaryBackground,
                                            letterSpacing: 0.0,
                                          ),
                                      textAlign: TextAlign.center,
                                      validator: _model
                                          .tfSimpleSearchTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await queryUsersRecordOnce()
                                        .then(
                                          (records) => _model
                                                  .simpleSearchResults2 =
                                              TextSearch(
                                            records
                                                .map(
                                                  (record) =>
                                                      TextSearchItem.fromTerms(
                                                          record, [
                                                    record.email,
                                                    record.displayName,
                                                    record.about
                                                  ]),
                                                )
                                                .toList(),
                                          )
                                                  .search(_model
                                                      .tfSimpleSearchTextController
                                                      .text)
                                                  .map((r) => r.object)
                                                  .toList(),
                                        )
                                        .onError((_, __) =>
                                            _model.simpleSearchResults2 = [])
                                        .whenComplete(
                                            () => safeSetState(() {}));
                                  },
                                  child: Icon(
                                    Icons.search,
                                    color: MyFlutterTheme.of(context)
                                        .secondaryBackground,
                                    size: 28.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              14.0, 0.0, 0.0, 0.0),
                          child: MyFlutterChoiceChips(
                            options: const [
                              ChipData('All', Icons.train_outlined),
                              ChipData('Tech', Icons.terminal),
                              ChipData('Business', Icons.business_center_sharp),
                              ChipData('Health', Icons.healing),
                              ChipData('Entertainment', Icons.live_tv_rounded),
                              ChipData('Sports', Icons.sports_score)
                            ],
                            onChanged: (val) => safeSetState(() =>
                                _model.choiceChipsValue = val?.firstOrNull),
                            selectedChipStyle: ChipStyle(
                              backgroundColor:
                                  MyFlutterTheme.of(context).primary,
                              textStyle: MyFlutterTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    letterSpacing: 0.0,
                                  ),
                              iconColor:
                                  MyFlutterTheme.of(context).primaryBackground,
                              iconSize: 25.0,
                              elevation: 4.0,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            unselectedChipStyle: ChipStyle(
                              backgroundColor:
                                  MyFlutterTheme.of(context).alternate,
                              textStyle: MyFlutterTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    color: MyFlutterTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                              iconColor:
                                  MyFlutterTheme.of(context).secondaryText,
                              iconSize: 22.0,
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            chipSpacing: 12.0,
                            rowSpacing: 12.0,
                            multiselect: false,
                            alignment: WrapAlignment.start,
                            controller: _model.choiceChipsValueController ??=
                                FormFieldController<List<String>>(
                              [],
                            ),
                            wrapped: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.74,
                    decoration: const BoxDecoration(),
                    child: SingleChildScrollView(
                      primary: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 24.0, 24.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'High Rated Mentors',
                                  style: MyFlutterTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          if (!(_model.simpleSearchResults2.isNotEmpty))
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 4.0, 0.0),
                              child: StreamBuilder<List<UsersRecord>>(
                                stream: FFAppState().mentorsListCache(
                                  requestFn: () => queryUsersRecord(
                                    queryBuilder: (usersRecord) =>
                                        usersRecord.where(
                                      'email',
                                      isNotEqualTo: 'admin@talenties.com' != ''
                                          ? 'admin@talenties.com'
                                          : null,
                                    ),
                                  ),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: SpinKitRipple(
                                          color: MyFlutterTheme.of(context)
                                              .primary,
                                          size: 50.0,
                                        ),
                                      ),
                                    );
                                  }
                                  List<UsersRecord> rowUsersRecordList =
                                      snapshot.data!
                                          .where((u) => u.uid != currentUserUid)
                                          .toList();
                                  if (rowUsersRecordList.isEmpty) {
                                    return Image.asset(
                                      'assets/images/empty_Box_in_girl_hand_animation.gif',
                                    );
                                  }

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(
                                          rowUsersRecordList.length,
                                          (rowIndex) {
                                        final rowUsersRecord =
                                            rowUsersRecordList[rowIndex];
                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10.0, 12.0, 10.0, 12.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                'profile',
                                                queryParameters: {
                                                  'profileDoc': serializeParam(
                                                    rowUsersRecord,
                                                    ParamType.Document,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'profileDoc': rowUsersRecord,
                                                },
                                              );
                                            },
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 1.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Container(
                                                width: 130.0,
                                                height: 172.0,
                                                decoration: BoxDecoration(
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 130.0,
                                                      height: 125.0,
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Stack(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 110.0,
                                                              height: 110.0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  rowUsersRecord
                                                                      .photoUrl,
                                                                  'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0.0, 1.0),
                                                            child: Container(
                                                              width: 55.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Color(
                                                                          0xFFFFD830),
                                                                      size:
                                                                          18.0,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        rowUsersRecord
                                                                            .rating
                                                                            .toString(),
                                                                        '0',
                                                                      ),
                                                                      style: MyFlutterTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Noto Serif',
                                                                            color:
                                                                                MyFlutterTheme.of(context).secondaryBackground,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    AutoSizeText(
                                                      rowUsersRecord
                                                          .displayName,
                                                      maxLines: 2,
                                                      style: MyFlutterTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ],
                                                ),
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
                          if (_model.simpleSearchResults2.isNotEmpty)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 4.0, 0.0),
                              child: Builder(
                                builder: (context) {
                                  final usersListSearch = _model
                                      .simpleSearchResults2
                                      .where((e) =>
                                          e.email != 'admin@talenties.com')
                                      .toList();
                                  if (usersListSearch.isEmpty) {
                                    return Image.asset(
                                      'assets/images/empty_Box_in_girl_hand_animation.gif',
                                    );
                                  }

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children:
                                          List.generate(usersListSearch.length,
                                              (usersListSearchIndex) {
                                        final usersListSearchItem =
                                            usersListSearch[
                                                usersListSearchIndex];
                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10.0, 12.0, 10.0, 12.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                'profile',
                                                queryParameters: {
                                                  'profileDoc': serializeParam(
                                                    usersListSearchItem,
                                                    ParamType.Document,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'profileDoc':
                                                      usersListSearchItem,
                                                  kTransitionInfoKey:
                                                      const TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType
                                                            .scale,
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    duration: Duration(
                                                        milliseconds: 700),
                                                  ),
                                                },
                                              );
                                            },
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 1.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Container(
                                                width: 130.0,
                                                height: 172.0,
                                                decoration: BoxDecoration(
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 130.0,
                                                      height: 125.0,
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Stack(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 110.0,
                                                              height: 110.0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  usersListSearchItem
                                                                      .photoUrl,
                                                                  'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0.0, 1.0),
                                                            child: Container(
                                                              width: 55.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  const Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Color(
                                                                          0xFFFFD830),
                                                                      size:
                                                                          18.0,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        usersListSearchItem
                                                                            .rating
                                                                            .toString(),
                                                                        '0',
                                                                      ),
                                                                      style: MyFlutterTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Noto Serif',
                                                                            color:
                                                                                MyFlutterTheme.of(context).secondaryBackground,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    AutoSizeText(
                                                      valueOrDefault<String>(
                                                        usersListSearchItem
                                                            .displayName,
                                                        'Mentor',
                                                      ),
                                                      maxLines: 2,
                                                      style: MyFlutterTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: MyFlutterTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ],
                                                ),
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
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 12.0, 24.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Up Coming Events',
                                  style: MyFlutterTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          if (_model.simpleSearchResults1.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Builder(
                                builder: (context) {
                                  final eventsList = _model.simpleSearchResults1
                                      .sortedList(
                                          keyOf: (e) => e.timeEnd!, desc: true)
                                      .toList();
                                  if (eventsList.isEmpty) {
                                    return Image.asset(
                                      'assets/images/empty_Box_in_girl_hand_animation.gif',
                                    );
                                  }

                                  return ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: eventsList.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 10.0),
                                    itemBuilder: (context, eventsListIndex) {
                                      final eventsListItem =
                                          eventsList[eventsListIndex];
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            'event',
                                            queryParameters: {
                                              'docEvent': serializeParam(
                                                eventsListItem,
                                                ParamType.Document,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              'docEvent': eventsListItem,
                                              kTransitionInfoKey:
                                                  const TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.scale,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                duration:
                                                    Duration(milliseconds: 700),
                                              ),
                                            },
                                          );
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 1.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            height: 120.0,
                                            decoration: BoxDecoration(
                                              color: MyFlutterTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      12.0, 0.0, 12.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    child: Image.network(
                                                      valueOrDefault<String>(
                                                        eventsListItem
                                                            .media.first,
                                                        'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Radio%203D.png?alt=media&token=6e4dd552-7dac-4ab3-9f10-35a261670d53',
                                                      ),
                                                      width: 80.0,
                                                      height: 110.0,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Image.asset(
                                                        'assets/images/error_image.PNG',
                                                        width: 80.0,
                                                        height: 110.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    eventsListItem
                                                                        .name,
                                                                    'Event Name',
                                                                  ),
                                                                  style: MyFlutterTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .override(
                                                                        fontFamily:
                                                                            'Noto Serif',
                                                                        color: MyFlutterTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                ),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .star_outline_rounded,
                                                                color: MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 16.0,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        2.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    eventsListItem
                                                                        .rating
                                                                        .toString(),
                                                                    '0',
                                                                  ),
                                                                  style: MyFlutterTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Noto Serif',
                                                                        color: MyFlutterTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              eventsListItem
                                                                  .summery,
                                                              'Event Description',
                                                            ),
                                                            maxLines: 3,
                                                            style: MyFlutterTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Noto Serif',
                                                                  color: MyFlutterTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on_outlined,
                                                                color: MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 16.0,
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      eventsListItem
                                                                          .address,
                                                                      'Location',
                                                                    ),
                                                                    style: MyFlutterTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Noto Serif',
                                                                          color:
                                                                              MyFlutterTheme.of(context).primary,
                                                                          fontSize:
                                                                              9.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              RichText(
                                                                textScaler: MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: valueOrDefault<
                                                                          String>(
                                                                        eventsListItem
                                                                            .currency,
                                                                        'Pkr',
                                                                      ),
                                                                      style: MyFlutterTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'Noto Serif',
                                                                            color:
                                                                                MyFlutterTheme.of(context).primary,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    const TextSpan(
                                                                      text:
                                                                          '  ',
                                                                      style:
                                                                          TextStyle(),
                                                                    ),
                                                                    TextSpan(
                                                                      text: valueOrDefault<
                                                                          String>(
                                                                        formatNumber(
                                                                          eventsListItem
                                                                              .price,
                                                                          formatType:
                                                                              FormatType.compact,
                                                                        ),
                                                                        '0',
                                                                      ),
                                                                      style:
                                                                          const TextStyle(),
                                                                    )
                                                                  ],
                                                                  style: MyFlutterTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Noto Serif',
                                                                        color: MyFlutterTheme.of(context)
                                                                            .primary,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          if (!(_model.simpleSearchResults1.isNotEmpty))
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: StreamBuilder<List<EventsRecord>>(
                                stream: queryEventsRecord(
                                  queryBuilder: (eventsRecord) => eventsRecord
                                      .orderBy('time_end', descending: true),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: SpinKitRipple(
                                          color: MyFlutterTheme.of(context)
                                              .primary,
                                          size: 50.0,
                                        ),
                                      ),
                                    );
                                  }
                                  List<EventsRecord> listViewEventsRecordList =
                                      snapshot.data!;

                                  return ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: listViewEventsRecordList.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 10.0),
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewEventsRecord =
                                          listViewEventsRecordList[
                                              listViewIndex];
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            'event',
                                            queryParameters: {
                                              'docEvent': serializeParam(
                                                listViewEventsRecord,
                                                ParamType.Document,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              'docEvent': listViewEventsRecord,
                                            },
                                          );
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 1.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            height: 120.0,
                                            decoration: BoxDecoration(
                                              color: MyFlutterTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      12.0, 0.0, 12.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    child: Image.network(
                                                      valueOrDefault<String>(
                                                        listViewEventsRecord
                                                            .media.first,
                                                        'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Radio%203D.png?alt=media&token=6e4dd552-7dac-4ab3-9f10-35a261670d53',
                                                      ),
                                                      width: 80.0,
                                                      height: 110.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    listViewEventsRecord
                                                                        .name,
                                                                    'Event Name',
                                                                  ),
                                                                  style: MyFlutterTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Noto Serif',
                                                                        color: MyFlutterTheme.of(context)
                                                                            .primaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .star_outline_rounded,
                                                                color: MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 16.0,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        2.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    listViewEventsRecord
                                                                        .rating
                                                                        .toString(),
                                                                    '5',
                                                                  ),
                                                                  style: MyFlutterTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Noto Serif',
                                                                        color: MyFlutterTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              listViewEventsRecord
                                                                  .description,
                                                              'Event Description ',
                                                            ),
                                                            maxLines: 3,
                                                            style: MyFlutterTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Noto Serif',
                                                                  color: MyFlutterTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on_outlined,
                                                                color: MyFlutterTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 16.0,
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      listViewEventsRecord
                                                                          .address,
                                                                      'Address',
                                                                    ),
                                                                    style: MyFlutterTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Noto Serif',
                                                                          color:
                                                                              MyFlutterTheme.of(context).primary,
                                                                          fontSize:
                                                                              9.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              RichText(
                                                                textScaler: MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: valueOrDefault<
                                                                          String>(
                                                                        listViewEventsRecord
                                                                            .currency,
                                                                        'Pkr',
                                                                      ),
                                                                      style: MyFlutterTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'Noto Serif',
                                                                            color:
                                                                                MyFlutterTheme.of(context).primary,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    const TextSpan(
                                                                      text:
                                                                          '  ',
                                                                      style:
                                                                          TextStyle(),
                                                                    ),
                                                                    TextSpan(
                                                                      text: valueOrDefault<
                                                                          String>(
                                                                        formatNumber(
                                                                          listViewEventsRecord
                                                                              .price,
                                                                          formatType:
                                                                              FormatType.compact,
                                                                        ),
                                                                        '00',
                                                                      ),
                                                                      style:
                                                                          const TextStyle(),
                                                                    )
                                                                  ],
                                                                  style: MyFlutterTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Noto Serif',
                                                                        color: MyFlutterTheme.of(context)
                                                                            .primary,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          Container(
                            height: 150.0,
                            decoration: const BoxDecoration(
                              color: Color(0x00FFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: Container(
                  width: double.infinity,
                  height: 65.0,
                  decoration: BoxDecoration(
                    color: MyFlutterTheme.of(context).secondaryBackground,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 5.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          decoration: const BoxDecoration(),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'Feed',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.leftToRight,
                                  ),
                                },
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.play_circle,
                                  color: Color(0xAB545353),
                                  size: 26.0,
                                ),
                                Text(
                                  'Feed',
                                  style: MyFlutterTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.explore,
                                color: MyFlutterTheme.of(context).primary,
                                size: 26.0,
                              ),
                              Text(
                                'Explore',
                                style: MyFlutterTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Noto Serif',
                                      color: MyFlutterTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.15,
                          decoration: const BoxDecoration(),
                          child: const Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.settings_outlined,
                                color: Color(0x00545353),
                                size: 30.0,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          decoration: const BoxDecoration(),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'Bookings',
                                queryParameters: {
                                  'byNav': serializeParam(
                                    '   Events   ',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(
                                  Icons.memory_outlined,
                                  color: Color(0xAB545353),
                                  size: 26.0,
                                ),
                                AutoSizeText(
                                  'Bookings',
                                  style: MyFlutterTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: const Color(0xAB545353),
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          decoration: const BoxDecoration(),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'myProfile',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.bottomToTop,
                                  ),
                                },
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                AuthUserStreamWidget(
                                  builder: (context) => Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.08,
                                    height:
                                        MediaQuery.sizeOf(context).width * 0.08,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      fadeInDuration:
                                          const Duration(milliseconds: 500),
                                      fadeOutDuration:
                                          const Duration(milliseconds: 500),
                                      imageUrl: valueOrDefault<String>(
                                        currentUserPhoto,
                                        'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                      ),
                                      fit: BoxFit.cover,
                                      errorWidget:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        'assets/images/error_image.PNG',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'me',
                                  style: MyFlutterTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        color: Colors.transparent,
                        elevation: 5.0,
                        shape: const CircleBorder(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyFlutterTheme.of(context).primary,
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.postNewbottomPopup =
                                  !_model.postNewbottomPopup;
                              safeSetState(() {});
                              if (animationsMap[
                                      'iconOnActionTriggerAnimation2'] !=
                                  null) {
                                await animationsMap[
                                        'iconOnActionTriggerAnimation2']!
                                    .controller
                                    .forward(from: 0.0);
                              }
                            },
                            child: Icon(
                              Icons.add,
                              color: MyFlutterTheme.of(context)
                                  .secondaryBackground,
                              size: 60.0,
                            ),
                          ).animateOnActionTrigger(
                            animationsMap['iconOnActionTriggerAnimation2']!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (valueOrDefault<bool>(
                _model.postNewbottomPopup != false,
                true,
              ))
                Align(
                  alignment: const AlignmentDirectional(-0.01, 0.7),
                  child: Transform.rotate(
                    angle: 45.0 * (math.pi / 180),
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFF394147),
                      ),
                    ),
                  ),
                ),
              if (valueOrDefault<bool>(
                _model.postNewbottomPopup != false,
                true,
              ))
                Align(
                  alignment: const AlignmentDirectional(-0.01, 0.62),
                  child: Container(
                    width: 170.0,
                    height: 130.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF394147),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'spotlightAdd',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.bottomToTop,
                                  ),
                                },
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Post Spotlight',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryBackground,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Icon(
                                  Icons.video_camera_back_outlined,
                                  color: MyFlutterTheme.of(context)
                                      .primaryBackground,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'createMeetingsSlots',
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.bottomToTop,
                                  ),
                                },
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Post Meeting',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryBackground,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Icon(
                                  Icons.play_circle_outline,
                                  color: MyFlutterTheme.of(context)
                                      .primaryBackground,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.postNewbottomPopup =
                                  !_model.postNewbottomPopup;
                              safeSetState(() {});

                              context.pushNamed('postNewEvent');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Post Event',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryBackground,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: MyFlutterTheme.of(context)
                                      .primaryBackground,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (valueOrDefault<bool>(
                _model.showNotification == false,
                true,
              ))
                Align(
                  alignment: const AlignmentDirectional(-0.2, -0.8),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22.0),
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.sizeOf(context).width * 0.7,
                          minHeight: MediaQuery.sizeOf(context).height * 0.15,
                          maxWidth: MediaQuery.sizeOf(context).width * 0.7,
                          maxHeight: MediaQuery.sizeOf(context).height * 0.5,
                        ),
                        decoration: BoxDecoration(
                          color: MyFlutterTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Notifications',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 6.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height: 1.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyFlutterTheme.of(context)
                                          .secondaryText,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                              StreamBuilder<List<InAppNotificationsRecord>>(
                                stream: queryInAppNotificationsRecord(
                                  queryBuilder: (inAppNotificationsRecord) =>
                                      inAppNotificationsRecord
                                          .where(
                                            'mentor',
                                            isEqualTo: currentUserReference,
                                          )
                                          .orderBy('dateTime',
                                              descending: true),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: SpinKitRipple(
                                          color: MyFlutterTheme.of(context)
                                              .primary,
                                          size: 50.0,
                                        ),
                                      ),
                                    );
                                  }
                                  List<InAppNotificationsRecord>
                                      listViewInAppNotificationsRecordList =
                                      snapshot.data!;
                                  if (listViewInAppNotificationsRecordList
                                      .isEmpty) {
                                    return Center(
                                      child: Image.asset(
                                        'assets/images/empty_Box_in_girl_hand_animation.gif',
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.2,
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        listViewInAppNotificationsRecordList
                                            .length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewInAppNotificationsRecord =
                                          listViewInAppNotificationsRecordList[
                                              listViewIndex];
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.menteeDoc =
                                              await queryUsersRecordOnce(
                                            queryBuilder: (usersRecord) =>
                                                usersRecord.where(
                                              'uid',
                                              isEqualTo:
                                                  listViewInAppNotificationsRecord
                                                      .mentee?.id,
                                            ),
                                            singleRecord: true,
                                          ).then((s) => s.firstOrNull);

                                          context.pushNamed(
                                            'profile',
                                            queryParameters: {
                                              'profileDoc': serializeParam(
                                                _model.menteeDoc,
                                                ParamType.Document,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              'profileDoc': _model.menteeDoc,
                                              kTransitionInfoKey:
                                                  const TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.scale,
                                                alignment:
                                                    Alignment.bottomCenter,
                                              ),
                                            },
                                          );

                                          safeSetState(() {});
                                        },
                                        child: Slidable(
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            extentRatio: 0.25,
                                            children: [
                                              SlidableAction(
                                                label: 'Del',
                                                backgroundColor:
                                                    MyFlutterTheme.of(context)
                                                        .error,
                                                icon: Icons
                                                    .delete_outline_rounded,
                                                onPressed: (_) async {
                                                  await listViewInAppNotificationsRecord
                                                      .reference
                                                      .delete();
                                                },
                                              ),
                                            ],
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: ListTile(
                                              title: Text(
                                                '${valueOrDefault<String>(
                                                  dateTimeFormat(
                                                      "jm",
                                                      listViewInAppNotificationsRecord
                                                          .meetingTime),
                                                  '5:59 PM',
                                                )}  -  ${valueOrDefault<String>(
                                                  dateTimeFormat(
                                                      "yMMMd",
                                                      listViewInAppNotificationsRecord
                                                          .meetingTime),
                                                  'Sep 24, 2024',
                                                )}',
                                                style: MyFlutterTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      color: MyFlutterTheme.of(
                                                              context)
                                                          .primary,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                              subtitle: Text(
                                                valueOrDefault<String>(
                                                  listViewInAppNotificationsRecord
                                                      .info,
                                                  'Saad booked meeting.',
                                                ),
                                                style:
                                                    MyFlutterTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                              dense: true,
                                            ),
                                          ),
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
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
