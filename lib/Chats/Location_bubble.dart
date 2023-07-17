import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:ntsara_local/CustomWidget/Pop-Up_screen.dart';
import 'package:ntsara_local/assets/Mycolors.dart';

class LocationBubble extends StatelessWidget {
  final Coords location;
  final DateTime createdAt;
  final bool thisMe;

  const LocationBubble({
    Key? key,
    required this.location,
    required this.createdAt,
    required this.thisMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Column(
        children: [
          Icon(
            Icons.location_on,
            color: thisMe ? myWhite : myKingGreen,
          ),
          Text(
            "Location",
            style: TextStyle(
              color: thisMe ? myWhite : myKingGreen,
            ),
          )
        ],
      ),
      onPressed: () async {
        //check all teh available app maps in the smartphone
        final _availableMaps = await MapLauncher.installedMaps;
        //Add them of the list in order to displey to user
        List<OptionPopUp> _listOfOptionPopUp = [];
        for (AvailableMap item in _availableMaps) {
          _listOfOptionPopUp.add(OptionPopUp(item.mapName, () async {
            //launch the map app
            await MapLauncher.showMarker(
                mapType: item.mapType,
                coords: Coords(location.latitude, location.longitude),
                title: _availableMaps.first.mapName);
          }));
        }
        //let user choose the app to launch the coordinate on it
        popUPScreen(context, "Maps", _listOfOptionPopUp);
      },
    );
  }
}
