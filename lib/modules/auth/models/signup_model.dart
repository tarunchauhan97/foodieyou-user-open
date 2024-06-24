import 'package:foodieyou/models/address_model.dart';

class SignUpModel{
  late String name;
  late String email;
  late String phone;
  late String uid;
  late String image;
  late AddressModel? address;
  late bool isEmailVerified;

  SignUpModel({
    this.address,
    required this.email,
    required this.name,
    required this.phone,
    required this.uid,
    required this.isEmailVerified,
    required this.image,
  });

  SignUpModel.fromJson(Map<String,dynamic> json){
    address=json['address']!=null?AddressModel.fromJson(json['address']):null;
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uid=json['uid'];
    isEmailVerified=json['isEmailVerified'];
    image=json['image']??"";
  }

  Map<String,dynamic> toMap(){
    return
      {
        'name':name,
        'address':address!=null?address!.toJson():address,
        'email':email,
        'phone':phone,
        'uid':uid,
        'isEmailVerified':isEmailVerified,
        'image':image,
      };
  }

}