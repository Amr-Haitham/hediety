// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:permission_handler/permission_handler.dart';

// class SavedRoutesScreen extends StatefulWidget {
//   @override
//   _SavedRoutesScreenState createState() => _SavedRoutesScreenState();
// }

// class _SavedRoutesScreenState extends State<SavedRoutesScreen> {
//   String _latitude = "";
//   String _longitude = "";
//   String _manualLatitude = "";
//   String _manualLongitude = "";
//   String _address = "Press the button to fetch your location.";
//   List<String> _savedRoutes = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedRoutes();
//   }

//   // Fetch user's location
//   Future<void> _fetchLocation() async {
//     if (await Permission.location.request().isGranted) {
//       try {
//         Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high,
//         );

//         setState(() {
//           _latitude = position.latitude.toString();
//           _longitude = position.longitude.toString();
//         });
//         await _fetchAddress(position.latitude, position.longitude);
//       } catch (e) {
//         setState(() {
//           _address = "Error fetching location: $e";
//         });
//       }
//     } else {
//       setState(() {
//         _address = "Location permission denied.";
//       });
//     }
//   }

//   // Fetch address from latitude and longitude
//   Future<void> _fetchAddress(double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(latitude, longitude);
//       Placemark place = placemarks.first;
//       setState(() {
//         _address =
//             "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//       });
//     } catch (e) {
//       setState(() {
//         _address = "Error fetching address: $e";
//       });
//     }
//   }

//   // Save the current route
//   Future<void> _saveRoute() async {
//     if (_latitude.isNotEmpty && _longitude.isNotEmpty) {
//       String route = "Lat: $_latitude, Lon: $_longitude, Address: $_address";
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       _savedRoutes.add(route);
//       await prefs.setStringList('savedRoutes', _savedRoutes);
//       setState(() {}); // Refresh the list
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Fetch location before saving.")),
//       );
//     }
//   }

//   // Save the manually entered route
//   Future<void> _saveManualRoute() async {
//     if (_manualLatitude.isNotEmpty && _manualLongitude.isNotEmpty) {
//       double? lat = double.tryParse(_manualLatitude);
//       double? lon = double.tryParse(_manualLongitude);

//       if (lat != null && lon != null) {
//         await _fetchAddress(lat, lon);
//         String route = "Lat: $lat, Lon: $lon, Address: $_address";
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         _savedRoutes.add(route);
//         await prefs.setStringList('savedRoutes', _savedRoutes);
//         setState(() {}); // Refresh the list
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Enter valid latitude and longitude.")),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Fill both latitude and longitude fields.")),
//       );
//     }
//   }

//   // Load saved routes
//   Future<void> _loadSavedRoutes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _savedRoutes = prefs.getStringList('savedRoutes') ?? [];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Saved Routes App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Current Location:",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             SizedBox(height: 8),
//             Text("Latitude: $_latitude"),
//             Text("Longitude: $_longitude"),
//             Text("Address: $_address"),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _fetchLocation,
//               child: Text("Fetch Location"),
//             ),
//             ElevatedButton(
//               onPressed: _saveRoute,
//               child: Text("Save Route"),
//             ),
//             Divider(),
//             Text(
//               "Manual Entry:",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: "Latitude"),
//               keyboardType: TextInputType.number,
//               onChanged: (value) {
//                 _manualLatitude = value;
//               },
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: "Longitude"),
//               keyboardType: TextInputType.number,
//               onChanged: (value) {
//                 _manualLongitude = value;
//               },
//             ),
//             ElevatedButton(
//               onPressed: _saveManualRoute,
//               child: Text("Save Manual Route"),
//             ),
//             Divider(),
//             Text(
//               "Saved Routes:",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _savedRoutes.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     leading: Icon(Icons.location_on),
//                     title: Text(_savedRoutes[index]),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
