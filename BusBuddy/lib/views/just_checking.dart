import 'dart:async';

import 'package:busbuddy/consts.dart';
import 'package:busbuddy/views/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapViews extends StatefulWidget {
  const MapViews({super.key});

  @override
  State<MapViews> createState() => _MapViewState();
}

class _MapViewState extends State<MapViews> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(26.2894, 27.8956);
  static const LatLng _pGoudStreet = LatLng(26.2965, 27.8960);
  static const LatLng _pSouthgate = LatLng(-26.263962, 27.985898);
  LatLng? _currentPosition;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then(
          (coodinates) => {
            generatePolylineFromPoints(coodinates),
          },
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _currentPosition == null
        ? const Center(
            child: Text("Loading..."),
          )
        : Scaffold(
            key: _scaffoldKey,
            drawer: const CustomDrawer(),
            body: Stack(
              children: [
                Center(
                  child: GoogleMap(
                    onMapCreated: ((GoogleMapController controller) => {
                          if (!_mapController.isCompleted)
                            {_mapController.complete(controller)},
                        }),
                    initialCameraPosition: const CameraPosition(
                      target: _pGooglePlex,
                      zoom: 20,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("_currentLocation"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: _currentPosition!,
                      ),
                      const Marker(
                        markerId: MarkerId("_sourceLocation"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: _pGoudStreet,
                      ),
                      const Marker(
                        markerId: MarkerId("_destinationLocation"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: _pSouthgate,
                      )
                    },
                    polylines: Set<Polyline>.of(polylines.values),
                  ),
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
                )
              ],
            ),
          );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();

    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentPosition =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        _cameraToPosition(_currentPosition!);
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: GOOGLE_MAPS_API_KEY,
      request: PolylineRequest(
        origin: PointLatLng(_pGoudStreet.latitude, _pGoudStreet.longitude),
        destination: PointLatLng(_pSouthgate.latitude, _pSouthgate.longitude),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolylineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 8,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}
