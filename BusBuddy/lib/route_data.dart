import 'package:firebase_database/firebase_database.dart';

class RouteData {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();

  Future<void> saveTrunk1Route() async{
    final Map<String, dynamic> busRouteData = {
      "route_name":"Trunk 1: Thokoza Park to Fashion Square",
      "stops":{
        "stop_1": {"name":"Thokoza Park", "latitude": -26.26447, "longitude":27.88018,"order":1},
        "stop_2": {"name":"Lakeview", "latitude":-26.26303, "longitude":27.88625,"order":2},
        "stop_3": {"name":"Klipspruit Valley", "latitude":-26.26073, "longitude":27.89068,"order":3},
        "stop_4": {"name":"Boomtown", "latitude":-26.24110, "longitude": 27.91509,"order":4},
        "stop_5": {"name":"Orlando Police Station East", "latitude":-26.23877, "longitude":27.91967,"order":5},
        "stop_6": {"name":"Orlando Stadium", "latitude":-26.23255, "longitude":27.92436,"order":6},
        "stop_7": {"name":"Noordgesig Station East", "latitude":-26.22831, "longitude":27.93319,"order":7},
        "stop_8": {"name":"Ghost Town Station", "latitude":-26.23416, "longitude":27.94476,"order":8},
        "stop_9": {"name":"Diepkloof", "latitude":-26.23349, "longitude":27.95382,"order":9},
        "stop_10": {"name":"Diepkloof", "latitude":-26.23349, "longitude":27.95382,"order":10},
        "stop_11": {"name":"Soccer City", "latitude":-26.23138, "longitude":27.98200,"order":11},
        "stop_12": {"name":"Basothong", "latitude":-26.22963, "longitude":28.01079,"order":12},
        "stop_13": {"name":"Mavumbi", "latitude":-26.22911, "longitude":28.02001,"order":13},
        "stop_14": {"name":"Booysens", "latitude":-26.22869, "longitude":28.02090,"order":14},
        "stop_15": {"name":"Chancellor House EastBound", "latitude":-26.20526, "longitude":28.03667,"order":15},
        "stop_16": {"name":"Library Gardens Eastbound", "latitude":-26.20503, "longitude":28.03838,"order":16},
        "stop_17": {"name":"Carlton Eastbound", "latitude":-26.20400, "longitude":28.04753,"order":17},
        "stop_18": {"name":"Fashion Square Northbound", "latitude":-26.20127, "longitude":28.04878,"order":18},
        "stop_19": {"name":"Fashion Square Southbound", "latitude":-26.20091, "longitude":28.05044,"order":19},
        "stop_20": {"name":"Carlton Westbound", "latitude":-26.20503, "longitude":28.03838,"order":20},
        "stop_21": {"name":"Library Gardens Westbound", "latitude":-26.20557, "longitude":28.04110,"order":21},
        "stop_22": {"name":"Chancellor House WestBound", "latitude":-26.20613, "longitude":28.03586,"order":22},
      }
    };
    databaseRef.child("bus_routes/T1").set(busRouteData).then((_){
      print("Trunk 1 route saved to Firebase.");
    }).catchError((error){
      print("Failed to save route: $error");
    });
  }
}