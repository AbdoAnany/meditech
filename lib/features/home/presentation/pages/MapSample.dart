// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:krage/core/constants/colors.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
// // LatLng(33.285392339939406,44.383401690002344),
// class LatLong {
//   static double?lon = 44.383401690002344;
//   static double?lat = 33.285392339939406;
//   static List<Marker> mark = [];
// }
// class MapScreenLocation extends StatefulWidget {
//
//
//   MapScreenLocation({Key? key }) : super(key: key);
//   @override
//   State<MapScreenLocation> createState() => _MapScreenLocationState();
// }
//
// class _MapScreenLocationState extends State<MapScreenLocation> {
//   MapController mct = MapController();
//
//
//   late Timer timer;
//
//   @override
//   void dispose() {
//
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // if(LatLng == 0 ){
//         print("Get Locations ");
//         getLocation().then((value) {
//           print(value);
//           mct.move(LatLng(value.latitude??LatLong.lat!, value.longitude?? LatLong.lon!), 15.0);
//           LatLong.mark[0] = getMark(lat:value.latitude!, lon: LatLong.lon).first;
//         }).catchError((e){
//           mct.move(LatLng(LatLong.lat!,LatLong.lon!), 15.0);
//
//         });
//     //   }
//       // else{
//       //   print("Not  Get Locations");
//       //   try{
//       //     LatLong.mark[0] = getMark(lat: LatLong.lat, lon: LatLong.lon).first;
//       //
//       //   }catch(e){
//       //     print(e);
//       //   }
//       // }
//       mct.move(LatLng(LatLong.lat!, LatLong.lon!), 15.0);
//       setState(() {
//
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // floatingActionButton: FloatingActionButton(
//       //   mini: true,
//       //   backgroundColor: Color(0xffbddda7),
//       //   onPressed: () {
//       //     getLocation().then((value) {
//       //       mct.moveAndRotate(LatLng(LatLong.lat!, LatLong.lon!), 15.0,10);
//       //       LatLong.mark[0] = getMark(lat: LatLong.lat, lon: LatLong.lon).first;
//       //     });
//       //   },
//       //   child: Icon(Icons.my_location_outlined),
//       // ),
//       body: Container(
//         // decoration: BoxDecoration(
//         //   borderRadius: BorderRadius.circular(5),
//         //   border: Border.all(
//         //       width: 1, color: Theme.of(context).primaryColor),
//         // ),
//         child: FlutterMap(
//           mapController:  mct,
//           options: MapOptions(
//             backgroundColor: AppColors.primary.withOpacity(.1),
//
//             onPositionChanged: (MapCamera position, bool hasGesture) {
//               LatLong.lon = position.center.longitude;
//               LatLong.lat = position.center.latitude;
//
//               setState(() {});
//             },
//             onTap: (TapPosition position, LatLng latLng) async {
//               LatLong.lon = latLng.longitude;
//               LatLong.lat = latLng.latitude;
//               //  List<f.Placemark> placemarks = await f.placemarkFromCoordinates(LatLong.y, LatLong.x);
//               // String? address = '${placemarks[0].country + placemarks[0].street + placemarks[0].postalCode + placemarks[0].locality}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].name}';
//              print("lon"+ LatLong.lon.toString());
//              print("lat"+  LatLong.lat.toString());
//               setState(() {});
//             },
//
//             initialCenter: LatLng(33.285392339939406,44.383401690002344),
//             // zoom: 4.5,
//             // enableScrollWheel: true,
//             // interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
//           ),
//           children: [
//             TileLayer(
//               urlTemplate:
//               'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//               userAgentPackageName: 'dev.fleaflet.flutter_map.example',
//             ),
//             MarkerLayer(
//                 rotate: true,
//                 markers: getMark(lat: LatLong.lat, lon: LatLong.lon)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
// List<Marker> getMark({double?lat, double?lon}) {
//   LatLong.mark = [];
//   LatLong.mark.add(Marker(
//     rotate: true,
//     width: 80.0,
//     height: 80.0,
//     point: LatLng(lat!, lon!),
//     // Latitude and longitude coordinates
//     child:  Container(
//       child: const Icon(Icons.location_on, color: Colors.red, size: 30),
//     ),
//   ));
//   return LatLong.mark;
// }
// Future<LocationData> getLocation() async {
//   Location location = Location();
//
//   bool _serviceEnabled;
//   PermissionStatus _permissionGranted;
//   LocationData _locationData;
//
//   _serviceEnabled = await location.serviceEnabled();
//
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//
//     if (!_serviceEnabled) {}
//   }
//
//   _permissionGranted = await location.hasPermission();
//
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {}
//   }
//   _locationData = await location.getLocation();
//   LatLong.lat = _locationData.latitude;
//   LatLong.lon = _locationData.longitude;
//
//   return _locationData;
// }
