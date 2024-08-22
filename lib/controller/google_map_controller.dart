import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nearby_scarch/view/screen/google%20map/widgets/bottom_sheet.dart';

import '../models/place_model.dart';
import '../services/location_service.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ShowGoogleMapController extends GetxController {
  double latitude = 0;
  double longitude = 0;
  List<Marker> markers = [];

  Future<BitmapDescriptor> markerIcon() async {
    return await BitmapDescriptor.asset(
        ImageConfiguration(
            devicePixelRatio: MediaQuery.of(Get.context!).devicePixelRatio),
        "assets/images/marker.png",
        height: 60,
        width: 44);
  }

  final Completer<GoogleMapController> controller =
  Completer<GoogleMapController>();

  var kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  setMarker(lat, long) async {
    Marker newMarker = Marker(
        markerId:  MarkerId("${markers.length}"),
        icon: await markerIcon(),
        position: LatLng(lat, long));

    markers.add(newMarker);
    update();
    CameraPosition newCameraPosition = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(latitude, longitude),
        tilt: 59.440717697143555,
        zoom: 14);

    final GoogleMapController googleMapController = await controller.future;
    await googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  getCurrentLocation() async {
    Position? positions = await LocationService.getCurrentPosition();

    if (kDebugMode) {
      print("current location $positions");
    }
    if (positions != null) {
      CameraPosition newCameraPosition = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(positions.latitude, positions.longitude),
          tilt: 59.440717697143555,
          zoom: 14);

      final GoogleMapController googleMapController = await controller.future;
      await googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    }
  }

  Future<void> fetchNearbyPlaces() async {
    var headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBT1HkkjBVBLJVm0pWHdj6WcG_gnUmaoaE',
      'X-Goog-FieldMask':
      'places.displayName,places.formattedAddress,places.location'
    };
    var request = http.Request('POST',
        Uri.parse('https://places.googleapis.com/v1/places:searchNearby'));
    request.body = json.encode({
      "includedTypes": ["restaurant"],
      "maxResultCount": 10,
      "locationRestriction": {
        "circle": {
          "center": {"latitude": 23.763453, "longitude": 90.432533},
          "radius": 1000
        }
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();

      List places = jsonDecode(data)["places"];

      print("places ${places}");

      for (int i = 0; i < places.length; i++) {
        PlaceModel placeModel = PlaceModel.fromJson(places[i]);

        print("placeModel.location.latitude ${placeModel.location.latitude}") ;

        Marker newMarker = Marker(
            markerId:  MarkerId("${markers.length}"),
            icon: await markerIcon(),
            infoWindow: InfoWindow(
              title: placeModel.displayName.text,
              onTap: () => MakePayment.makePaymentSheet(placeModel),

            ),
            position: LatLng(placeModel.location.latitude, placeModel.location.longitude));

        markers.add(newMarker);
      }

      print(markers.length);

      update();
      print(data);
    } else {
      print(response.reasonPhrase);
    }
  }



}