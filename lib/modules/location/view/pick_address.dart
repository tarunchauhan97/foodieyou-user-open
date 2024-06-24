import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:foodieyou/modules/check_out/views/check_out_screen.dart';
import 'package:foodieyou/modules/location/controller/location_controller.dart';
import 'package:foodieyou/modules/location/view/location_dialog.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';
import 'package:foodieyou/shared/widgets/custom_button.dart';

class PickAddressMap extends StatelessWidget {
  final bool fromProfile;
   const PickAddressMap({
    required this.fromProfile,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  initialCameraPosition: locationController.cameraPosition,
                  onCameraMove: locationController.onCameraMove,
                  onCameraIdle: () {
                    locationController.updatePosition();
                  },
                  onMapCreated: (GoogleMapController controller) {
                    locationController.mapController = controller;
                  },
                ),
                Center(
                  child: Image.asset(
                    'assets/images/marker.png',
                    width: Dimensions.width10 * 5,
                    height: Dimensions.height10 * 5,
                  ),
                ),
                Positioned(
                  bottom: Dimensions.height10 * 4,
                  right: Dimensions.width10 * 2,
                  child: InkWell(
                    onTap: (){
                      locationController.getCurrentPosition();
                    },
                    child: CircleAvatar(
                      radius: Dimensions.height10*2,
                      backgroundColor: Colors.white.withOpacity(.8),
                      child: Icon(Icons.gps_fixed_outlined,color: AppColors.mainColor,size: 20,),
                    ),
                  )
                ),
                Positioned(
                    top: Dimensions.height10 * 2,
                    right: Dimensions.width10 * 2,
                    left: Dimensions.width10 * 2,
                    child: InkWell(
                      onTap: () => Get.dialog(const LocationDialog()),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10 * 0.5),
                        height: Dimensions.height10 * 5,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor.withOpacity(0.82),
                            borderRadius: BorderRadius.circular(
                                Dimensions.height10 * 1.5)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Dimensions.width10 * 0.3,
                            ),
                            Icon(
                              Icons.location_on,
                              size: Dimensions.height10 * 2.8,
                              color: Colors.amberAccent,
                            ),
                            SizedBox(
                              width: Dimensions.width10 * 0.3,
                            ),
                            Expanded(
                                child: Text(
                              locationController.address,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.height10 * 1.5),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                            SizedBox(
                              width: Dimensions.width10 * 0.3,
                            ),
                            Icon(
                              Icons.search,
                              size: Dimensions.height10 * 2.8,
                              color: Colors.amberAccent,
                            ),
                            SizedBox(
                              width: Dimensions.width10 * 0.3,
                            ),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                  bottom: Dimensions.height10 * 3,
                  right: Dimensions.width10 * 10,
                  left: Dimensions.width10 * 10,
                  child: locationController.loading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.mainColor,
                          ),
                        )
                      : CustomButton(
                          filledColor: AppColors.mainColor.withOpacity(0.85),
                          buttonText: "Pick Location",
                          onPressed: locationController.loading ? null : () async{
                            await locationController.saveAddress(fromProfile: fromProfile);
                            if(fromProfile){
                              Get.back();
                            }else{
                              Get.off(const CheckOutScreen());
                            }


                          },
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
