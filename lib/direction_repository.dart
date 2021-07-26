import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map_test/direction_model.dart';
import 'package:latlong2/latlong.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<DirectionsModel?> getDirections({
    @required LatLng? userLatLng,
    @required LatLng? businessLatLng,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${userLatLng!.latitude},${userLatLng.longitude}',
        'destination':
            '${businessLatLng!.latitude},${businessLatLng.longitude}',
        'key': 'AIzaSyCAiV6Frxz50whKeyISGm4HduhR10rLutY',
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      // print("Dio Code: ${response.statusCode}");
      //  print("Response Data: ${response.data}");
      return DirectionsModel.fromMap(response.data);
    }
    return null;
  }
}
