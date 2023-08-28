import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:quds1_flutter/ui/screens/aboutJerusalem.dart';
import 'package:quds1_flutter/ui/screens/fact_screen.dart';
import 'package:quds1_flutter/utils/Colors.dart';
import 'package:quds1_flutter/utils/commonVlaue.dart';
import '../../provider/DLModeProvider.dart';
import 'Home_tap.dart';
import 'addnewPost.dart';
import 'happenedOnThisDay.dart';
import 'maps.dart';

class Buttomnavagation extends StatefulWidget {
  @override
  _ButtomnavagationState createState() => _ButtomnavagationState();
}

class _ButtomnavagationState extends State<Buttomnavagation> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    HomeTap(),
    HappenedOnThisDay(),
    FactScreen(),
    AboutJerusalem(),
  ];

  //Maps(),
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var info = Provider.of<DLModeProvider>(context, listen: true);
    return Scaffold(
      //colors mod darck and lghit
      backgroundColor: info.mode ? BLACK_MODE : WHITE_MODE,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset('images/qudsicon.png'),
        ),
        backgroundColor: Colors.amber,
        // title: const Text('BottomNavigationBar Sample'),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (AddnewPost())),
              );
            },
            icon: Icon(
              Icons.add_circle,
              size: 32,
              color: Colors.white,
            ),
          ),

          //Dark Mode

          Switch(
            value: info.mode,
            onChanged: (value) {
              info.setMode(value);
            },
            activeTrackColor: Colors.yellow,
            activeColor: Colors.orangeAccent,
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: x3,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: x4,
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fact_check_outlined,
              color: Colors.orange,
              size: 35,
            ),
            label: 'Facts',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.circle,
              color: Colors.yellow,
              size: 39,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),

      //Maps FloteBUtton navagation

      floatingActionButton: FloatingActionButton(
        child: x1,
        backgroundColor: Colors.white,
        onPressed: () async {
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
            // Use current location
          });
//////////

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Maps()),
          );
        },
      ),
    );
  }
}
