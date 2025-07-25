import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location_report/core/error/extensions.dart';
import 'package:location_report/features/shared/domain/models/location.dart';

part 'report_map_state.dart';

class ReportMapCubit extends Cubit<ReportMapState> {
  final Location _location;

  ReportMapCubit(this._location) : super(ReportMapState.loading()){
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    emit(ReportMapState.loading());
    try {
      final permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        await _location.requestPermission();
      }

      final locationData = await _location.getLocation();
      final address = await getAddressFromLatLng(locationData.latitude!, locationData.longitude!);

      final currentLocation = LocationModel(
        lat: locationData.latitude!,
        long: locationData.longitude!,
        address: address
      );

      emit(Loaded(
        currentLocation: currentLocation,
        markers: {
          Marker(
            markerId: MarkerId('current'),
            position: LatLng(
                locationData.latitude!,
                locationData.longitude!
            ),
            infoWindow: InfoWindow(title: 'You are here'),
          )
        },
      ));
    } catch (e) {
      emit(Error('Failed to get location'));
    }
  }

  void addMarker(LatLng position) async{
    if (state is Loaded) {
      final loadedState = state as Loaded;
      final address = await getAddressFromLatLng(position.latitude, position.longitude);
      final updatedMarkers = Set<Marker>.from(loadedState.markers)
        ..clear()
        ..add(
          Marker(
            markerId: MarkerId('tapped'),
            position: position,
            infoWindow: InfoWindow(title: 'Custom Pin'),
          ),
        );
      emit(loadedState.copyWith(
          markers: updatedMarkers,
          currentLocation: LocationModel(
              lat: position.latitude,
              long: position.longitude,
              address: address
          )
      ));
    }
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      } else {
        return 'No address found';
      }
    } catch (e) {
      ('Error in reverse geocoding: $e').printDebug();
      return 'Failed to get address';
    }
  }

}
