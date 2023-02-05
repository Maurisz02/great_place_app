import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_heper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImgUrl;

  Future<void> _getUserCurrentLocation() async {
    final locData = await Location()
        .getLocation(); //contains current location longitude,latitude
    final staticMapImgUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);
    print('${locData.latitude}  ${locData.longitude}');

    setState(() {
      _previewImgUrl = staticMapImgUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        //creates on fly because of the pop method after chose a place
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImgUrl == null
              ? Text(
                  'No location selected yet',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImgUrl,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text(
                'Current Location',
              ),
              onPressed: _getUserCurrentLocation,
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text(
                'Select on map',
              ),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
