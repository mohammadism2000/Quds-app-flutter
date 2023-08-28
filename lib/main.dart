import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quds1_flutter/provider/DLModeProvider.dart';
import 'package:quds1_flutter/provider/LocationProvider.dart';
import 'package:quds1_flutter/provider/happenOnDayProvider.dart';
import 'package:quds1_flutter/ui/screens/Buttomnavagation.dart';
import 'package:quds1_flutter/ui/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider>[
        ChangeNotifierProvider<LocationProvider>(
            create: (BuildContext context) =>
                LocationProvider(myLocation: LatLng(10.000002, 12.00001))),
        ChangeNotifierProvider<HappenOnDayProvider>(
            create: (BuildContext context) => HappenOnDayProvider(
                dicreption: "حدث في مثل هذا اليوم", video: "")),
        ChangeNotifierProvider<DLModeProvider>(
            create: (BuildContext context) => DLModeProvider(mode: false)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirebaseAuth.instance.currentUser == null
            ? LoginScreen()
            : Buttomnavagation(),
      ),
    );
  }
}
