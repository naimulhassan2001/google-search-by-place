import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nearby_scarch/view/screen/google_map_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: GoogleMapScreen());
  }
}
