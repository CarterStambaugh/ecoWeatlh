

import 'package:geolocator/geolocator.dart';
import 'global_data.dart';
import 'package:provider/provider.dart';

double longitude;
double latitude;

// Provider.of<GlobalData>(context).stories.length + 1

class Location {
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
