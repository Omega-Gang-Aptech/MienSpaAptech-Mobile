import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mien_spa_mobile/providers/map_location_provider/map_location_provider.dart';
import 'package:mien_spa_mobile/theme/constants.dart';

class LocationGoogleMap extends ConsumerWidget {
  const LocationGoogleMap({Key? key}) : super(key: key);
  static String routeName = '/location_google_map';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapLocation = ref.watch(mapLocationProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: KBlack,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: KWhite,
        title: Text(
          "Vị trí tiệm",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: KBlack,
          ),
        ),
      ),
      body: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: mapLocation,
              zoom: 18.5,
            ),
            markers: {
              const Marker(
                markerId: MarkerId("1"),
                position: LatLng(10.796476953392588, 106.69189649709887),
              ),
            },
          )
        ],
      ),
    );
  }
}
