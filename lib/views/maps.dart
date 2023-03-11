import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class maps extends StatefulWidget {
  const maps({Key? key}) : super(key: key);

  @override
  State<maps> createState() => _mapsState();
}

class _mapsState extends State<maps> {

  Position? _currentPosition;
  late GoogleMapController _mapController;
  final Set<Marker> _markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Google Maps"),
            backgroundColor: Colors.green,
          ),
          body: FutureBuilder(
            future: _getCurrentPosition(),
            builder: (context, snapshot) => snapshot.data != null
                ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        snapshot.data!.latitude, snapshot.data!.longitude),
                    zoom: 17),
                onMapCreated: _onMapCreated,
                markers: _markers,
              ),
            )
                : Center(
              child: Text("Error occured!"),
            ),
          ),
        ));
  }

  Future<Position?> _getCurrentPosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _markers.add(Marker(
          markerId: MarkerId("0"),
          position: LatLng(position.latitude, position.longitude)));
      print(position);
      return position;
    } catch (err) {
      print(err.toString());
    }
    return null;
  }
}


