import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
 Future<Map<String, dynamic>?> getCurrentLocationWithCoords() async {
   LocationPermission permission = await Geolocator.checkPermission();

   if(permission == LocationPermission.denied){
     permission = await Geolocator.requestPermission();
     if(permission == LocationPermission.denied){
       return null;
     }
   }
   if(permission == LocationPermission.deniedForever){
     return null;
   }
   final position = await Geolocator.getCurrentPosition();

   final placemarks = await placemarkFromCoordinates(
       position.latitude,
       position.longitude,
   );
   if(placemarks.isEmpty) return null;
   final place = placemarks.first;
   final cityName =place.locality ?? place.administrativeArea ?? 'Unknown';
   return {
     'name': cityName,
     'lat': position.latitude,
     'lon': position.longitude,
   };
 }
}