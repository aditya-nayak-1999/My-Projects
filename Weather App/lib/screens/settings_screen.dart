import 'package:flutter/material.dart';
import '../services/shared_preferences_service.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String unitOfMeasurement = 'Metric'; 

  @override
  void initState() {
    super.initState();
    _loadUnitOfMeasurement();
  }

  void _loadUnitOfMeasurement() async {
    unitOfMeasurement = await SharedPreferencesService.getUnitOfMeasurement();
    setState(() {});
  }

  void _changeUnitOfMeasurement() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Unit of Measurement", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("Metric", style: TextStyle(fontSize: 18)),
                onTap: () async {
                  await SharedPreferencesService.setUnitOfMeasurement('Metric');
                  setState(() {
                    unitOfMeasurement = 'Metric';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Imperial", style: TextStyle(fontSize: 18)),
                onTap: () async {
                  await SharedPreferencesService.setUnitOfMeasurement('Imperial');
                  setState(() {
                    unitOfMeasurement = 'Imperial';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAboutInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("About SimpleWeather", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Text("SimpleWeather Version 1.0.0 \n© 2023 SimpleWeather Inc.", style: TextStyle(fontSize: 18)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Unit of Measurement', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            subtitle: Text(unitOfMeasurement, style: TextStyle(fontSize: 18)),
            onTap: _changeUnitOfMeasurement,
          ),
          ListTile(
            title: Text('About', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            onTap: _showAboutInfo,
          ),
        ],
      ),
    );
  }
}
