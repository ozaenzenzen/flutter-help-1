// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'dart:io';

// import 'package:flutter/foundation.dart';

// class LocationTest extends StatelessWidget {
//   const LocationTest({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(''),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 16),
//             PermissionStatusWidget(),
//             Divider(height: 32),
//             ServiceEnabledWidget(),
//             Divider(height: 32),
//             GetLocationWidget(),
//             Divider(height: 32),
//             ListenLocationWidget(),
//             Divider(height: 32),
//             ChangeSettings(),
//             Divider(height: 32),
//             ChangeNotificationWidget()
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PermissionStatusWidget extends StatefulWidget {
//   @override
//   State<PermissionStatusWidget> createState() => _PermissionStatusWidgetState();
// }

// class _PermissionStatusWidgetState extends State<PermissionStatusWidget> {
//   PermissionStatus _permissionGranted = PermissionStatus.granted;

//   Future<void> _checkPermissions() async {
//     final permissionGrantedResult = await Location.instance.hasPermission();
//     setState(() {
//       _permissionGranted = permissionGrantedResult;
//     });
//   }

//   Future<void> _requestPermission() async {
//     final permissionRequestedResult =
//         await Location.instance.requestPermission();
//     setState(() {
//       _permissionGranted = permissionRequestedResult;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'Permission status: $_permissionGranted',
//             style: Theme.of(context).textTheme.bodyText1,
//           ),
//           Row(
//             children: <Widget>[
//               Container(
//                 margin: const EdgeInsets.only(right: 42),
//                 child: ElevatedButton(
//                   onPressed: _checkPermissions,
//                   child: const Text('Check'),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed:
//                     _permissionGranted == true ? null : _requestPermission,
//                 child: const Text('Request'),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class ServiceEnabledWidget extends StatefulWidget {
//   @override
//   State<ServiceEnabledWidget> createState() => _ServiceEnabledWidgetState();
// }

// class _ServiceEnabledWidgetState extends State<ServiceEnabledWidget> {
//   bool? _serviceEnabled;

//   bool? _networkEnabled;

//   Future<void> _checkService() async {
//     final serviceEnabledResult = await Location.instance.serviceEnabled();
//     setState(() {
//       _serviceEnabled = serviceEnabledResult;
//     });
//   }

//   Future<void> _checkNetworkService() async {
//     final serviceEnabledResult = await Location.instance.requestService();
//     setState(() {
//       _networkEnabled = serviceEnabledResult;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'GPS enabled: ${_serviceEnabled ?? "unknown"}',
//             style: Theme.of(context).textTheme.bodyText1,
//           ),
//           Row(
//             children: <Widget>[
//               Container(
//                 margin: const EdgeInsets.only(right: 42),
//                 child: ElevatedButton(
//                   onPressed: _checkService,
//                   child: const Text('Check'),
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             'Service enabled: ${_networkEnabled ?? "unknown"}',
//             style: Theme.of(context).textTheme.bodyText1,
//           ),
//           Row(
//             children: <Widget>[
//               Container(
//                 margin: const EdgeInsets.only(right: 42),
//                 child: ElevatedButton(
//                   onPressed: _checkNetworkService,
//                   child: const Text('Check'),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class ListenLocationWidget extends StatefulWidget {
//   @override
//   State<ListenLocationWidget> createState() => _ListenLocationWidgetState();
// }

// class _ListenLocationWidgetState extends State<ListenLocationWidget> {
//   LocationData? _location;
//   StreamSubscription<LocationData>? _locationSubscription;
//   String? _error;

//   bool _inBackground = false;

//   Future<void> _listenLocation() async {
//     _locationSubscription =
//         await Location.instance.onLocationChanged.handleError((dynamic err) {
//       if (err is PlatformException) {
//         setState(() {
//           _error = err.code;
//         });
//       }
//       _locationSubscription?.cancel();
//       setState(() {
//         _locationSubscription = null;
//       });
//     }).listen((LocationData currentLocation) async {
//       setState(() {
//         _error = null;

//         _location = currentLocation;
//       });
//       await Location.instance.changeNotificationOptions(
//         subtitle:
//             'Location: ${currentLocation.latitude}, ${currentLocation.longitude}',
//         onTapBringToFront: true,
//       );
//     });
//     setState(() {});
//   }

//   Future<void> _stopListen() async {
//     await _locationSubscription?.cancel();
//     setState(() {
//       _locationSubscription = null;
//     });
//   }

//   @override
//   void dispose() {
//     _locationSubscription?.cancel();
//     setState(() {
//       _locationSubscription = null;
//     });
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             _error ??
//                 '''
// Listen location: ${_location?.latitude}, ${_location?.longitude}
//                 ''',
//             style: Theme.of(context).textTheme.bodyText1,
//           ),
//           Row(
//             children: <Widget>[
//               Container(
//                 margin: const EdgeInsets.only(right: 42),
//                 child: ElevatedButton(
//                   onPressed:
//                       _locationSubscription == null ? _listenLocation : null,
//                   child: const Text('Listen'),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: _locationSubscription != null ? _stopListen : null,
//                 child: const Text('Stop'),
//               )
//             ],
//           ),
//           SwitchListTile(
//             value: _inBackground,
//             title: const Text('Get location in background'),
//             onChanged: (value) {
//               setState(() {
//                 _inBackground = value;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class GetLocationWidget extends StatefulWidget {
//   @override
//   State<GetLocationWidget> createState() => _GetLocationWidgetState();
// }

// class _GetLocationWidgetState extends State<GetLocationWidget> {
//   bool _loading = false;

//   LocationData? _location;
//   String? _error;

//   Future<void> _getLocation() async {
//     setState(() {
//       _error = null;
//       _loading = true;
//     });
//     try {
//       final _locationResult = await Location.instance.getLocation();

//       setState(() {
//         _location = _locationResult;
//         _loading = false;
//       });
//     } on PlatformException catch (err) {
//       setState(() {
//         _error = err.code;
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             _error ??
//                 'Location: ${_location?.latitude}, ${_location?.longitude}',
//             style: Theme.of(context).textTheme.bodyText1,
//           ),
//           Row(
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: _getLocation,
//                 child: _loading
//                     ? const CircularProgressIndicator(
//                         color: Colors.white,
//                       )
//                     : const Text('Get'),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChangeSettings extends StatefulWidget {
//   @override
//   State<ChangeSettings> createState() => _ChangeSettingsState();
// }

// class _ChangeSettingsState extends State<ChangeSettings> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final TextEditingController _intervalController = TextEditingController(
//     text: '5000',
//   );

//   final TextEditingController _distanceFilterController = TextEditingController(
//     text: '0',
//   );

//   LocationAccuracy _locationAccuracy = LocationAccuracy.high;

//   bool _useGooglePlayServices = false;

//   @override
//   void dispose() {
//     _intervalController.dispose();
//     _distanceFilterController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Change settings',
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             const SizedBox(height: 4),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               controller: _intervalController,
//               decoration: const InputDecoration(
//                 labelText: 'Interval',
//               ),
//             ),
//             const SizedBox(height: 4),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               controller: _distanceFilterController,
//               decoration: const InputDecoration(
//                 labelText: 'DistanceFilter',
//               ),
//             ),
//             const SizedBox(height: 4),
//             DropdownButtonFormField<LocationAccuracy>(
//               value: _locationAccuracy,
//               onChanged: (LocationAccuracy? value) {
//                 if (value == null) {
//                   return;
//                 }
//                 setState(() {
//                   _locationAccuracy = value;
//                 });
//               },
//               items: const <DropdownMenuItem<LocationAccuracy>>[
//                 DropdownMenuItem(
//                   value: LocationAccuracy.high,
//                   child: Text('High'),
//                 ),
//                 DropdownMenuItem(
//                   value: LocationAccuracy.balanced,
//                   child: Text('Balanced'),
//                 ),
//                 DropdownMenuItem(
//                   value: LocationAccuracy.low,
//                   child: Text('Low'),
//                 ),
//                 DropdownMenuItem(
//                   value: LocationAccuracy.powerSave,
//                   child: Text('Powersave'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             SwitchListTile(
//               value: _useGooglePlayServices,
//               title: const Text('Use Google Play Services'),
//               onChanged: (value) {
//                 setState(() {
//                   _useGooglePlayServices = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 4),
//             ElevatedButton(
//               onPressed: () {
//                 Location.instance.changeSettings(
//                   interval: int.parse(_intervalController.text),
//                   distanceFilter: double.parse(_distanceFilterController.text),
//                   accuracy: _locationAccuracy,
//                 );
//               },
//               child: const Text('Change'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ChangeNotificationWidget extends StatefulWidget {
//   @override
//   State<ChangeNotificationWidget> createState() =>
//       _ChangeNotificationWidgetState();
// }

// class _ChangeNotificationWidgetState extends State<ChangeNotificationWidget> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final TextEditingController _channelController = TextEditingController(
//     text: 'Location background service',
//   );

//   final TextEditingController _titleController = TextEditingController(
//     text: 'Location background service running',
//   );

//   String? _iconName = 'navigation_empty_icon';

//   @override
//   void dispose() {
//     _channelController.dispose();
//     _titleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (kIsWeb || !Platform.isAndroid) {
//       return const Text(
//         'Change notification settings not available on this platform',
//       );
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Android Notification Settings',
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             const SizedBox(height: 4),
//             TextFormField(
//               controller: _channelController,
//               decoration: const InputDecoration(
//                 labelText: 'Channel Name',
//               ),
//             ),
//             const SizedBox(height: 4),
//             TextFormField(
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Notification Title',
//               ),
//             ),
//             const SizedBox(height: 4),
//             DropdownButtonFormField<String>(
//               value: _iconName,
//               onChanged: (String? value) {
//                 setState(() {
//                   _iconName = value;
//                 });
//               },
//               items: const <DropdownMenuItem<String>>[
//                 DropdownMenuItem<String>(
//                   value: 'navigation_empty_icon',
//                   child: Text('Empty'),
//                 ),
//                 DropdownMenuItem<String>(
//                   value: 'circle',
//                   child: Text('Circle'),
//                 ),
//                 DropdownMenuItem<String>(
//                   value: 'square',
//                   child: Text('Square'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             ElevatedButton(
//               onPressed: () {
//                 Location.instance.changeNotificationOptions(
//                   channelName: _channelController.text,
//                   title: _titleController.text,
//                   iconName: _iconName,
//                 );
//               },
//               child: const Text('Change'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
