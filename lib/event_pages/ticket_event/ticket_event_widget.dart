import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/my_flutter/my_flutter_icon_button.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share_plus/share_plus.dart';
import 'ticket_event_model.dart';
export 'ticket_event_model.dart';

class TicketEventWidget extends StatefulWidget {
  const TicketEventWidget({
    super.key,
    String? imageEvent,
    String? nameEvent,
    this.managerEvent,
    this.startEvent,
    this.endEvent,
    String? locationEvent,
    required this.priceEvent,
    required this.currencyEvent,
    required this.eventRef,
  })  : imageEvent = imageEvent ??
            'https://firebasestorage.googleapis.com/v0/b/jaane-event-1.appspot.com/o/jaany.jpg?alt=media&token=8f3402b0-3afe-4ae4-81c1-6682bfa5f9ee',
        nameEvent = nameEvent ?? 'Name Event',
        locationEvent = locationEvent ?? 'Islamabad';

  final String imageEvent;
  final String nameEvent;
  final DocumentReference? managerEvent;
  final DateTime? startEvent;
  final DateTime? endEvent;
  final String locationEvent;
  final double? priceEvent;
  final String? currencyEvent;
  final DocumentReference? eventRef;

  @override
  State<TicketEventWidget> createState() => _TicketEventWidgetState();
}

class _TicketEventWidgetState extends State<TicketEventWidget> {
  late TicketEventModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TicketEventModel());

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      20.0, 12.0, 20.0, 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyFlutterIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 20.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        fillColor: const Color(0x34FFFFFF),
                        icon: Icon(
                          Icons.close,
                          color: MyFlutterTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          context.safePop();
                        },
                      ),
                      SelectionArea(
                          child: Text(
                        'Your Ticket',
                        style: MyFlutterTheme.of(context).bodyMedium.override(
                              fontFamily: 'Noto Serif',
                              color: MyFlutterTheme.of(context).primaryText,
                              fontSize: 18.0,
                              letterSpacing: 0.0,
                            ),
                      )),
                      Builder(
                        builder: (context) => MyFlutterIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          borderWidth: 1.0,
                          buttonSize: 40.0,
                          fillColor: const Color(0x34FFFFFF),
                          icon: Icon(
                            Icons.ios_share,
                            color: MyFlutterTheme.of(context).primary,
                            size: 20.0,
                          ),
                          onPressed: () async {
                            await Share.share(
                              'talenties://talenties.com${GoRouterState.of(context).uri.toString()}',
                              sharePositionOrigin:
                                  getWidgetBoundingBox(context),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      10.0, 0.0, 10.0, 0.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 660.0,
                              decoration: BoxDecoration(
                                color: MyFlutterTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          widget.imageEvent,
                                          'https://firebasestorage.googleapis.com/v0/b/talenties-5f525.appspot.com/o/Radio%203D.png?alt=media&token=6e4dd552-7dac-4ab3-9f10-35a261670d53',
                                        ),
                                        width: double.infinity,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                          'assets/images/error_image.PNG',
                                          width: double.infinity,
                                          height: 200.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SelectionArea(
                                                child: Text(
                                              valueOrDefault<String>(
                                                widget.nameEvent,
                                                'No Name',
                                              ),
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            )),
                                            FutureBuilder<UsersRecord>(
                                              future:
                                                  UsersRecord.getDocumentOnce(
                                                      widget.managerEvent!),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child: SpinKitRipple(
                                                        color:
                                                            MyFlutterTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 50.0,
                                                      ),
                                                    ),
                                                  );
                                                }

                                                final textUsersRecord =
                                                    snapshot.data!;

                                                return SelectionArea(
                                                    child: Text(
                                                  valueOrDefault<String>(
                                                    textUsersRecord.displayName,
                                                    'No Name',
                                                  ),
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: const Color(
                                                                0x7BFFFFFF),
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                ));
                                              },
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            MyFlutterIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30.0,
                                              borderWidth: 1.0,
                                              buttonSize: 40.0,
                                              icon: const Icon(
                                                Icons.download_outlined,
                                                color: Colors.white,
                                                size: 20.0,
                                              ),
                                              onPressed: () {
                                                print('IconButton pressed ...');
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 50.0, 20.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SelectionArea(
                                                child: Text(
                                              'Location',
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color:
                                                        const Color(0x80FFFFFF),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            )),
                                            SelectionArea(
                                                child: Text(
                                              valueOrDefault<String>(
                                                widget.locationEvent,
                                                'Location',
                                              ),
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 20.0, 20.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SelectionArea(
                                                child: Text(
                                              'Name',
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color:
                                                        const Color(0x80FFFFFF),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            )),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 0.0, 0.0, 10.0),
                                              child: AuthUserStreamWidget(
                                                builder: (context) =>
                                                    SelectionArea(
                                                        child: Text(
                                                  valueOrDefault<String>(
                                                    currentUserDisplayName,
                                                    'My Name',
                                                  ),
                                                  style:
                                                      MyFlutterTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Noto Serif',
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                )),
                                              ),
                                            ),
                                            SelectionArea(
                                                child: Text(
                                              'Valid From',
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color:
                                                        const Color(0x80FFFFFF),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            )),
                                            SelectionArea(
                                                child: Text(
                                              valueOrDefault<String>(
                                                dateTimeFormat(
                                                    "yMMMd", widget.startEvent),
                                                '21:00 PM',
                                              ),
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            )),
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SelectionArea(
                                                child: Text(
                                              'Purchased Date',
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color:
                                                        const Color(0x80FFFFFF),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            )),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 0.0, 0.0, 10.0),
                                              child: SelectionArea(
                                                  child: Text(
                                                valueOrDefault<String>(
                                                  dateTimeFormat("yMMMd",
                                                      getCurrentTimestamp),
                                                  'today',
                                                ),
                                                style:
                                                    MyFlutterTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Noto Serif',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              )),
                                            ),
                                            SelectionArea(
                                                child: Text(
                                              'Valid Till',
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color:
                                                        const Color(0x80FFFFFF),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            )),
                                            SelectionArea(
                                                child: Text(
                                              valueOrDefault<String>(
                                                dateTimeFormat(
                                                    "yMMMd", widget.endEvent),
                                                '21:00 PM',
                                              ),
                                              style: MyFlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Noto Serif',
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 35.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SelectionArea(
                                            child: Text(
                                          'Scan QR Code',
                                          style: MyFlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Noto Serif',
                                                color: Colors.white,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 0.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.7,
                                      height: 125.0,
                                      decoration: const BoxDecoration(),
                                      child: BarcodeWidget(
                                        data: valueOrDefault<String>(
                                          '${valueOrDefault<String>(
                                            widget.eventRef?.id,
                                            '*',
                                          )}++${valueOrDefault<String>(
                                            currentUserReference?.id,
                                            '#',
                                          )}',
                                          '\$',
                                        ),
                                        barcode: Barcode.qrCode(),
                                        width: 300.0,
                                        height: 95.0,
                                        color: MyFlutterTheme.of(context)
                                            .primaryBackground,
                                        backgroundColor: Colors.transparent,
                                        errorBuilder: (context, error) =>
                                            const SizedBox(
                                          width: 300.0,
                                          height: 95.0,
                                        ),
                                        drawText: false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            5.0, 450.0, 5.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: MyFlutterTheme.of(context)
                                    .secondaryBackground,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              '------------------------------------',
                              style: MyFlutterTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    color: MyFlutterTheme.of(context)
                                        .primaryBackground,
                                    letterSpacing: 3.0,
                                  ),
                            )),
                            Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: MyFlutterTheme.of(context)
                                    .secondaryBackground,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            5.0, 275.0, 5.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: MyFlutterTheme.of(context)
                                    .secondaryBackground,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              '------------------------------------',
                              style: MyFlutterTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Noto Serif',
                                    color: MyFlutterTheme.of(context)
                                        .primaryBackground,
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            )),
                            Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: MyFlutterTheme.of(context)
                                    .secondaryBackground,
                                shape: BoxShape.circle,
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
        ),
      ),
    );
  }
}
