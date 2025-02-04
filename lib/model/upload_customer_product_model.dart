import 'dart:io';

class UploadCustomerProductModel {
  String itemName;
  String itemSubCategory;
  String itemDescription;
  File itemImage;
  int itemAge;
  int itemPrice;
  String location;
  UploadCustomerProductModel({
    required this.itemName,
    required this.itemSubCategory,
    required this.itemDescription,
    required this.itemImage,
    required this.itemAge,
    required this.itemPrice,
    required this.location,
  });
}
