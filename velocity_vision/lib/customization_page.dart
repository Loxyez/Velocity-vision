import 'package:flutter/material.dart';

class SpeedometerCustomization extends StatefulWidget {
  final Function(double speed) onSpeedChange;
  final Color primaryColor;

  SpeedometerCustomization({
    required this.onSpeedChange,
    required this.primaryColor,
  });

  @override
  _SpeedometerCustomizationState createState() => _SpeedometerCustomizationState();
}

class _SpeedometerCustomizationState extends State<SpeedometerCustomization> {
  late double _currentSpeed;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentSpeed = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Gauge Speed:',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Current Speed',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _currentSpeed = double.tryParse(value) ?? 0;
                  });
                  widget.onSpeedChange(_currentSpeed);
                },
              ),
              const SizedBox(height: 16.0),
              Text(
                'Dark Mode:',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 8.0),
              SwitchListTile(
                title: const Text('Use Dark Mode'),
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) {
                  setState(() {
                    if (value) {
                      ThemeMode.dark;
                    } else {
                      ThemeMode.light;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
