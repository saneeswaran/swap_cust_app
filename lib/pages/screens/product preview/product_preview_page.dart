import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_elevated_button.dart';

class ProductPreviewPage extends StatefulWidget {
  final String itemName;
  final String itemAge;
  final String itemPrice;
  final String itemDescription;
  final File image;
  final String address;
  const ProductPreviewPage({
    super.key,
    required this.itemName,
    required this.itemAge,
    required this.itemPrice,
    required this.itemDescription,
    required this.image,
    required this.address,
  });

  @override
  State<ProductPreviewPage> createState() => _ProductPreviewPageState();
}

class _ProductPreviewPageState extends State<ProductPreviewPage> {
  //rating
  double rating = 0.0;
  double? ratingFuction(value) {
    setState(() {
      rating = value;
    });
    return null;
  }

  //custom text style
  TextStyle customTextStyle =
      TextStyle(color: Colors.grey.shade700, fontSize: 16);

//custom alert dialogue
  void customAlertDialogue() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Your product will shorlist soon......",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //date time
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          "Product Preview",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: size.height * 1,
          width: size.width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: size.height * 0.03,
            children: [
              //display user input image
              Container(
                height: size.height * 0.30,
                width: size.width * 1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(widget.image), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20)),
              ),
              //category and date time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ITEM : ${widget.itemName}",
                    style: TextStyle(
                        color: Color(0xff636F81),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                child: Row(
                  children: [
                    Text("Address        :  ", style: customTextStyle),
                    Expanded(
                      child: Text(
                        widget.address,
                        maxLines: 3,
                        style: customTextStyle,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Age                : ${widget.itemAge}",
                style: customTextStyle,
              ),
              Text("Price at buy  : ${widget.itemPrice}",
                  style: customTextStyle),
              SizedBox(
                child: Row(
                  children: [
                    Text("Description   :  ", style: customTextStyle),
                    Expanded(
                      child: Text(
                        widget.itemDescription,
                        maxLines: 3,
                        style: customTextStyle,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 1,
                child: CustomElevatedButton(
                    text: "Get Quote",
                    onPressed: () {},
                    backgroundColor: Theme.of(context).primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
