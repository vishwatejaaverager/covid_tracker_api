import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

class LocationWidget extends StatefulWidget {
  LocationPage createState()=> LocationPage();
}
class LocationPage extends State<LocationWidget>{
  bool? _serviceEnabled,_isGetLocation;
  Location location = Location();
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;


  Future permi() async{
    var status = await handler.Permission.location.status;
    if(status.isDenied){
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData =  await location.getLocation();
    setState(()  {
      _isGetLocation = true;
    });

  }




  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.location_on,
          size: 46.0,
          color: Colors.blue,
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
          "Get User Location",
          style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        _isGetLocation != null ? Text(
          'Location : ${_locationData!.latitude}/${_locationData!.longitude}',
          style: const TextStyle(fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white),) : Container(),
        ElevatedButton(onPressed: () {
          permi();
        },
            child: const Text(
              "Get Current Location", style: TextStyle(color: Colors.white),))
      ],
    );
  }
  }
  //Your code here


