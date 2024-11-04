import 'dart:async';
import 'package:flutter/material.dart';
import 'package:busbuddy/consts.dart';
import 'package:busbuddy/views/custom_drawer.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:firebase_database/firebase_database.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Location _locationController = Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  static LatLng _placeholder = const LatLng(-26.28573, 27.84957);
  LatLng? _currentPosition;
  //LatLng? _destinationPosition;

  Map<PolylineId, Polyline> polylines = {};
  List<Map<String, dynamic>> _busStops = [];

  List<String> _filteredBusStopNames = [];
  bool _showSearch = true;

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then((value) => {
          getPolylinePoints().then((coordinates) => {
                generatePolylineFromPoints(coordinates),
              }),
        });
    fetchBusStopNames().then((busStops) {
      setState(() {
        _busStops = busStops;
      });
    });
  }

  Widget _buildSearchFeature() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search for a bus stop',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (query) {
              setState(() {
                _filteredBusStopNames = _busStops
                    .where((stop) =>
                        stop['name'] != null &&
                        stop['name']
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .map((stop) => stop['name'] as String)
                    .toList();
              });
            },
          ),
          if (_filteredBusStopNames.isNotEmpty)
            Container(
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredBusStopNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredBusStopNames[index]),
                    onTap: () async {
                      final coordinates = await getCoordinatesForBusStop(
                          _filteredBusStopNames[index]);
                      if (coordinates != null) {
                        setState(() {
                          _placeholder = coordinates;
                        });
                        _cameraToPosition(coordinates);
                      }
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showSearch = false;
              });
              Navigator.pop(context);
            },
            child: const CustomDrawer(),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
            setState(() {
              _showSearch = false;
            });
          },
        ),
        title: const Text('Map Page'),
        actions: [
          IconButton(
            icon: Icon(_showSearch ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _showSearch = !_showSearch;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showSearch = false;
              });
            },
            child: _currentPosition == null
                ? const Center(child: Text("Loading..."))
                : GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _mapController.complete(controller);
                      _cameraToPosition(_currentPosition!);
                    },
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition!,
                      zoom: 13,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("_currentLocation"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: _currentPosition!,
                      ),
                      Marker(
                        markerId: const MarkerId("_destinationLocation"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: _placeholder,
                      ),
                    },
                    polylines: Set<Polyline>.of(polylines.values),
                  ),
          ),
          if (_showSearch)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildSearchFeature(),
            ),
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
        getPolylinePoints().then((coordinates) {
          generatePolylineFromPoints(coordinates);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: GOOGLE_MAPS_API_KEY,
      request: PolylineRequest(
          origin: PointLatLng(
              _currentPosition!.latitude, _currentPosition!.longitude),
          destination:
              PointLatLng(_placeholder.latitude, _placeholder.longitude),
          mode: TravelMode.driving),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolylineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.deepOrange,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }

  Future<List<Map<String, dynamic>>> fetchBusStopNames() async {
    final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    final snapshot = await databaseRef.child('bus_routes/T1/stops').get();

    List<Map<String, dynamic>> busStops = [];

    if (snapshot.exists) {
      Map<String, dynamic> stops =
          Map<String, dynamic>.from(snapshot.value as Map);

      for (var stop in stops.values) {
        if (stop['name'] != null &&
            stop['latitude'] != null &&
            stop['longitude'] != null) {
          busStops.add({
            'name': stop['name'],
            'latitude': stop['latitude'],
            'longitude': stop['longitude'],
          });
        }
      }
    }

    return busStops;
  }

  Future<LatLng?> getCoordinatesForBusStop(String busStopName) async {
    final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    final snapshot = await databaseRef.child('bus_routes/T1/stops').get();

    if (snapshot.exists) {
      Map<String, dynamic> stops =
          Map<String, dynamic>.from(snapshot.value as Map);

      for (var stop in stops.values) {
        if (stop['name'] == busStopName &&
            stop['latitude'] != null &&
            stop['longitude'] != null) {
          double latitude = double.parse(stop['latitude'].toString());
          double longitude = double.parse(stop['longitude'].toString());
          return LatLng(latitude, longitude);
        }
      }
    }
    return null; // Return null if the bus stop or coordinates aren't found
  }
}
