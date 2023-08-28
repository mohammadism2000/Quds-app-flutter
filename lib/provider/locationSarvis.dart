import 'dart:async';
import 'package:location/location.dart';

class StreemBloc {
  late LocationData myLocation;
  StreamController<LocationData> streamController =
      StreamController<LocationData>();
  StreemBloc() {
    setMyLocation();
  }

  stopStream() {
    streamController.close();
  }

  void setMyLocation() async {
    LocationData myLocation;

    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    print('location data ${_locationData.latitude}');

    location.onLocationChanged.listen((LocationData currentLocation) {
      myLocation = currentLocation;
      streamController.sink.add(myLocation);
    });
  }

  Stream<LocationData> get mystem => streamController.stream;
}
