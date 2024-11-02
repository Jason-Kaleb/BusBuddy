import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:busbuddy/consts.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>{
  Location _locationController = new Location();
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  static const LatLng _thokozaPark = const LatLng(-26.26447, 27.88018);
  static const LatLng _placeholder = const LatLng(-26.28573, 27.84957);
  LatLng? _currentPosition = null;

  Map<PolylineId, Polyline> polylines = {};
  @override
  void initState() {
    super.initState();
    getLocationUpdates().then((value)=>{
      getPolylinePoints().then((coordinates)=>{
        generatePolylineFromPoints(coordinates),
      }),
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: _currentPosition == null
            ? const Center(
               child: Text("Loading..."),
              )
          :GoogleMap(
          onMapCreated: ((GoogleMapController controller) =>
              _mapController.complete(controller)),
            initialCameraPosition: CameraPosition(
                target: _thokozaPark,
                zoom: 13),
          markers: {
              Marker(
                markerId: MarkerId("_currentLocation"),
                icon: BitmapDescriptor.defaultMarker,
                position: _currentPosition!,
              ),
              Marker(
                markerId: MarkerId("_sourceLocation"),
                icon: BitmapDescriptor.defaultMarker,
                position: _thokozaPark
              ),
            Marker(
                markerId: MarkerId("_destinationLocation"),
                icon: BitmapDescriptor.defaultMarker,
                position: _placeholder
            ),
          },
          polylines: Set<Polyline>.of(polylines.values),
        ),
    );
  }

  Future<void>_cameraToPostition(LatLng pos) async{
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
        target: pos,
        zoom: 13,
    );
    await controller.animateCamera(
        CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if(_serviceEnabled){
      _serviceEnabled = await _locationController.requestService();
    }else{
      return;
    }
    _permissionGranted = await _locationController.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await _locationController.requestPermission();
      if(_permissionGranted != PermissionStatus.granted){
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation){
      if(currentLocation.latitude !=null && currentLocation.longitude!=null){
        setState(() {
          _currentPosition =LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPostition(_currentPosition!);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async{
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: GOOGLE_MAPS_API_KEY,
        request: PolylineRequest(
            origin: PointLatLng(_thokozaPark.latitude, _thokozaPark.longitude),
            destination: PointLatLng(_placeholder.latitude, _placeholder.longitude),
            mode: TravelMode.driving
        ),
    );
    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point){
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }else{
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }
  void generatePolylineFromPoints(List<LatLng> polylineCoordinates)async{
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 8
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}