import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'dart:async';

import 'customization_page.dart';
import 'map_page.dart';

class SpeedometerPage extends StatefulWidget {
  const SpeedometerPage({Key? key}) : super(key: key);

  @override
  _SpeedometerPageState createState() => _SpeedometerPageState();
}

class _SpeedometerPageState extends State<SpeedometerPage> {
  double _currentSpeed = 0;
  GlobalKey<KdGaugeViewState> key = GlobalKey<KdGaugeViewState>();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Location permission denied'),
            content: const Text('Please enable location permissions in the settings.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    } else if (permission == LocationPermission.deniedForever) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Location permission permanently denied'),
            content: const Text('Please enable location permissions in the settings.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    } else {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentSpeed = position.speed ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Speedometer'),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpeedometerCustomization(
                      onSpeedChange: (double speed) {
                        setState(() {
                          _currentSpeed = speed;
                        });
                      },
                      primaryColor: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Speedometer',
                icon: Icon(Icons.speed),
              ),
              Tab(
                text: 'Map',
                icon: Icon(Icons.map),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: KdGaugeView(
                key: key,
                minSpeed: 0,
                maxSpeed: 280,
                speed: _currentSpeed,
                unitOfMeasurement: "km/h",
                animate: true,
                gaugeWidth: 20,
              ),
            ),
            MapSample(),
          ],
        ),
      ),
    );
  }
}
