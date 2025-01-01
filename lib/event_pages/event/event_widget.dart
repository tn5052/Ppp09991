import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/stripe/payment_manager.dart';
import '/components/report_widget.dart';
import '/my_flutter/my_flutter_animations.dart';
import '/my_flutter/my_flutter_icon_button.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import '/my_flutter/my_flutter_widgets.dart';
import '/my_flutter/custom_functions.dart' as functions;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'event_model.dart';
export 'event_model.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({
    super.key,
    this.docEvent,
  });

  final EventsRecord? docEvent;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget>
    with TickerProviderStateMixin {
  late EventModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.bBuyTicket = false;
      safeSetState(() {});
    });

    _model.switchValue =
        widget.docEvent!.attendees.contains(currentUserReference);
    _model.tfEventFeedbackTextController ??= TextEditingController();
    _model.tfEventFeedbackFocusNode ??= FocusNode();

    animationsMap.addAll({
      'iconButtonOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 2000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

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
        backgroundColor: MyFlutterTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Builder(
                            builder: (context) {
                              final imagesEven = widget.docEvent?.media
                                      .map((e) => e)
                                      .toList()
                                      .toList() ??
                                  [];

                              return SizedBox(
                                width: double.infinity,
                                height: 250.0,
                                child: Stack(
                                  children: [
                                    PageView.builder(
                                      controller: _model.pageViewController ??=
                                          PageController(
                                              initialPage: max(
                                                  0,
                                                  min(0,
                                                      imagesEven.length - 1))),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: imagesEven.length,
                                      itemBuilder: (context, imagesEvenIndex) {
                                        final imagesEvenItem =
                                            imagesEven[imagesEvenIndex];
                                        return Image.network(
                                          imagesEvenItem,
                                          width: double.infinity,
                                          height: 250.0,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/error_image.PNG',
                                            width: double.infinity,
                                            height: 250.0,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.0, 1.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16.0, 0.0, 0.0, 16.0),
                                        child: smooth_page_indicator
                                            .SmoothPageIndicator(
                                          controller: _model
                                                  .pageViewController ??=
                                              PageController(
                                                  initialPage: max(
                                                      0,
                                                      min(
                                                          0,
                                                          imagesEven.length -
                                                              1))),
                                          count: imagesEven.length,
                                          axisDirection: Axis.horizontal,
                                          onDotClicked: (i) async {
                                            await _model.pageViewController!
                                                .animateToPage(
                                              i,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                            safeSetState(() {});
                                          },
                                          effect: smooth_page_indicator
                                              .ExpandingDotsEffect(
                                            expansionFactor: 3.0,
                                            spacing: 8.0,
                                            radius: 16.0,
                                            dotWidth: 10.0,
                                            dotHeight: 8.0,
                                            dotColor: MyFlutterTheme.of(context)
                                                .secondaryText,
                                            activeDotColor:
                                                MyFlutterTheme.of(context)
                                                    .primary,
                                            paintStyle: PaintingStyle.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          5.0, 30.0, 5.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0x00FFFFFF),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            widget.docEvent?.name,
                                            'Event Name',
                                          ),
                                          style: MyFlutterTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0.0, 12.0, 0.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              widget.docEvent?.summery,
                                              'summery',
                                            ),
                                            style: const TextStyle(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  StreamBuilder<UsersRecord>(
                                    stream: UsersRecord.getDocument(
                                        widget.docEvent!.manager!),
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

                                      final columnUsersRecord = snapshot.data!;

                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 65.0,
                                            height: 65.0,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              valueOrDefault<String>(
                                                columnUsersRecord.photoUrl,
                                                'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                            child: SelectionArea(
                                                child: AutoSizeText(
                                              valueOrDefault<String>(
                                                columnUsersRecord.displayName,
                                                'Manager Name',
                                              ),
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    letterSpacing: 0.0,
                                                  ),
                                            )),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 15.0, 20.0, 20.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(
                            'map',
                            queryParameters: {
                              'location': serializeParam(
                                widget.docEvent?.location,
                                ParamType.LatLng,
                              ),
                              'address': serializeParam(
                                valueOrDefault<String>(
                                  widget.docEvent?.address,
                                  'Address',
                                ),
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: MyFlutterTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  widget.docEvent?.address,
                                  'Address',
                                ),
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
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 12.0, 12.0, 12.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  color: MyFlutterTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(10.0),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SelectionArea(
                                          child: Text(
                                        'Start',
                                        style: MyFlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      )),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                            child: Icon(
                                              Icons.calendar_month_outlined,
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              size: 20.0,
                                            ),
                                          ),
                                          SelectionArea(
                                              child: Text(
                                            valueOrDefault<String>(
                                              dateTimeFormat("yMMMd",
                                                  widget.docEvent?.timeStart),
                                              'Start Date',
                                            ),
                                            style: MyFlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                            child: Icon(
                                              Icons.access_time,
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              size: 20.0,
                                            ),
                                          ),
                                          SelectionArea(
                                              child: Text(
                                            valueOrDefault<String>(
                                              dateTimeFormat("jm",
                                                  widget.docEvent?.timeStart),
                                              'Start Time',
                                            ),
                                            style: MyFlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60.0,
                          child: VerticalDivider(
                            thickness: 2.3,
                            color: Color(0x6B57636C),
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 12.0, 12.0, 12.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.4,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  color: MyFlutterTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(10.0),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SelectionArea(
                                          child: Text(
                                        'End',
                                        style: MyFlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      )),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                            child: Icon(
                                              Icons.calendar_month_outlined,
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              size: 20.0,
                                            ),
                                          ),
                                          SelectionArea(
                                              child: Text(
                                            valueOrDefault<String>(
                                              dateTimeFormat("yMMMd",
                                                  widget.docEvent?.timeEnd),
                                              'End Date',
                                            ),
                                            style: MyFlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                            child: Icon(
                                              Icons.access_time,
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              size: 20.0,
                                            ),
                                          ),
                                          SelectionArea(
                                              child: Text(
                                            valueOrDefault<String>(
                                              dateTimeFormat("jm",
                                                  widget.docEvent?.timeEnd),
                                              'End Time',
                                            ),
                                            style: MyFlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 15.0, 0.0, 0.0),
                      child: Container(
                        width: 350.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: MyFlutterTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 8.0, 0.0, 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SelectionArea(
                                      child: Text(
                                    'Speakers',
                                    style: MyFlutterTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          letterSpacing: 0.0,
                                        ),
                                  )),
                                  SelectionArea(
                                      child: Text(
                                    valueOrDefault<String>(
                                      widget.docEvent?.speakers.length
                                          .toString(),
                                      'No. of Speakers',
                                    ),
                                    style: MyFlutterTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          color: MyFlutterTheme.of(context)
                                              .primary,
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                        ),
                                  )),
                                ],
                              ),
                            ),
                            if (widget.docEvent!.speakers.isNotEmpty)
                              Expanded(
                                child: FutureBuilder<List<UsersRecord>>(
                                  future: queryUsersRecordOnce(
                                    queryBuilder: (usersRecord) =>
                                        usersRecord.whereIn(
                                            'uid',
                                            widget.docEvent?.speakers
                                                        .map((e) => e.id)
                                                        .toList() !=
                                                    ''
                                                ? widget.docEvent?.speakers
                                                    .map((e) => e.id)
                                                    .toList()
                                                : null),
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
                                    List<UsersRecord> listViewUsersRecordList =
                                        snapshot.data!;

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: listViewUsersRecordList.length,
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewUsersRecord =
                                            listViewUsersRecordList[
                                                listViewIndex];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
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
                                                    listViewUsersRecord,
                                                    ParamType.Document,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'profileDoc':
                                                      listViewUsersRecord,
                                                },
                                              );
                                            },
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 1.0,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10.0),
                                                  bottomRight:
                                                      Radius.circular(10.0),
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  topRight:
                                                      Radius.circular(10.0),
                                                ),
                                              ),
                                              child: Container(
                                                width: 80.0,
                                                height: 90.0,
                                                decoration: BoxDecoration(
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .secondaryBackground,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10.0),
                                                    bottomRight:
                                                        Radius.circular(10.0),
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Container(
                                                        width: 45.0,
                                                        height: 45.0,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          valueOrDefault<
                                                              String>(
                                                            listViewUsersRecord
                                                                .photoUrl,
                                                            'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    AutoSizeText(
                                                      valueOrDefault<String>(
                                                        listViewUsersRecord
                                                            .displayName,
                                                        'Speaker name',
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      style: MyFlutterTheme.of(
                                                              context)
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
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 15.0, 0.0, 0.0),
                      child: Container(
                        width: 350.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color: MyFlutterTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 8.0, 0.0, 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SelectionArea(
                                      child: Text(
                                    'Attendies',
                                    style: MyFlutterTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          letterSpacing: 0.0,
                                        ),
                                  )),
                                  SelectionArea(
                                      child: Text(
                                    valueOrDefault<String>(
                                      widget.docEvent?.attendees.length
                                          .toString(),
                                      'No. of Speakers',
                                    ),
                                    style: MyFlutterTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          color: MyFlutterTheme.of(context)
                                              .primary,
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                        ),
                                  )),
                                ],
                              ),
                            ),
                            if (widget.docEvent!.attendees.isNotEmpty)
                              Expanded(
                                child: FutureBuilder<List<UsersRecord>>(
                                  future: queryUsersRecordOnce(
                                    queryBuilder: (usersRecord) =>
                                        usersRecord.whereIn(
                                            'uid',
                                            widget.docEvent?.attendees
                                                        .map((e) => e.id)
                                                        .toList() !=
                                                    ''
                                                ? widget.docEvent?.attendees
                                                    .map((e) => e.id)
                                                    .toList()
                                                : null),
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
                                    List<UsersRecord> listViewUsersRecordList =
                                        snapshot.data!;

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: listViewUsersRecordList.length,
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewUsersRecord =
                                            listViewUsersRecordList[
                                                listViewIndex];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
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
                                                    listViewUsersRecord,
                                                    ParamType.Document,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'profileDoc':
                                                      listViewUsersRecord,
                                                },
                                              );
                                            },
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 1.0,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10.0),
                                                  bottomRight:
                                                      Radius.circular(10.0),
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  topRight:
                                                      Radius.circular(10.0),
                                                ),
                                              ),
                                              child: Container(
                                                width: 80.0,
                                                height: 90.0,
                                                decoration: BoxDecoration(
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .secondaryBackground,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10.0),
                                                    bottomRight:
                                                        Radius.circular(10.0),
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Container(
                                                        width: 45.0,
                                                        height: 45.0,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          valueOrDefault<
                                                              String>(
                                                            listViewUsersRecord
                                                                .photoUrl,
                                                            'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    AutoSizeText(
                                                      valueOrDefault<String>(
                                                        listViewUsersRecord
                                                            .displayName,
                                                        'Speaker name',
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      style: MyFlutterTheme.of(
                                                              context)
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
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.docEvent?.peopleJoined
                            .contains(currentUserReference) ??
                        true)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 6.0, 0.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 48.0,
                          decoration: const BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Public My Joining',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 8.0, 0.0),
                                  child: Switch.adaptive(
                                    value: _model.switchValue!,
                                    onChanged: (newValue) async {
                                      safeSetState(
                                          () => _model.switchValue = newValue);
                                      if (newValue) {
                                        await widget.docEvent!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'attendees':
                                                  FieldValue.arrayUnion(
                                                      [currentUserReference]),
                                            },
                                          ),
                                        });
                                      } else {
                                        await widget.docEvent!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'attendees':
                                                  FieldValue.arrayRemove(
                                                      [currentUserReference]),
                                            },
                                          ),
                                        });
                                      }
                                    },
                                    activeColor: MyFlutterTheme.of(context)
                                        .secondaryBackground,
                                    activeTrackColor:
                                        MyFlutterTheme.of(context).primary,
                                    inactiveTrackColor: const Color(0xFFCFD2D6),
                                    inactiveThumbColor:
                                        MyFlutterTheme.of(context)
                                            .secondaryBackground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (widget.docEvent?.manager?.id ==
                        currentUserReference?.id)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 15.0, 0.0, 0.0),
                        child: Container(
                          width: 350.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: MyFlutterTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 8.0, 0.0, 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SelectionArea(
                                        child: Text(
                                      'Joined By',
                                      style: MyFlutterTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            letterSpacing: 0.0,
                                          ),
                                    )),
                                    SelectionArea(
                                        child: Text(
                                      valueOrDefault<String>(
                                        widget.docEvent?.peopleJoined.length
                                            .toString(),
                                        'No. of Speakers',
                                      ),
                                      style: MyFlutterTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                              if (widget.docEvent!.peopleJoined.isNotEmpty)
                                Expanded(
                                  child: FutureBuilder<List<UsersRecord>>(
                                    future: queryUsersRecordOnce(
                                      queryBuilder: (usersRecord) =>
                                          usersRecord.whereIn(
                                              'uid',
                                              widget.docEvent?.peopleJoined
                                                          .map((e) => e.id)
                                                          .toList() !=
                                                      ''
                                                  ? widget
                                                      .docEvent?.peopleJoined
                                                      .map((e) => e.id)
                                                      .toList()
                                                  : null),
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
                                      List<UsersRecord>
                                          listViewUsersRecordList =
                                          snapshot.data!;

                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            listViewUsersRecordList.length,
                                        itemBuilder: (context, listViewIndex) {
                                          final listViewUsersRecord =
                                              listViewUsersRecordList[
                                                  listViewIndex];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  'profile',
                                                  queryParameters: {
                                                    'profileDoc':
                                                        serializeParam(
                                                      listViewUsersRecord,
                                                      ParamType.Document,
                                                    ),
                                                  }.withoutNulls,
                                                  extra: <String, dynamic>{
                                                    'profileDoc':
                                                        listViewUsersRecord,
                                                  },
                                                );
                                              },
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 1.0,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10.0),
                                                    bottomRight:
                                                        Radius.circular(10.0),
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: Container(
                                                  width: 80.0,
                                                  height: 90.0,
                                                  decoration: BoxDecoration(
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10.0),
                                                      bottomRight:
                                                          Radius.circular(10.0),
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                      topRight:
                                                          Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          width: 45.0,
                                                          height: 45.0,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                            valueOrDefault<
                                                                String>(
                                                              listViewUsersRecord
                                                                  .photoUrl,
                                                              'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      AutoSizeText(
                                                        valueOrDefault<String>(
                                                          listViewUsersRecord
                                                              .displayName,
                                                          'Speaker name',
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 2,
                                                        style:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Noto Serif',
                                                                  letterSpacing:
                                                                      0.0,
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
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 10.0),
                                child: SelectionArea(
                                    child: Text(
                                  'About Event',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                      ),
                                )),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            child: SelectionArea(
                                child: Text(
                              valueOrDefault<String>(
                                widget.docEvent?.description,
                                'No Description ',
                              ),
                              style: MyFlutterTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    color: MyFlutterTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 12.0, 0.0, 16.0),
                      child: Container(
                        height: 80.0,
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 14.0),
                                child: SelectionArea(
                                    child: Text(
                                  'Event Categories',
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                      ),
                                )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              child: Builder(
                                builder: (context) {
                                  final eventCategories =
                                      widget.docEvent?.categories.toList() ??
                                          [];

                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children:
                                        List.generate(eventCategories.length,
                                            (eventCategoriesIndex) {
                                      final eventCategoriesItem =
                                          eventCategories[eventCategoriesIndex];
                                      return Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(6.0, 0.0, 6.0, 0.0),
                                        child: Container(
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(8.0, 0.0, 8.0, 0.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                eventCategoriesItem,
                                                'None',
                                              ),
                                              style: MyFlutterTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.docEvent?.peopleJoined
                            .contains(currentUserReference) ??
                        true)
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 300.0,
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 8.0, 0.0),
                                        child: SelectionArea(
                                            child: Text(
                                          'Reviews',
                                          style: MyFlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primaryText,
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                              ),
                                        )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 0.0, 8.0, 0.0),
                                        child: Icon(
                                          Icons.star_rounded,
                                          color: MyFlutterTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                      ),
                                      SelectionArea(
                                          child: Text(
                                        valueOrDefault<String>(
                                          '${valueOrDefault<String>(
                                            widget.docEvent?.rating.toString(),
                                            '0',
                                          )}  (${valueOrDefault<String>(
                                            widget.docEvent?.timesRated
                                                .toString(),
                                            '0',
                                          )})',
                                          '0 (0)',
                                        ),
                                        style: MyFlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                            ),
                                      )),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(12.0, 0.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.editFeedback = true;
                                            safeSetState(() {});
                                          },
                                          text: 'write',
                                          icon: const Icon(
                                            Icons.edit_outlined,
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(5.0, 0.0, 5.0, 0.0),
                                            iconAlignment: IconAlignment.end,
                                            iconPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            textStyle:
                                                MyFlutterTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Noto Serif',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 222.0,
                              decoration: BoxDecoration(
                                color: MyFlutterTheme.of(context)
                                    .primaryBackground,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: StreamBuilder<List<EventRatingRecord>>(
                                  stream: queryEventRatingRecord(
                                    queryBuilder: (eventRatingRecord) =>
                                        eventRatingRecord.where(
                                      'event',
                                      isEqualTo: widget.docEvent?.reference,
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
                                    List<EventRatingRecord>
                                        listViewEventRatingRecordList =
                                        snapshot.data!;

                                    return ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          listViewEventRatingRecordList.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(width: 10.0),
                                      itemBuilder: (context, listViewIndex) {
                                        final listViewEventRatingRecord =
                                            listViewEventRatingRecordList[
                                                listViewIndex];
                                        return Material(
                                          color: Colors.transparent,
                                          elevation: 1.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Container(
                                            width: 170.0,
                                            height: 200.0,
                                            decoration: BoxDecoration(
                                              color: MyFlutterTheme.of(context)
                                                  .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  StreamBuilder<UsersRecord>(
                                                    stream: UsersRecord.getDocument(
                                                        listViewEventRatingRecord
                                                            .user!),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            child:
                                                                SpinKitRipple(
                                                              color: MyFlutterTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 50.0,
                                                            ),
                                                          ),
                                                        );
                                                      }

                                                      final columnUsersRecord =
                                                          snapshot.data!;

                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        -1.0,
                                                                        -0.7),
                                                                child:
                                                                    Container(
                                                                  width: 45.0,
                                                                  height: 45.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      columnUsersRecord
                                                                          .photoUrl,
                                                                      'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    errorBuilder: (context,
                                                                            error,
                                                                            stackTrace) =>
                                                                        Image
                                                                            .asset(
                                                                      'assets/images/error_image.PNG',
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          6.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          columnUsersRecord
                                                                              .displayName,
                                                                          'Name',
                                                                        ),
                                                                        style: MyFlutterTheme.of(context)
                                                                            .titleMedium
                                                                            .override(
                                                                              fontFamily: 'Noto Serif',
                                                                              color: MyFlutterTheme.of(context).primaryText,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            2.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            dateTimeFormat("yMMMd",
                                                                                listViewEventRatingRecord.dateTime),
                                                                            'Nov 5, 2024',
                                                                          ),
                                                                          style: MyFlutterTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Noto Serif',
                                                                                color: MyFlutterTheme.of(context).secondaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          RatingBarIndicator(
                                                            itemBuilder:
                                                                (context,
                                                                        index) =>
                                                                    Icon(
                                                              Icons
                                                                  .star_rounded,
                                                              color: MyFlutterTheme
                                                                      .of(context)
                                                                  .primary,
                                                            ),
                                                            direction:
                                                                Axis.horizontal,
                                                            rating:
                                                                listViewEventRatingRecord
                                                                    .stars
                                                                    .toDouble(),
                                                            unratedColor:
                                                                MyFlutterTheme.of(
                                                                        context)
                                                                    .accent2,
                                                            itemCount: 5,
                                                            itemSize: 18.0,
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    height: 111.1,
                                                    decoration:
                                                        const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            listViewEventRatingRecord
                                                                .review,
                                                            'Review',
                                                          ),
                                                          maxLines: 3,
                                                          style:
                                                              MyFlutterTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Noto Serif',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (widget.docEvent?.manager?.id ==
                        currentUserReference?.id)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 110.0,
                          decoration: BoxDecoration(
                            color: MyFlutterTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: MyFlutterTheme.of(context).primary,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.qr_code_scanner,
                                        color: MyFlutterTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      Align(
                                        alignment: const AlignmentDirectional(
                                            -1.0, 0.0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10.0, 0.0, 0.0, 0.0),
                                          child: SelectionArea(
                                              child: Text(
                                            'Check Ticket',
                                            style: MyFlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primaryText,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    _model.scanned =
                                        await FlutterBarcodeScanner.scanBarcode(
                                      '#C62828', // scanning line color
                                      'Cancel', // cancel button text
                                      true, // whether to show the flash icon
                                      ScanMode.BARCODE,
                                    );

                                    if (_model.scanned == '-1') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'scan - false',
                                            style: TextStyle(
                                              color: MyFlutterTheme.of(context)
                                                  .primaryText,
                                            ),
                                          ),
                                          duration: const Duration(
                                              milliseconds: 4000),
                                          backgroundColor:
                                              MyFlutterTheme.of(context)
                                                  .primary,
                                        ),
                                      );
                                    } else {
                                      _model.eventScanRef =
                                          valueOrDefault<String>(
                                        functions
                                            .getEventFromScan(_model.scanned),
                                        'event',
                                      );
                                      _model.userScanRef =
                                          valueOrDefault<String>(
                                        functions
                                            .getUserFromScan(_model.scanned),
                                        'user',
                                      );
                                      safeSetState(() {});
                                      _model.scanResultWindow = true;
                                      safeSetState(() {});
                                    }

                                    safeSetState(() {});
                                  },
                                  text: 'Scan QR Code',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    color: MyFlutterTheme.of(context).primary,
                                    textStyle: MyFlutterTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 12.0, 20.0, 30.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  MyFlutterIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30.0,
                                    borderWidth: 1.0,
                                    buttonSize: 50.0,
                                    fillColor:
                                        MyFlutterTheme.of(context).primary,
                                    icon: const FaIcon(
                                      FontAwesomeIcons.moneyBillAlt,
                                      color: Colors.white,
                                      size: 26.0,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ).animateOnPageLoad(animationsMap[
                                      'iconButtonOnPageLoadAnimation']!),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 0.0),
                                    child: RichText(
                                      textScaler:
                                          MediaQuery.of(context).textScaler,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: valueOrDefault<String>(
                                              widget.docEvent?.currency,
                                              'Pkr',
                                            ),
                                            style: MyFlutterTheme.of(context)
                                                .headlineSmall
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          const TextSpan(
                                            text: '  ',
                                            style: TextStyle(),
                                          ),
                                          TextSpan(
                                            text: valueOrDefault<String>(
                                              widget.docEvent?.price.toString(),
                                              '00',
                                            ),
                                            style: TextStyle(
                                              color: MyFlutterTheme.of(context)
                                                  .success,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: ' + Tax',
                                            style: TextStyle(
                                              fontSize: 10.0,
                                            ),
                                          )
                                        ],
                                        style: MyFlutterTheme.of(context)
                                            .titleLarge
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (!widget.docEvent!.peopleJoined
                                      .contains(currentUserReference) &&
                                  (widget.docEvent!.timeEnd! >
                                      getCurrentTimestamp))
                                FFButtonWidget(
                                  onPressed: (_model.bBuyTicket == false)
                                      ? null
                                      : () async {
                                          final paymentResponse =
                                              await processStripePayment(
                                            context,
                                            amount: valueOrDefault<int>(
                                              ((valueOrDefault<double>(
                                                            widget
                                                                .docEvent?.price
                                                                .toDouble(),
                                                            0.0,
                                                          ) +
                                                          valueOrDefault<
                                                              double>(
                                                            1,
                                                            1.0,
                                                          )) *
                                                      100)
                                                  .round(),
                                              1,
                                            ),
                                            currency: 'USD',
                                            customerEmail: currentUserEmail,
                                            customerName:
                                                currentUserDisplayName,
                                            description: valueOrDefault<String>(
                                              '${widget.docEvent?.name}${"/n"}${widget.docEvent?.description}',
                                              'Nothing Special',
                                            ),
                                            allowGooglePay: true,
                                            allowApplePay: false,
                                            themeStyle: ThemeMode.system,
                                            buttonColor:
                                                MyFlutterTheme.of(context)
                                                    .primary,
                                            buttonTextColor:
                                                MyFlutterTheme.of(context)
                                                    .secondaryBackground,
                                          );
                                          if (paymentResponse.paymentId ==
                                                  null &&
                                              paymentResponse.errorMessage !=
                                                  null) {
                                            showSnackbar(
                                              context,
                                              'Error: ${paymentResponse.errorMessage}',
                                            );
                                          }
                                          _model.paymentId =
                                              paymentResponse.paymentId ?? '';

                                          if (_model.paymentId != null &&
                                              _model.paymentId != '') {
                                            await currentUserReference!.update({
                                              ...mapToFirestore(
                                                {
                                                  'eventTickets':
                                                      FieldValue.arrayUnion([
                                                    widget.docEvent?.reference
                                                  ]),
                                                },
                                              ),
                                            });

                                            await widget.docEvent!.reference
                                                .update({
                                              ...mapToFirestore(
                                                {
                                                  'attendees':
                                                      FieldValue.arrayUnion([
                                                    currentUserReference
                                                  ]),
                                                  'peopleJoined':
                                                      FieldValue.arrayUnion([
                                                    currentUserReference
                                                  ]),
                                                },
                                              ),
                                            });

                                            context.goNamed(
                                              'ticketEvent',
                                              queryParameters: {
                                                'imageEvent': serializeParam(
                                                  valueOrDefault<String>(
                                                    widget
                                                        .docEvent?.media.first,
                                                    'https://firebasestorage.googleapis.com/v0/b/jaane-event-1.appspot.com/o/wizards_Gathering_3dRoom.jpg?alt=media&token=ee109476-abe3-49f3-8f8b-d7d1fc7808b0',
                                                  ),
                                                  ParamType.String,
                                                ),
                                                'nameEvent': serializeParam(
                                                  valueOrDefault<String>(
                                                    widget.docEvent?.name,
                                                    'Event Name',
                                                  ),
                                                  ParamType.String,
                                                ),
                                                'startEvent': serializeParam(
                                                  widget.docEvent?.timeStart,
                                                  ParamType.DateTime,
                                                ),
                                                'endEvent': serializeParam(
                                                  widget.docEvent?.timeEnd,
                                                  ParamType.DateTime,
                                                ),
                                                'managerEvent': serializeParam(
                                                  widget.docEvent?.manager,
                                                  ParamType.DocumentReference,
                                                ),
                                                'locationEvent': serializeParam(
                                                  valueOrDefault<String>(
                                                    widget.docEvent?.location
                                                        ?.toString(),
                                                    'location',
                                                  ),
                                                  ParamType.String,
                                                ),
                                                'priceEvent': serializeParam(
                                                  valueOrDefault<double>(
                                                    widget.docEvent?.price
                                                        .toDouble(),
                                                    0.0,
                                                  ),
                                                  ParamType.double,
                                                ),
                                                'currencyEvent': serializeParam(
                                                  valueOrDefault<String>(
                                                    widget.docEvent?.currency,
                                                    'USD',
                                                  ),
                                                  ParamType.String,
                                                ),
                                                'eventRef': serializeParam(
                                                  widget.docEvent?.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    const TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType
                                                          .topToBottom,
                                                  duration: Duration(
                                                      milliseconds: 700),
                                                ),
                                              },
                                            );
                                          }

                                          safeSetState(() {});
                                        },
                                  text: 'Buy Ticket',
                                  options: FFButtonOptions(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            14.0, 0.0, 14.0, 0.0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    color: MyFlutterTheme.of(context).primary,
                                    textStyle: MyFlutterTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                    disabledColor: const Color(0xFFAEB1B4),
                                  ),
                                ),
                              if (widget.docEvent?.peopleJoined
                                      .contains(currentUserReference) ??
                                  true)
                                FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(
                                      'ticketEvent',
                                      queryParameters: {
                                        'imageEvent': serializeParam(
                                          widget.docEvent?.media.first,
                                          ParamType.String,
                                        ),
                                        'nameEvent': serializeParam(
                                          valueOrDefault<String>(
                                            widget.docEvent?.name,
                                            'Event Name',
                                          ),
                                          ParamType.String,
                                        ),
                                        'managerEvent': serializeParam(
                                          widget.docEvent?.manager,
                                          ParamType.DocumentReference,
                                        ),
                                        'startEvent': serializeParam(
                                          widget.docEvent?.timeStart,
                                          ParamType.DateTime,
                                        ),
                                        'endEvent': serializeParam(
                                          widget.docEvent?.timeEnd,
                                          ParamType.DateTime,
                                        ),
                                        'locationEvent': serializeParam(
                                          valueOrDefault<String>(
                                            widget.docEvent?.address,
                                            'address',
                                          ),
                                          ParamType.String,
                                        ),
                                        'priceEvent': serializeParam(
                                          valueOrDefault<double>(
                                            widget.docEvent?.price.toDouble(),
                                            0.0,
                                          ),
                                          ParamType.double,
                                        ),
                                        'currencyEvent': serializeParam(
                                          'USD',
                                          ParamType.String,
                                        ),
                                        'eventRef': serializeParam(
                                          widget.docEvent?.reference,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey:
                                            const TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.scale,
                                          alignment: Alignment.bottomCenter,
                                        ),
                                      },
                                    );
                                  },
                                  text: 'View Ticket',
                                  options: FFButtonOptions(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            14.0, 0.0, 14.0, 0.0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                    color: MyFlutterTheme.of(context).primary,
                                    textStyle: MyFlutterTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                if (!(!widget.docEvent!.peopleJoined
                                        .contains(currentUserReference) &&
                                    (widget.docEvent!.timeEnd! <
                                        getCurrentTimestamp)))
                                  Theme(
                                    data: ThemeData(
                                      checkboxTheme: CheckboxThemeData(
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      unselectedWidgetColor:
                                          MyFlutterTheme.of(context)
                                              .secondaryText,
                                    ),
                                    child: Checkbox(
                                      value: _model.cbTermsNConditionsValue ??=
                                          _model.bBuyTicket,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.cbTermsNConditionsValue =
                                                newValue!);
                                        if (newValue!) {
                                          _model.bBuyTicket =
                                              !_model.bBuyTicket;
                                          safeSetState(() {});
                                        }
                                      },
                                      side: BorderSide(
                                        width: 2,
                                        color: MyFlutterTheme.of(context)
                                            .secondaryText,
                                      ),
                                      activeColor:
                                          MyFlutterTheme.of(context).primary,
                                      checkColor:
                                          MyFlutterTheme.of(context).info,
                                    ),
                                  ),
                                if (widget.docEvent?.peopleJoined
                                        .contains(currentUserReference) ??
                                    true)
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            3.0, 0.0, 3.0, 0.0),
                                    child: Icon(
                                      Icons.open_in_new_sharp,
                                      color:
                                          MyFlutterTheme.of(context).secondary,
                                      size: 20.0,
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'I accept term\'s and conditions.',
                                    style: MyFlutterTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Noto Serif',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                if (!widget.docEvent!.peopleJoined
                                    .contains(currentUserReference))
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.open_in_new_sharp,
                                      color:
                                          MyFlutterTheme.of(context).secondary,
                                      size: 20.0,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Stack(
                                  children: [
                                    if (widget.docEvent?.refundable == true)
                                      FaIcon(
                                        FontAwesomeIcons.check,
                                        color:
                                            MyFlutterTheme.of(context).success,
                                        size: 24.0,
                                      ),
                                    if (widget.docEvent?.refundable == false)
                                      Icon(
                                        Icons.close,
                                        color: MyFlutterTheme.of(context).error,
                                        size: 24.0,
                                      ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Refundable, till week before of event start. ',
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, -1.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      15.0, 30.0, 15.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyFlutterIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        borderWidth: 1.0,
                        buttonSize: 50.0,
                        fillColor: MyFlutterTheme.of(context).primary,
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onPressed: () async {
                          context.safePop();
                        },
                      ),
                      Builder(
                        builder: (context) => InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await showDialog(
                              barrierColor: const Color(0x30FFB966),
                              context: context,
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment:
                                      const AlignmentDirectional(0.0, 0.0)
                                          .resolve(Directionality.of(context)),
                                  child: GestureDetector(
                                    onTap: () =>
                                        FocusScope.of(dialogContext).unfocus(),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              1.0,
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      child: ReportWidget(
                                        type: 'event',
                                        eventID: widget.docEvent?.reference,
                                        userID: currentUserReference,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0x6AFFA130),
                            size: 26.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (valueOrDefault<bool>(
                _model.editFeedback != false,
                true,
              ))
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    decoration: const BoxDecoration(
                      color: Color(0x1F040404),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.7,
                              decoration: BoxDecoration(
                                color: MyFlutterTheme.of(context)
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Event Feedback',
                                      style: MyFlutterTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            color: MyFlutterTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                    SizedBox(
                                      width: 150.0,
                                      child: Divider(
                                        thickness: 2.0,
                                        color: MyFlutterTheme.of(context)
                                            .alternate,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 8.0, 0.0, 0.0),
                                      child: RatingBar.builder(
                                        onRatingUpdate: (newValue) =>
                                            safeSetState(() =>
                                                _model.rBEventFeedbackValue =
                                                    newValue),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star_rounded,
                                          color: MyFlutterTheme.of(context)
                                              .primary,
                                        ),
                                        direction: Axis.horizontal,
                                        initialRating:
                                            _model.rBEventFeedbackValue ??= 3.0,
                                        unratedColor: const Color(0x2A57636C),
                                        itemCount: 5,
                                        itemSize: 32.0,
                                        glowColor:
                                            MyFlutterTheme.of(context).primary,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 16.0, 0.0, 0.0),
                                      child: SizedBox(
                                        width: 200.0,
                                        child: TextFormField(
                                          controller: _model
                                              .tfEventFeedbackTextController,
                                          focusNode:
                                              _model.tfEventFeedbackFocusNode,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelText: 'Feedback',
                                            labelStyle: MyFlutterTheme.of(
                                                    context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Noto Serif',
                                                  color:
                                                      MyFlutterTheme.of(context)
                                                          .primary,
                                                  letterSpacing: 0.0,
                                                ),
                                            hintText:
                                                'Write your Feedback here!',
                                            hintStyle:
                                                MyFlutterTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Noto Serif',
                                                      letterSpacing: 0.0,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                MyFlutterTheme.of(context)
                                                    .secondaryBackground,
                                          ),
                                          style: MyFlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                letterSpacing: 0.0,
                                              ),
                                          maxLines: 7,
                                          maxLength: 80,
                                          buildCounter: (context,
                                                  {required currentLength,
                                                  required isFocused,
                                                  maxLength}) =>
                                              null,
                                          cursorColor:
                                              MyFlutterTheme.of(context)
                                                  .primaryText,
                                          validator: _model
                                              .tfEventFeedbackTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 13.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () async {
                                              _model.editFeedback = false;
                                              safeSetState(() {});
                                            },
                                            text: 'Cancel',
                                            options: FFButtonOptions(
                                              width: 76.0,
                                              height: 34.0,
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 0.0, 0.0, 0.0),
                                              color: MyFlutterTheme.of(context)
                                                  .primaryBackground,
                                              textStyle: MyFlutterTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color: MyFlutterTheme.of(
                                                            context)
                                                        .primary,
                                                    letterSpacing: 0.0,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color:
                                                    MyFlutterTheme.of(context)
                                                        .primary,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          FFButtonWidget(
                                            onPressed: () async {
                                              _model.qQEventRatingDoc =
                                                  await queryEventRatingRecordOnce(
                                                queryBuilder:
                                                    (eventRatingRecord) =>
                                                        eventRatingRecord
                                                            .where(
                                                              'event',
                                                              isEqualTo: widget
                                                                  .docEvent
                                                                  ?.reference,
                                                            )
                                                            .where(
                                                              'user',
                                                              isEqualTo:
                                                                  currentUserReference,
                                                            ),
                                                singleRecord: true,
                                              ).then((s) => s.firstOrNull);
                                              if (_model.qQEventRatingDoc
                                                      ?.reference !=
                                                  null) {
                                                await widget.docEvent!.reference
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'total_Rating': FieldValue
                                                          .increment(-(_model
                                                              .qQEventRatingDoc!
                                                              .stars
                                                              .toDouble())),
                                                    },
                                                  ),
                                                });

                                                await _model
                                                    .qQEventRatingDoc!.reference
                                                    .update(
                                                        createEventRatingRecordData(
                                                  stars: _model
                                                      .rBEventFeedbackValue
                                                      ?.round(),
                                                  dateTime: getCurrentTimestamp,
                                                  review: _model
                                                      .tfEventFeedbackTextController
                                                      .text,
                                                ));

                                                await widget.docEvent!.reference
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'total_Rating': FieldValue
                                                          .increment(_model
                                                              .rBEventFeedbackValue!),
                                                    },
                                                  ),
                                                });
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500));
                                                _model.eventDocL =
                                                    await EventsRecord
                                                        .getDocumentOnce(widget
                                                            .docEvent!
                                                            .reference);

                                                await widget.docEvent!.reference
                                                    .update(
                                                        createEventsRecordData(
                                                  rating:
                                                      valueOrDefault<double>(
                                                    valueOrDefault<double>(
                                                          _model.eventDocL
                                                              ?.totalRating,
                                                          0.0,
                                                        ) /
                                                        valueOrDefault<double>(
                                                          _model.eventDocL
                                                              ?.timesRated
                                                              .toDouble(),
                                                          0.0,
                                                        ),
                                                    0.0,
                                                  ),
                                                ));
                                              } else {
                                                await EventRatingRecord
                                                    .collection
                                                    .doc()
                                                    .set(
                                                        createEventRatingRecordData(
                                                      event: widget
                                                          .docEvent?.reference,
                                                      user:
                                                          currentUserReference,
                                                      stars: _model
                                                          .rBEventFeedbackValue
                                                          ?.round(),
                                                      review: _model
                                                          .tfEventFeedbackTextController
                                                          .text,
                                                    ));

                                                await widget.docEvent!.reference
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'total_Rating': FieldValue
                                                          .increment(_model
                                                              .rBEventFeedbackValue!),
                                                      'timesRated':
                                                          FieldValue.increment(
                                                              1),
                                                    },
                                                  ),
                                                });
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500));
                                                _model.eventDoc =
                                                    await EventsRecord
                                                        .getDocumentOnce(widget
                                                            .docEvent!
                                                            .reference);

                                                await widget.docEvent!.reference
                                                    .update(
                                                        createEventsRecordData(
                                                  rating:
                                                      valueOrDefault<double>(
                                                    valueOrDefault<double>(
                                                          _model.eventDoc
                                                              ?.totalRating,
                                                          0.0,
                                                        ) /
                                                        valueOrDefault<double>(
                                                          _model.eventDoc
                                                              ?.timesRated
                                                              .toDouble(),
                                                          0.0,
                                                        ),
                                                    0.0,
                                                  ),
                                                ));
                                              }

                                              _model.editFeedback = false;
                                              safeSetState(() {});

                                              safeSetState(() {});
                                            },
                                            text: 'Save',
                                            options: FFButtonOptions(
                                              width: 76.0,
                                              height: 34.0,
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 0.0, 0.0, 0.0),
                                              color: MyFlutterTheme.of(context)
                                                  .primary,
                                              textStyle:
                                                  MyFlutterTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Noto Serif',
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                      ),
                                              elevation: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
                        ],
                      ),
                    ),
                  ),
                ),
              if (valueOrDefault<bool>(
                _model.scanResultWindow != false,
                true,
              ))
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  decoration: const BoxDecoration(
                    color: Color(0x1F36B4FF),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: 240.0,
                      height: 350.0,
                      decoration: BoxDecoration(
                        color: MyFlutterTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.cancel,
                                  color: Colors.transparent,
                                  size: 24.0,
                                ),
                                Text(
                                  'Ticket Scan Result',
                                  style: MyFlutterTheme.of(context)
                                      .labelLarge
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        color: MyFlutterTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 6.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.scanResultWindow = false;
                                      safeSetState(() {});
                                    },
                                    child: Icon(
                                      Icons.cancel,
                                      color: MyFlutterTheme.of(context).error,
                                      size: 32.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 150.0,
                              child: Divider(
                                height: 10.0,
                                thickness: 2.0,
                                color: Color(0x8057636C),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: StreamBuilder<List<UsersRecord>>(
                                stream: queryUsersRecord(
                                  queryBuilder: (usersRecord) =>
                                      usersRecord.where(
                                    'uid',
                                    isEqualTo: valueOrDefault<String>(
                                      _model.userScanRef,
                                      'user',
                                    ),
                                  ),
                                  singleRecord: true,
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
                                      snapshot.data!;
                                  // Return an empty Container when the item does not exist.
                                  if (snapshot.data!.isEmpty) {
                                    return Container();
                                  }
                                  final rowUsersRecord =
                                      rowUsersRecordList.isNotEmpty
                                          ? rowUsersRecordList.first
                                          : null;

                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(8.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width: 70.0,
                                          height: 70.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            valueOrDefault<String>(
                                              rowUsersRecord?.photoUrl,
                                              'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Talneties_logo_-01.PNG?alt=media&token=5c32948c-9800-414f-aeb9-617c06892eef',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 64.0,
                                        decoration: const BoxDecoration(),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(8.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AutoSizeText(
                                                valueOrDefault<String>(
                                                  rowUsersRecord?.displayName,
                                                  'Name',
                                                ),
                                                style:
                                                    MyFlutterTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  context.pushNamed(
                                                    'profile',
                                                    queryParameters: {
                                                      'profileDoc':
                                                          serializeParam(
                                                        rowUsersRecord,
                                                        ParamType.Document,
                                                      ),
                                                    }.withoutNulls,
                                                    extra: <String, dynamic>{
                                                      'profileDoc':
                                                          rowUsersRecord,
                                                    },
                                                  );
                                                },
                                                text: 'View Profile',
                                                options: FFButtonOptions(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          24.0, 0.0, 24.0, 0.0),
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  color:
                                                      const Color(0x7FAFAFAF),
                                                  textStyle:
                                                      MyFlutterTheme.of(context)
                                                          .bodySmall
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            letterSpacing: 0.0,
                                                          ),
                                                  elevation: 0.0,
                                                  borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment:
                                      const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (widget.docEvent?.eventID ==
                                            _model.eventScanRef)
                                          Icon(
                                            Icons.check_circle_outline_rounded,
                                            color: MyFlutterTheme.of(context)
                                                .success,
                                            size: 60.0,
                                          ),
                                        if (widget.docEvent?.eventID !=
                                            _model.eventScanRef)
                                          Icon(
                                            Icons.cancel_outlined,
                                            color: MyFlutterTheme.of(context)
                                                .error,
                                            size: 60.0,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (widget.docEvent?.eventID ==
                                        _model.eventScanRef)
                                      Text(
                                        'Valid ',
                                        style: MyFlutterTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    if (widget.docEvent?.eventID !=
                                        _model.eventScanRef)
                                      Text(
                                        'Invalid ',
                                        style: MyFlutterTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Noto Serif',
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    Text(
                                      'Ticket',
                                      style: MyFlutterTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            4.0, 16.0, 0.0, 0.0),
                                    child: Text(
                                      'Check-in at: ',
                                      style: MyFlutterTheme.of(context)
                                          .labelLarge
                                          .override(
                                            fontFamily: 'Noto Serif',
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                                Text(
                                  valueOrDefault<String>(
                                    '${valueOrDefault<String>(
                                      dateTimeFormat("jm", getCurrentTimestamp),
                                      '11:54 AM',
                                    )}  -  ${valueOrDefault<String>(
                                      dateTimeFormat(
                                          "yMMMd", getCurrentTimestamp),
                                      'Nov 11, 2024',
                                    )}',
                                    '11:54 AM  -  Nov 11, 2024',
                                  ),
                                  style: MyFlutterTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Noto Serif',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.run_circle_sharp,
                                        color:
                                            MyFlutterTheme.of(context).primary,
                                        size: 40.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(6.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'Already Check-in',
                                          style: MyFlutterTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}
