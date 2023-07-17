import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:location/location.dart';
import 'package:ntsara_local/graphqlConfig/graphql.dart';
import 'package:ntsara_local/graphqlConfig/graphql_requests.dart';

class LocationProvider with ChangeNotifier {
  Future<LocationData?> getUserCurrentLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    _locationData = await location.getLocation();

    return _locationData;
  }

  Future<void> sendLocation({
    required bool isitPrivate,
    required String chatID,
    required String senderID,
  }) async {
    GraphQLClient client = GraphQLConfiguration.clientToQuery();

    LocationData? _locationData = await getUserCurrentLocation();
    if (_locationData != null) {
      try {
        if (isitPrivate) {
          //send location in private chat
          final _location = _locationData.latitude.toString() +
              "|" +
              _locationData.altitude.toString();
          print(_location);
          await client.query(RequestsBuilder.sendMessageMutation(
              chatId: chatID, senderId: senderID, location: _location));

          return;
        } else {
// send location to the group
        }
      } catch (error) {
        print("Erreur when sending newmessage :" + error.toString());
      }
    } else {
      print("No location generated");
    }
  }
}
