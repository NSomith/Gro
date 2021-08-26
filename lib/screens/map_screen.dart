import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/location_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);
  static const String id = 'map_screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng currentPosition;
  GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);
    setState(() {
      currentPosition = LatLng(locationData.latitude, locationData.longitude);
    });
    void onCreate(GoogleMapController controller) {
      setState(() {
        googleMapController = controller;
      });
    }

    return Container(
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: currentPosition, zoom: 14.4746),
            zoomControlsEnabled: false,
            minMaxZoomPreference: MinMaxZoomPreference(1.5, 20.8),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            mapToolbarEnabled: true,
            onCameraMove: (CameraPosition position) {
              locationData.onCameraMove(position);
            },
            onMapCreated: onCreate,
            onCameraIdle: locationData.getMoveCamera,
          ),
          Center(
            child: Container(
              child: Image.asset('images/marker.png'),
              height: 50,
              margin: EdgeInsets.only(bottom: 40),
            ),
          ),
          Positioned(
            bottom: 0.0,
              child: Container(
                height: 200,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(children: [
              Text(locationData.selectAddress.featureName),
              Text(locationData.selectAddress.addressLine)
            ],),
          ))
        ],
      ),
    );
  }
}
