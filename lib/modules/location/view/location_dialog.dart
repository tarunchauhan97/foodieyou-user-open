import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:foodieyou/modules/location/controller/location_controller.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

class LocationDialog extends StatelessWidget {
  const LocationDialog({Key? key,})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return GetBuilder<LocationController>(builder: (locationController) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Dimensions.width10),
          alignment: Alignment.topCenter,
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.height10),
            ),
            child: SizedBox(
                width: Dimensions.screenWidth,
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      controller: controller,
                      textInputAction: TextInputAction.search,
                      autofocus: true,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                          hintStyle: Theme.of(context).textTheme.displayMedium!
                              .copyWith(
                              color: AppColors.greyColor,
                              fontSize: Dimensions.height10*1.6),
                          hintText: "Search Location",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimensions.width10*1.5),
                              borderSide: const BorderSide(
                                  style: BorderStyle.none,
                                  width: 0
                              )
                          )
                      )
                  ),
                  //as we type it gives us a suggestion
                  suggestionsCallback: (String pattern) {
                    return locationController.getPlaces(pattern);
                  },
                  itemBuilder: (BuildContext context, Placemark itemData) {

                    return Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(Dimensions.width10),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on,color: Colors.amberAccent,),
                          Expanded(child: Text(
                            "${itemData.country} ${itemData.isoCountryCode}, ${itemData.name} ${itemData.administrativeArea}  ${itemData.subAdministrativeArea}",
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge!
                                .color,
                                fontSize: Dimensions.height10*1.5),
                          ))
                        ],
                      ),
                    );
                  },
                  loadingBuilder: (context) => Center(child: CircularProgressIndicator(color: AppColors.mainColor)),
                  noItemsFoundBuilder: (context) => Container(),
                  errorBuilder: (context, error) =>  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.width10*2)),
                    padding: EdgeInsets.all(Dimensions.width10),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber,color: Colors.amberAccent,),
                        SizedBox(width: Dimensions.width10,),
                        Expanded(child: Text(
                          error.toString(),
                          maxLines: 2, overflow: TextOverflow.ellipsis,
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge!
                              .color,
                              fontSize: Dimensions.height10*1.5),
                        ))
                      ],
                    ),
                  ),
                  suggestionsBoxDecoration: SuggestionsBoxDecoration(
                    elevation: 15,
                    borderRadius: BorderRadius.circular(Dimensions.width10*1.5)
                  ),
                  hideSuggestionsOnKeyboardHide: false,
                  hideOnEmpty: true,
                  onSuggestionSelected: (Placemark suggestion,) {
                    locationController.setLocation(suggestion);
                    Get.back();
                  },

                )
            ),
          ),
        ),
      );
    }
    );
  }
}
