import 'dart:async';

import 'package:busbuddy/consts.dart';
import 'package:busbuddy/views/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Location _locationController = Location();

  LatLng _initialPosition = LatLng(-26.26440,27.88017);
  LatLng? _currentPosition;

  MapController mapController = MapController();


  bool _firstLocationUpdate = true;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(
        child: Center(child: const CustomDrawer()),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: _initialPosition,
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate : "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a','b','c'],
                additionalOptions: {
                  'attribution': "© OpenStreetMap contributors",
                },
              ),
              MarkerLayer(
                markers: [
                  if (_currentPosition != null)
                    Marker(
                      point:  _currentPosition!,
                      builder: (ctx) => const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  Marker(
                    point: _initialPosition,
                    builder: (ctx) => const Icon(
                      Icons.location_pin,
                      color: Colors.blue,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 15,
            top: 50,
            child: Ink(
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                iconSize: 35.0,
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getLocationUpdates() async{
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if(!serviceEnabled){
      serviceEnabled = await _locationController.requestService();
      if(!serviceEnabled) return;
    }

    permissionGranted = await _locationController.hasPermission();
    if(permissionGranted == PermissionStatus.denied){
      permissionGranted = await _locationController.requestPermission();
      if(permissionGranted != PermissionStatus.granted){
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation){
      if (currentLocation.latitude !=null && currentLocation.longitude != null){
        setState(() {
          _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        if(_firstLocationUpdate){
          mapController.move(_currentPosition!, 13.0);
          _firstLocationUpdate = false;
        }
        print("Initial Position: $_initialPosition");
        print("Current Position: $_currentPosition");
      }
    });
  }

  }