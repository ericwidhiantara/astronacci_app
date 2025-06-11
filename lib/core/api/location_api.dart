import 'dart:math';

import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

part 'location_api.freezed.dart';
part 'location_api.g.dart';

class LocationApi {
  Future<Position> determineLocation(BuildContext context) async {
    log.i("determineLocation");
    bool serviceEnabled;
    late LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && context.mounted) {
      await showCustomDialog(
        context: context,
        title: "Gagal",
        description: "GPS nonaktif, silakan aktifkan GPS anda terlebih dahulu",
        onConfirm: () {
          Geolocator.openLocationSettings();
        },
      );

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied && context.mounted) {
        await showCustomDialog(
          context: context,
          title: "Gagal",
          description:
              "Izin menggunakan lokasi tidak diberikan, silakan cek pengaturan perangkat anda",
          textConfirm: "Coba Lagi",
          onConfirm: () async {
            await Geolocator.requestPermission();
          },
        );
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever && context.mounted) {
      await showCustomDialog(
        context: context,
        title: "Gagal",
        description:
            "Izin menggunakan lokasi tidak diberikan, silakan cek pengaturan perangkat anda",
        textConfirm: "Pengaturan",
        onConfirm: () {
          Geolocator.openLocationSettings();
        },
      );
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      ),
    );
  }

  Future<void> showCustomDialog({
    required BuildContext context,
    required String title,
    required String description,
    String textConfirm = "OK",
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: onConfirm,
              child: Text(textConfirm),
            ),
          ],
        );
      },
    );
  }

  Future<LocationModel> getAddressByCoordinates(double lat, double lon) async {
    log.i("getAddressByCoordinates");
    try {
      await setLocaleIdentifier("id");
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(lat, lon);

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks[0];

        return LocationModel(
          lat: lat,
          lon: lon,
          address: Address(
            road: place.street,
            cityBlock: place.subLocality,
            neighbourhood: place.subAdministrativeArea,
            suburb: place.subLocality,
            cityDistrict: place.administrativeArea,
            city: place.locality,
            region: place.administrativeArea,
            postcode: place.postalCode,
            country: place.country,
            countryCode: place.isoCountryCode,
          ),
          displayName:
              "${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country} - ${place.postalCode}",
        );
      }
      return LocationModel();
      //
      // final String url =
      //     "https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon";
      // log.i("url $url");
      // final Dio dio = Dio(
      //   BaseOptions(
      //     validateStatus: (int? status) {
      //       return status != null;
      //       // return status != null && status >= 200 && status < 300;
      //     },
      //   ),
      // );
      //
      // final Response response = await dio.get(url);
      //
      // log.i("response ${response.data}");
      // if (response.statusCode == 200) {
      //   return LocationModel.fromJson(response.data as Map<String, dynamic>);
      // }
    } catch (e) {
      throw e.toString();
    }
  }

  double getDistance(LatLng eventLocation, LatLng userLocation) {
    final double lat1 = eventLocation.latitude;
    final double lon1 = eventLocation.longitude;
    final double lat2 = userLocation.latitude;
    final double lon2 = userLocation.longitude;

    const R = 6371e3; // metres
    // var R = 1000;
    final phi1 = (lat1 * pi) / 180; // φ, λ in radians
    final phi2 = (lat2 * pi) / 180;
    final deltaPhi = ((lat2 - lat1) * pi) / 180;
    final deltaLambda = ((lon2 - lon1) * pi) / 180;

    final a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final d = R * c; // in metres

    return d;
  }
}

@freezed
abstract class LocationModel with _$LocationModel {
  factory LocationModel({
    @JsonKey(name: 'place_id') int? placeId,
    @JsonKey(name: 'licence') String? licence,
    @JsonKey(name: 'osm_type') String? osmType,
    @JsonKey(name: 'osm_id') int? osmId,
    @JsonKey(name: 'lat') double? lat,
    @JsonKey(name: 'lon') double? lon,
    @JsonKey(name: 'class') String? classType,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'place_rank') int? placeRank,
    @JsonKey(name: 'importance') double? importance,
    @JsonKey(name: 'addresstype') String? addresstype,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'address') Address? address,
    @JsonKey(name: 'boundingbox') List<String>? boundingbox,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}

@freezed
abstract class Address with _$Address {
  factory Address({
    @JsonKey(name: 'road') String? road,
    @JsonKey(name: 'city_block') String? cityBlock,
    @JsonKey(name: 'neighbourhood') String? neighbourhood,
    @JsonKey(name: 'suburb') String? suburb,
    @JsonKey(name: 'city_district') String? cityDistrict,
    @JsonKey(name: 'city') String? city,
    @JsonKey(name: 'ISO3166-2-lvl4') String? iso31662Lvl4,
    @JsonKey(name: 'region') String? region,
    @JsonKey(name: 'ISO3166-2-lvl3') String? iso31662Lvl3,
    @JsonKey(name: 'postcode') String? postcode,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'country_code') String? countryCode,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
