import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:custom_info_window/custom_info_window.dart';
import "package:dio/dio.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class livemap extends StatefulWidget {
  const livemap({Key? key}) : super(key: key);

  @override
  _livemapState createState() => _livemapState();
}

class _livemapState extends State<livemap> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  Completer<GoogleMapController> _controller = Completer();
  late final Uint8List customMarker;
  late final Uint8List customMarker2;
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(13.5571858, 80.0252284),
    zoom: 14.4746,
  );
  @override
  void initState() {
    super.initState();
    // getCurrent();
    getUserPLants();
    random();
  }

  void random() async {
    customMarker = await getBytesFromAsset(
        path: "images/tree.png", 
        width: 200 
        );
    customMarker2 = await getBytesFromAsset(
        path: "images/dry-tree.png", 
        width: 200 
        );
  }

  // String? _currentAddress;
  Position? _currentPosition;
  final List<Marker> _markers = <Marker>[
  
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(15.5571858, 80.0252245),
        infoWindow: InfoWindow(
          title: 'My Position',
        ))

  ];



  Future<List?> getUserPLants() async {
    try {
      String baseURL = "https://unnamed-plant.herokuapp.com/getplants";
      var respons = await Dio().get(baseURL);      // print(respons.data);
      for (int i = 0; i < respons.data.length; i++) {
        print(respons.data[i]["dry"]);
        _addMarker(
          double.parse(respons.data[i]["location"]["latitude"]),
          double.parse(respons.data[i]["location"]["longitude"]),
          respons.data[i]["plant_name"],
          respons.data[i]["date_of_plant"],
          respons.data[i]["user_name"],
          respons.data[i]["dry"].toString(),
        );
      }
      return (respons.data);
    } catch (error) {
      print(error);
      return [];
    }
  }

  @override

  // void getCurrent() async {
  //   getUserCurrentLocation().then((value) async {
  //     print(value);
  //     print(value.latitude.toString() + " " + value.longitude.toString());

  //     _markers.add(Marker(
  //       markerId: const MarkerId("2"),
  //       position: LatLng(value.latitude, value.longitude),
  //       infoWindow: const InfoWindow(
  //         title: 'My Current Location',
  //       ),
  //     ));

  //     CameraPosition cameraPosition = new CameraPosition(
  //       target: LatLng(value.latitude, value.longitude),
  //       zoom: 14,
  //     );

  //     final GoogleMapController controller = await _controller.future;
  //     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  //     setState(() {});
  //   });
  // }

  Future<Uint8List> getBytesFromAsset(
      {required String path, required int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // Future<Position> getUserCurrentLocation() async {
  //   await Geolocator.requestPermission()
  //       .then((value) {})
  //       .onError((error, stackTrace) async {
  //     await Geolocator.requestPermission();
  //     print("ERROR" + error.toString());
  //   });
  //   return await Geolocator.getCurrentPosition();
  // }

  void _addMarker(double lat, double long, String plant_name, String DOB,
      String Username, String dry) {
    setState(() {
      var rnd;

      rnd = dry == "true" ? customMarker2 : customMarker;
      _markers.add(Marker(
          markerId: MarkerId("$lat"),
          position: LatLng(lat, long),
          icon: BitmapDescriptor.fromBytes(rnd, size: Size(20.00000065, 20.000000003)),
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
                Container(
                  height: 150,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Plant Name : $plant_name",
                        style: GoogleFonts.bebasNeue(fontSize: 14),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text("Planted By : $Username",
                          style: GoogleFonts.bebasNeue(fontSize: 14)),
                      SizedBox(
                        height: 12,
                      ),
                      Text("Planted On : $DOB",
                          style: GoogleFonts.bebasNeue(fontSize: 14))
                    ],
                  ),
                ),
                LatLng(lat, long));
          }
          ));
    });
    print(_markers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                onTap: (position) {
                  _customInfoWindowController.hideInfoWindow!;
                },
                onCameraMove: (position) {
                  _customInfoWindowController.onCameraMove!;
                },
                initialCameraPosition: _kGoogle,
                markers: Set<Marker>.of(_markers),
                mapType: MapType.normal,
                myLocationEnabled: true,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _customInfoWindowController.googleMapController = controller;
                },
              ),
              CustomInfoWindow(
                controller: _customInfoWindowController,
                height: 100,
                width: 150,
                offset: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
