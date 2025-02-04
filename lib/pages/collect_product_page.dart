import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swap_cust_app/pages/google_map_page.dart';
import 'package:swap_cust_app/pages/product_preview_page.dart';
import 'package:swap_cust_app/util/app_validator.dart';
import 'package:swap_cust_app/widgets/custom_elevated_button.dart';

import '../model/popular_category_model.dart';
import '../widgets/custom_text_form_field.dart';

class CollectProductPage extends StatefulWidget {
  final int categoryId;

  const CollectProductPage(
      {super.key,
      required this.categoryId,
      required PopularCategoryModel model});

  @override
  State<CollectProductPage> createState() => _CollectProductPageState();
}

class _CollectProductPageState extends State<CollectProductPage> {
  List<PopularCategoryModel> productDetails =
      PopularCategoryModel.popularCategoryList;

//image picker
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Pick an image and compress it
  Future<void> pickAndCompressImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    File? compressedImage = await _compressImage(File(pickedFile.path));

    setState(() {
      _selectedImage = compressedImage;
    });
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    File? compressedImage = await _compressImage(File(pickedFile.path));

    setState(() {
      _selectedImage = compressedImage;
    });
  }

  // Compress image
  Future<File?> _compressImage(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf('.');
    final compressedPath = '${filePath.substring(0, lastIndex)}_compressed.jpg';

    final result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      compressedPath,
      quality: 70,
    );

    return result != null ? File(result.path) : null;
  }

  void showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  getImageFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickAndCompressImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  //class
  final appValidator = Appvalidator();

  //controller
  final subCategoryController = TextEditingController();
  static final itemNameController = TextEditingController();
  final itemDescriptionController = TextEditingController();
  final itemAgeController = TextEditingController();
  final purchasePriceController = TextEditingController();
//google map location
  double? latitude;
  double? longitude;
  String address = '';

  String staticMap(double latitude, double longitude) {
    final apiKey = 'AIzaSyCuB8eJT8H1rS7znNWQAtnWUjonMCG8AsQ';
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7C$latitude,$longitude&key=$apiKey";
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    // Check for permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    // Convert coordinates to address
    _getAddressFromCoordinates(position.latitude, position.longitude);
  }

  Future<void> _getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          address =
              "${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        address = "Unable to fetch address.";
      });
    }
  }

  void navigateToMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPage(),
      ),
    );

    if (result != null) {
      double lat = result['latitude'];
      double lng = result['longitude'];

      // Update the real-time address box
      _getAddressFromCoordinates(lat, lng);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle customTextStyle = TextStyle(color: Colors.black, fontSize: 18);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Find you Swap price ! POST NOW",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: size.height * 1,
        width: size.width * 1,
        child: SingleChildScrollView(
          child: Column(
            spacing: size.height * 0.02,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Center(
                child: Text(
                  "CATEGORY : ${productDetails[widget.categoryId].category}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                ),
              ),
              CustomDetailsGettingFromUserPage(
                text: 'Sub Category',
                controller: subCategoryController,
                validator: appValidator.categoryList,
              ),
              //image picker
              if (_selectedImage == null)
                GestureDetector(
                  onTap: showImageSourceDialog,
                  child: Container(
                      margin: const EdgeInsets.all(0),
                      height: size.height * 0.20,
                      width: size.width * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                      ),
                      child: Center(
                        child: Text("Upload your image here"),
                      )),
                )
              else
                Container(
                  height: size.height * 0.20,
                  width: size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).primaryColor),
                    image: DecorationImage(
                      image: FileImage(
                          _selectedImage!), // Ensure this uses the compressed image
                      fit: BoxFit.cover, // Adjust fit as needed
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: removeImage,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              // get details from user
              CustomDetailsGettingFromUserPage(
                text: 'Add Item Name',
                controller: itemNameController,
                validator: appValidator.formFill,
              ),
              CustomDetailsGettingFromUserPage(
                text: 'Add Item Description',
                controller: itemDescriptionController,
                validator: appValidator.formFill,
              ),
              CustomDetailsGettingFromUserPage(
                text: 'Add Item Age',
                controller: itemAgeController,
                validator: appValidator.formFill,
                keyboardType: TextInputType.number,
                maxLength: 3,
              ),
              CustomDetailsGettingFromUserPage(
                text: 'Add Item purchase price',
                controller: purchasePriceController,
                validator: appValidator.formFill,
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),

              //map location
              if (latitude == null && longitude == null)
                GestureDetector(
                  onTap: navigateToMap,
                  child: SizedBox(
                    height: size.height * 0.20,
                    width: size.width * 1,
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  ),
                )
              else
                GestureDetector(
                  onTap: navigateToMap,
                  child: Container(
                    height: size.height * 0.20,
                    width: size.width * 1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                staticMap(latitude!, longitude!)))),
                  ),
                ),
              Text(
                "Address : $address",
                style: customTextStyle,
              ),
              //confirm button
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 1,
                child: CustomElevatedButton(
                  text: "Get Credit point estimate",
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (itemNameController.text.isEmpty ||
                        subCategoryController.text.isEmpty ||
                        itemAgeController.text.isEmpty ||
                        itemDescriptionController.text.isEmpty ||
                        purchasePriceController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill the details")));
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPreviewPage(
                            itemName: itemNameController.text,
                            itemAge: itemAgeController.text,
                            itemPrice: purchasePriceController.text,
                            itemDescription: itemDescriptionController.text,
                            address: address,
                            image: _selectedImage!,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
                width: size.width * 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
