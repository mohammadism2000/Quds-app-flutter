
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show cos, sqrt, asin; 


const LatLng  latLngQuds = LatLng(31.768202, 35.214273);


 //position camera to quds Location 
const CameraPosition kGooglePlex = CameraPosition(
    target: latLngQuds,
    zoom:9.4746,
    tilt: 20.440717697143555,
    
  );


//marke to Quds
    const Marker quds_marke = Marker(
        markerId: MarkerId('1'),
        position: LatLng(31.768202, 35.214273),
        icon: BitmapDescriptor.defaultMarker);

 
 //marker to my location 
      Marker my_marke (LatLng latlong)=> Marker(
        markerId: MarkerId('2'),
        position: latlong,
        icon: BitmapDescriptor.defaultMarker);


//funtion to navigatie in quds
Future<void> goToQuds(Completer thicontroller) async {
    final GoogleMapController controller = await thicontroller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
  }

  

  //funtion to navigatie in my location 
  Future<void> gotoMyLocation(Completer thicontroller , LatLng latLng) async {
    final GoogleMapController controller = await thicontroller.future;

    CameraPosition _localkGooglePlex = CameraPosition(
    target:latLng,
    zoom:14.4746,
    tilt: 20.440717697143555,
    
  );

    controller.animateCamera(CameraUpdate.newCameraPosition(_localkGooglePlex));
  }


 //calculate distans between to gioPoint
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }