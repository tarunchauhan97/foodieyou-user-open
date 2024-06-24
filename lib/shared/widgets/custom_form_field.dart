import 'package:flutter/material.dart';
import 'package:foodieyou/shared/styles/colors.dart';
import 'package:foodieyou/shared/styles/dimension.dart';

// ignore: must_be_immutable
class CustomFormField extends StatefulWidget {
  bool? enabled;
  final bool isEmail;
  final bool isName;
  final bool isPhone;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final String hintText;
  final double? hintFontSize;
  final TextAlign? textAlign;
  final double? width;
  final double? radius;
  final EdgeInsets? margin;
  final bool isPassword;
  late bool isObsecure;
  void Function(String)? onChanged;
  final bool readOnly;

  CustomFormField(
      {super.key,
        this.readOnly=false,
        this.enabled =true,
      this.isEmail = false,
      this.isName = false,
      this.isPhone = false,
      this.validator,
      this.controller,
      this.textAlign,
      this.hintFontSize,
      this.margin = const EdgeInsets.symmetric(horizontal: 34),
        this.onChanged,
      required this.hintText,
      this.width,
      this.radius,
      this.isPassword = false,
      this.prefixIcon,
      this.suffixIcon}) {
    isObsecure = isPassword;
  }

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10, vertical: Dimensions.height10),
          alignment: Alignment.center,
          margin: widget.margin,
          width: widget.width ?? double.infinity,
          height: Dimensions.height10 * 5.6,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(widget.radius ?? Dimensions.height10 * 3),
            color: AppColors.fieldColor,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10, vertical: Dimensions.height10*0.6),
          margin: widget.margin,
          child: TextFormField(
            readOnly: widget.readOnly,
            onChanged:widget.onChanged,
              enabled:widget.enabled,
              keyboardType: widget.isEmail == true
                  ? TextInputType.emailAddress
                  : (widget.isName == true
                      ? TextInputType.name
                      : (widget.isPhone == true ? TextInputType.phone : null)),
              validator: widget.validator,
              controller: widget.controller,
              textAlign: widget.textAlign ?? TextAlign.left,
              obscureText: widget.isObsecure,
              decoration: InputDecoration(
                  focusedErrorBorder: InputBorder.none,
                  iconColor: AppColors.mainColor,
                  contentPadding: widget.textAlign != null
                      ? EdgeInsets.zero
                      : EdgeInsets.symmetric(
                          vertical: Dimensions.height10 * 1.5),
                  border: InputBorder.none,
                  suffixIcon: widget.isPassword == true
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              widget.isObsecure = !widget.isObsecure;
                            });
                          },
                          child: widget.isObsecure == true
                              ? Icon(
                                  Icons.visibility_off,
                                  color: AppColors.mainColor,
                                )
                              : Icon(Icons.visibility,
                                  color: AppColors.mainColor),
                        )
                      : null,
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(widget.prefixIcon, color: AppColors.mainColor)
                      : null,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: widget.hintFontSize,
                      fontWeight: widget.hintFontSize != null
                          ? FontWeight.bold
                          : null))),
        )
      ],
    );
  }
}
