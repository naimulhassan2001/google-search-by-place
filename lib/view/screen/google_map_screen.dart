import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/google_map_controller.dart';
import '../component/google_map.dart';

class GoogleMapScreen extends StatelessWidget {
  GoogleMapScreen({super.key});

  ShowGoogleMapController controller = Get.put(ShowGoogleMapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Places'),
      ),
      body: GetBuilder<ShowGoogleMapController>(
        builder: (controller) => ShowGoogleMap(
          onTapLatLong: (value) => print(value),
        ),
      ),
    );
  }
}
