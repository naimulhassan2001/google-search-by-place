
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/google_map_controller.dart';


class ShowGoogleMap extends StatefulWidget {
  ShowGoogleMap(
      {super.key,
      this.latitude = 0,
      this.longitude = 0,
      required this.onTapLatLong});

  double latitude;

  double longitude;
  Function(LatLng value) onTapLatLong;

  @override
  State<ShowGoogleMap> createState() => _ShowGoogleMapState();
}

class _ShowGoogleMapState extends State<ShowGoogleMap> {
  ShowGoogleMapController showGoogleMapController =
      Get.put(ShowGoogleMapController());

  @override
  void initState() {
    showGoogleMapController.getCurrentLocation();
    showGoogleMapController.fetchNearbyPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowGoogleMapController>(
      builder: (controller) {
        return GoogleMap(
          mapType: MapType.terrain,
          initialCameraPosition: controller.kGooglePlex,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          cameraTargetBounds: CameraTargetBounds.unbounded,
          onTap: (LatLng latLng) {
            widget.onTapLatLong(latLng);
            controller.setMarker(latLng.latitude, latLng.longitude);
          },
          markers: Set<Marker>.of(controller.markers.map((marker) {
            return marker;
          })),
          onMapCreated: (GoogleMapController googleMapController) {
            if (controller.controller.isCompleted) {
              controller.controller.complete(googleMapController);
            }
          },
        );
      },
    );
  }
}


