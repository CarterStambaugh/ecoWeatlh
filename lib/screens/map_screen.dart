import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flash_chat/utilities/location.dart';
import 'package:search_map_place/search_map_place.dart';
import 'dart:async';

class MapScreen extends StatefulWidget {
  static const String id = 'account_screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(33.6846, -117.8265);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  BitmapDescriptor pinLocationIcon;

  static final CameraPosition _position1 = CameraPosition(
    bearing: 192.833,
    target: LatLng(33.6846, -117.8265),
    tilt: 59.440,
    zoom: 11.0,
  );

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
              title: 'This is a Title', snippet: 'This is a snippet'),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.lightBlueAccent,
      child: Icon(
        icon,
        size: 40,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            new ImageConfiguration(
              devicePixelRatio: 2.5,
            ),
            'assets/images/trash.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(-20.3000, -40.2990),
    zoom: 14.0000,
  );


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          mapType: _currentMapType,
          // markers: _markers,
          myLocationButtonEnabled: false,
          onCameraMove: _onCameraMove,
        ),
      
      ],
    );
  }
}

/*
 Padding(
          padding: EdgeInsets.only(top: 50, right: 16),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                button(_onMapTypeButtonPressed, Icons.map),
                SizedBox(
                  height: 16.0,
                ),
                button(_onAddMarkerButtonPressed, Icons.add_location),
                SizedBox(
                  height: 16.0,
                ),
                button(_goToPosition1, Icons.location_searching),
              ],
            ),
          ),
        )*/
