import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';

import '/auth/base_auth_user_provider.dart';

import '/index.dart';
import '/my_flutter/my_flutter_theme.dart';
import '/my_flutter/my_flutter_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => appStateNotifier.loggedIn
          ? const HomeWidget()
          : const OnBoardingWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? const HomeWidget()
              : const OnBoardingWidget(),
        ),
        FFRoute(
          name: 'Login',
          path: '/login',
          builder: (context, params) => const LoginWidget(),
        ),
        FFRoute(
          name: 'home',
          path: '/home',
          builder: (context, params) => const HomeWidget(),
        ),
        FFRoute(
          name: 'Bookings',
          path: '/bookings',
          builder: (context, params) => BookingsWidget(
            byNav: params.getParam(
              'byNav',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'onBoarding',
          path: '/onBoarding',
          builder: (context, params) => const OnBoardingWidget(),
        ),
        FFRoute(
          name: 'signup',
          path: '/signup',
          builder: (context, params) => const SignupWidget(),
        ),
        FFRoute(
          name: 'phoneSigninCode',
          path: '/phoneSigninCode',
          builder: (context, params) => PhoneSigninCodeWidget(
            phoneNumberSignin: params.getParam(
              'phoneNumberSignin',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'junk',
          path: '/junk',
          builder: (context, params) => const JunkWidget(),
        ),
        FFRoute(
          name: 'tryPage',
          path: '/tryPage',
          builder: (context, params) => const TryPageWidget(),
        ),
        FFRoute(
          name: 'myProfile',
          path: '/myProfile',
          builder: (context, params) => const MyProfileWidget(),
        ),
        FFRoute(
          name: 'postNewEvent',
          path: '/postNewEvent',
          builder: (context, params) => const PostNewEventWidget(),
        ),
        FFRoute(
          name: 'bookMeeting',
          path: '/bookMeeting',
          asyncParams: {
            'mentor': getDoc(['users'], UsersRecord.fromSnapshot),
          },
          builder: (context, params) => BookMeetingWidget(
            mentor: params.getParam(
              'mentor',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'bookedMeetingSummery',
          path: '/bookedMeetingSummery',
          asyncParams: {
            'mentor': getDoc(['users'], UsersRecord.fromSnapshot),
          },
          builder: (context, params) => BookedMeetingSummeryWidget(
            mentor: params.getParam(
              'mentor',
              ParamType.Document,
            ),
            slotTme: params.getParam(
              'slotTme',
              ParamType.DateTime,
            ),
          ),
        ),
        FFRoute(
          name: 'event',
          path: '/event',
          asyncParams: {
            'docEvent': getDoc(['events'], EventsRecord.fromSnapshot),
          },
          builder: (context, params) => EventWidget(
            docEvent: params.getParam(
              'docEvent',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'ticketEvent',
          path: '/ticketEvent',
          builder: (context, params) => TicketEventWidget(
            imageEvent: params.getParam(
              'imageEvent',
              ParamType.String,
            ),
            nameEvent: params.getParam(
              'nameEvent',
              ParamType.String,
            ),
            managerEvent: params.getParam(
              'managerEvent',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['users'],
            ),
            startEvent: params.getParam(
              'startEvent',
              ParamType.DateTime,
            ),
            endEvent: params.getParam(
              'endEvent',
              ParamType.DateTime,
            ),
            locationEvent: params.getParam(
              'locationEvent',
              ParamType.String,
            ),
            priceEvent: params.getParam(
              'priceEvent',
              ParamType.double,
            ),
            currencyEvent: params.getParam(
              'currencyEvent',
              ParamType.String,
            ),
            eventRef: params.getParam(
              'eventRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['events'],
            ),
          ),
        ),
        FFRoute(
          name: 'profile',
          path: '/profile',
          asyncParams: {
            'profileDoc': getDoc(['users'], UsersRecord.fromSnapshot),
          },
          builder: (context, params) => ProfileWidget(
            profileDoc: params.getParam(
              'profileDoc',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'createMeetingsSlots',
          path: '/createMeetingsSlots',
          builder: (context, params) => const CreateMeetingsSlotsWidget(),
        ),
        FFRoute(
          name: 'bookMeetingCopy',
          path: '/bookMeetingCopy',
          asyncParams: {
            'mentor': getDoc(['users'], UsersRecord.fromSnapshot),
          },
          builder: (context, params) => BookMeetingCopyWidget(
            mentor: params.getParam(
              'mentor',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: 'meetingArea',
          path: '/meetingArea',
          builder: (context, params) => MeetingAreaWidget(
            slot15min: params.getParam(
              'slot15min',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['mentorMeetingSlots', 'mentor15minsSlots'],
            ),
          ),
        ),
        // FFRoute(
        //   name: 'meetingArea',
        //   path: '/meetingArea',
        //   builder: (context, params) => MeetingAreaWidget(
        //     slot15min: params.getParam(
        //       'slot15min',
        //       ParamType.DocumentReference,
        //       isList: false,
        //       collectionNamePath: ['mentorMeetingSlots', 'mentor15minsSlots'],
        //     ),
        //     isJoinMeetingSelected:
        //         false, // Provide an initial value or pass dynamically
        //     isCreateMeetingSelected:
        //         false, // Provide an initial value or pass dynamically
        //     maxWidth: MediaQuery.of(context)
        //         .size
        //         .width, // Example of setting maxWidth dynamically
        //     onOptionSelected: (isCreateMeeting) {
        //       // Define what happens when an option is selected
        //       print('Option selected: $isCreateMeeting');
        //     },
        //     onClickMeetingJoin: (meetingId, callType, displayName) {
        //       // Define what happens when a meeting is joined
        //       print(
        //           'Meeting joined with ID: $meetingId, CallType: $callType, DisplayName: $displayName');
        //     },
        //   ),
        // ),

        FFRoute(
          name: 'Feed',
          path: '/feed',
          builder: (context, params) => const FeedWidget(),
        ),
        FFRoute(
          name: 'spotlightAdd',
          path: '/spotlightAdd',
          builder: (context, params) => const SpotlightAddWidget(),
        ),
        FFRoute(
          name: 'spotlights',
          path: '/spotlights',
          builder: (context, params) => SpotlightsWidget(
            postedBy: params.getParam(
              'postedBy',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['users'],
            ),
          ),
        ),
        FFRoute(
          name: 'map',
          path: '/map',
          builder: (context, params) => MapWidget(
            location: params.getParam(
              'location',
              ParamType.LatLng,
            ),
            address: params.getParam(
              'address',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'ban_Page',
          path: '/banPage',
          builder: (context, params) => const BanPageWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/onBoarding';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: SpinKitRipple(
                      color: MyFlutterTheme.of(context).primary,
                      size: 50.0,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() =>
      const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
