import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> fetchNearbyPlaces(double latitude, double longitude) async {
    const String apiKey = 'AIzaSyAJrp3VvbO4E4jo7HRgqsk7EP8mPIZStxQ';
    const String baseUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    final String requestUrl =
        '$baseUrl?location=$latitude,$longitude&radius=1500&type=restaurant&key=$apiKey';

    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List places = data['results'];
      print('name');
      places.forEach((place) {
        print(place['name']);
      });
    } else {
      throw Exception('Failed to fetch places');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchNearbyPlaces(37.7749, -122.4194); // San Francisco, CA coordinates
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nearby Places'),
        ),
        body: const Center(
          child: Text('Check console for results'),
        ),
      ),
    );
  }
}
