import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_location_provider.g.dart';

@riverpod
class MapLocation extends _$MapLocation {
  @override
  LatLng build() {
    return const LatLng(10.796476953392588, 106.69189649709887);
  }

  void setMapLocation(LatLng position) {
    state = position;
  }
}
