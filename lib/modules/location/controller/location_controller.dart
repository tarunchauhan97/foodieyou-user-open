import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:foodieyou/models/address_model.dart';
import 'package:foodieyou/modules/auth/models/signup_model.dart';
import 'package:foodieyou/modules/profile_screen/controllers/profile_controller.dart';
import 'package:foodieyou/shared/constants/constants.dart';

class LocationController extends GetxController {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final name = TextEditingController();
  final phone = TextEditingController();
  late Position position;
  late Position pickPosition;

  Placemark placeMark = Placemark();
  Placemark pickPlaceMark = Placemark();List<AddressModel> allAddressList = [];

  SignUpModel? userModel=Get.find<ProfileController>().userModel;
  String address="";
  @override
  void onInit() {

    super.onInit();
    if(userModel!=null){
      name.text=userModel!.name;
      phone.text=userModel!.phone;
      if(userModel!.address!=null){

        address=userModel!.address!.address!;

        pickedAddress=address;

        addressModel=userModel!.address!;
        deliveryAddressModel=userModel!.address!;
        cameraPosition=CameraPosition(
            target: LatLng(double.parse(userModel!.address!.latitude!), double.parse(userModel!.address!.longitude!)), zoom: 17);
      }
      update();
    }
  }

  String? nameValidator(String? value){
    if(value!.isEmpty||!RegExp(r"^[a-zA-Z '’]+$").hasMatch(value)){
      return "Enter correct name";
    }
    return null;
  }
  String? phoneValidator(String? value){
    if(value!.isEmpty || !RegExp(r'^(\+|00)([0-9]){1,3}(\s|\-)?([0-9]){3,14}$').hasMatch(value)){
      return "Enter correct phone number";
    }
    return null;
  }

  String pickedAddress="";

  CameraPosition cameraPosition = const CameraPosition(
      target: LatLng(36.80278, 10.17972), zoom: 17);

  void onCameraMove(CameraPosition position) {
    cameraPosition = position;
    address = '${placeMark.street}, ${placeMark.subLocality}, ${placeMark
        .locality}, ${placeMark.postalCode}, ${placeMark.country}';
    address = "${placeMark.street ?? ""}"
        " ${placeMark.locality ?? ""}"
        " ${placeMark.subLocality ?? ""}"
        " ${placeMark.country ?? " "}";
  }

  bool loading = false;
  late GoogleMapController mapController;

  Future<void> updatePosition() async {
    loading = true;
    update();
    try {
        position = Position(longitude: cameraPosition.target.longitude,
            latitude: cameraPosition.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1);
        placeMark = (await placemarkFromCoordinates(
            cameraPosition.target.latitude,
            cameraPosition.target.longitude))[0];



    } catch (e) {
      debugPrint(e.toString());
    }
    loading = false;
    update();
  }

  AddressModel? addressModel;

  AddressModel? deliveryAddressModel;

  Future<void> getCurrentPosition() async{
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position= await Geolocator.getCurrentPosition();
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
      position.latitude, position.longitude,
    ),zoom: 17)));
    placeMark = (await placemarkFromCoordinates(
        position.latitude,
        position.longitude))[0];
  }

  Future<void> saveAddress({bool fromProfile=true}) async{
    loading=true;
    update();
    if(fromProfile){
      addressModel = AddressModel(
        address: address,
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(AppConstants.uid).update({"address":addressModel!.toJson()})
          .then((value) {
        pickedAddress=address;
        Get.snackbar("Update", "Your address has been updated successfully",colorText:Colors.green);
      })
          .catchError((error) {
        Get.snackbar("Update", "Error,please check your internet",colorText:Colors.red);
        debugPrint(error.toString());
      });
    }else{
      deliveryAddressModel=AddressModel(
        address: address,
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );
    }

    loading=false;
    update();
  }

  List<Location> locations = [];
  List<Placemark> places = [];
  Map<int,List<Placemark>>placesPerLocation={};

  Future<List<Placemark>> getPlaces(String location) async {
    places = [];
    placesPerLocation={};

    if(location.isNotEmpty){
      locations = await locationFromAddress(location, );

      for (int i = 0; i < locations.length; i++) {
        List<Placemark> aux=(await placemarkFromCoordinates(locations[i].latitude, locations[i].longitude));
        places.addAll(aux);
        placesPerLocation.addAll({i:aux});
      }
    }
    return places;
  }

  void setLocation(Placemark placemark){
    int i=0;
    placesPerLocation.forEach((key, value) {
      if(value.contains(placemark)){
        i=key;
      }
    });
    position=Position(longitude:locations[i].longitude , latitude: locations[i].latitude, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
    placeMark=placemark;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
      locations[i].latitude, locations[i].longitude,
    ),zoom: 17)));

    update();
  }

}