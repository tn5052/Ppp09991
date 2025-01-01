import '/my_flutter/my_flutter_google_map.dart';
import '/my_flutter/my_flutter_util.dart';
import 'map_widget.dart' show MapWidget;
import 'package:flutter/material.dart';

class MapModel extends MyFlutterModel<MapWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
