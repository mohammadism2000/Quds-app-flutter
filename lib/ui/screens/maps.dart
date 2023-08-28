import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../provider/LocationProvider.dart';
import '../../utils/mapsMethods.dart';

class Maps extends StatefulWidget {
  const Maps();
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor? customIcon;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var info = Provider.of<LocationProvider>(context, listen: true);
    info.setMyLocation();

    Set<Marker> markers = {};

    markers.add(quds_marke);
    markers.add(my_marke(info.myLocation));

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: markers,
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      gotoMyLocation(_controller, info.myLocation);
                    },
                    backgroundColor: Colors.blue,
                  ),
                  SizedBox(height: 15),
                  FloatingActionButton.extended(
                    onPressed: () {
                      goToQuds(_controller);
                    },
                    label: Text('انتقل الي القدس '),
                    icon: SvgPicture.asset('images/location_icon.svg'),
                  ),
                ],
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.amber,
                  child: Text(
                    'بعدك عن الاقصي \n ${calculateDistance(info.myLocation.latitude, info.myLocation.longitude, latLngQuds.latitude, latLngQuds.longitude)} /KM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

// /