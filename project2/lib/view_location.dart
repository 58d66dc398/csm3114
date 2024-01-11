import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationPickerPage extends StatefulWidget {
  final Map<String, dynamic>? coordinates;

  const LocationPickerPage({super.key, this.coordinates});

  @override
  State<StatefulWidget> createState() {
    return _LocationPickerPageState();
  }
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  late LatLng pos = (widget.coordinates != null)
      ? LatLng.fromJson(widget.coordinates!)
      : const LatLng(10, 0);
  double z = 5;
  late Marker? marker = (widget.coordinates != null)
      ? Marker(
          point: pos,
          child: IconButton(
            onPressed: () {
              setState(() {
                marker = null;
              });
            },
            icon: const Icon(Icons.location_on),
          ),
        )
      : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Location')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: pos,
          initialZoom: z,
          // https://stackoverflow.com/questions/67464084
          onTap: (TapPosition tapPos, LatLng pos) {
            if (kDebugMode) {
              print('DEBUG: ${pos.toJson()}');
            }
            this.pos = pos;
            setState(() {
              marker = Marker(
                point: pos,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      marker = null;
                    });
                  },
                  icon: const Icon(Icons.location_on),
                ),
              );
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.citawarisan.haulier',
          ),
          RichAttributionWidget(
            alignment: AttributionAlignment.bottomLeft,
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => launchUrl(
                  Uri.parse('https://openstreetmap.org/copyright'),
                ),
              ),
            ],
          ),
          MarkerLayer(markers: [if (marker != null) marker!]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (marker != null)
            ? () => Navigator.pop(context, pos.toJson())
            : null,
        child: const Icon(Icons.check),
      ),
    );
  }
}
