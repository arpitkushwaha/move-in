import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SelectedCityScreen extends StatefulWidget {
  final double lat;
  final double lon;
  final String city;
  final String state;

  const SelectedCityScreen({Key key, this.state, this.city, this.lat, this.lon}) : super(key: key);

  @override
  _SelectedCityScreenState createState() => _SelectedCityScreenState();
}

class _SelectedCityScreenState extends State<SelectedCityScreen> {

  CameraPosition _initialCameraPosition;
  LatLng current_lat_long;
  Set<Marker> _markersSet = {};
  GoogleMapController _controller;
  Location _location = Location();
  LocationData current_location_data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialCameraPosition = CameraPosition(target: LatLng(0, 0), zoom: 10.0);
    getCurrentLocationData();
  }

  void getCurrentLocationData() async {
    current_location_data = await _location.getLocation();
    setState(() {
      current_lat_long = LatLng(
          widget.lat, widget.lon);
      _initialCameraPosition = CameraPosition(target: current_lat_long, zoom: 15.0);
      if (_controller != null)
        _controller
            .animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition));

      _markersSet.add(Marker(
        markerId: MarkerId("current"),
        position: current_lat_long,
        infoWindow: InfoWindow(
            title:
            '${current_lat_long.latitude}, ${current_lat_long.longitude}'),
      ));
    });
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(_initialCameraPosition),
    );
  }

  @override
  Widget build(BuildContext context) {
    //User user = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              _buildGoogleMap(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleMap() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 600,
      ),
      child: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        markers: _markersSet,
      ),
    );
  }

}