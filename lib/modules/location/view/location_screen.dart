import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:foodieyou/modules/location/controller/location_controller.dart';
import 'package:foodieyou/modules/profile_screen/controllers/profile_controller.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';
import 'package:foodieyou/shared/widgets/custom_form_field.dart';

class LocationScreen extends StatefulWidget {
   const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: (){
        //     Get.to(CartScreen());
        //   },
        //   icon: Icon(Icons.arrow_back,color: AppColors.mainColor,),
        // ),
        title: const Text(
          "Add Address",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0.2,
        shadowColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(builder: (locationController) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.height10 * 15,
                  margin: EdgeInsets.all(Dimensions.height10 * 0.3),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(Dimensions.height10 * 0.5),
                      border:
                      Border.all(color: AppColors.mainColor, width: 1)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GoogleMap(
                        onTap: (latLng){
                          // Get.off(PickAddressMap());
                        },
                        myLocationEnabled: true,
                        initialCameraPosition: locationController.cameraPosition,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        onCameraIdle: () {
                          locationController.updatePosition();
                        },
                        onCameraMove: locationController.onCameraMove,
                        onMapCreated: (GoogleMapController controller) {
                          locationController.mapController = controller;
                        },
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/marker.png',
                          width: Dimensions.width10 * 3,
                          height: Dimensions.height10 * 3,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.width10*2,vertical: Dimensions.height10*2),
                child: GetBuilder<ProfileController>(builder: (profileController) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Delivery Address',style: TextStyle(fontSize: Dimensions.width10*2.1),),
                      SizedBox(height: Dimensions.height10,),
                      // CustomFormField(
                      //   readOnly: true,
                      //   margin: EdgeInsets.zero,
                      //   hintText: "Address",
                      //   prefixIcon: Icons.pin_drop_sharp,
                      //   controller: locationController.address,
                      // ),

                      SizedBox(
                        height: Dimensions.height10 * 2.8,
                      ),
                      Text('Contact Name',style: TextStyle(fontSize: Dimensions.width10*2.1),),
                      SizedBox(height: Dimensions.height10,),
                      CustomFormField(
                        isName: true,
                        margin: EdgeInsets.zero,
                        hintText: profileController.userModel!.name,
                        prefixIcon: Icons.person,
                        controller: locationController.name,
                        validator: locationController.nameValidator,
                      ),
                      SizedBox(
                        height: Dimensions.height10 * 2.8,
                      ),
                      Text('Contact Number',style: TextStyle(fontSize: Dimensions.width10*2.1),),
                      SizedBox(height: Dimensions.height10,),
                      CustomFormField(
                        isPhone: true,
                        margin: EdgeInsets.zero,
                        hintText: profileController.userModel!.phone,
                        prefixIcon: Icons.phone_android,
                        controller: locationController.phone,
                        validator: locationController.phoneValidator,
                      ),
                      SizedBox(height: Dimensions.height10*5,),
                      locationController.loading==true?Center(child: CircularProgressIndicator(color: AppColors.mainColor,)): CustomButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            locationController.saveAddress();
                          }
                        },
                        buttonText: "Save Address",
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10 * 3.6),
                      ),

                    ],
                  );
                },)
                )
              ],
            ),
          ),
        );
      },)
    );
  }
}
