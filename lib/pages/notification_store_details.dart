import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swap_cust_app/pages/redeem_page.dart';

import '../model/popular_category_model.dart';

class NotificationStoreDetails extends StatefulWidget {
  const NotificationStoreDetails({super.key});

  @override
  State<NotificationStoreDetails> createState() =>
      _NotificationStoreDetailsState();
}

class _NotificationStoreDetailsState extends State<NotificationStoreDetails> {
  //model
  List model = PopularCategoryModel.popularCategoryList;
  String selectedButton = "Dining";
  @override
  Widget build(BuildContext context) {
    TextStyle customTitleTextStyle =
        TextStyle(fontSize: 16, color: Colors.black);
    TextStyle cutomPriceTextStyle =
        TextStyle(fontSize: 14, color: Colors.black87);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Store Name",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: size.height * 0.01,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              //search bar
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.grey.shade500, width: sqrt1_2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.grey.shade500, width: sqrt1_2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.grey.shade500, width: sqrt1_2),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          size: 30,
                        )),
                  )
                ],
              ),
              //button
              SizedBox(
                height: size.height * 0.10,
                width: size.width * 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: size.width * 0.02,
                    children: [
                      customOutlinedButton("Dining"),
                      customOutlinedButton("Bed"),
                      customOutlinedButton("Wardrobe"),
                      customOutlinedButton("Sofa"),
                    ],
                  ),
                ),
              ),
              //products
              Text(
                "Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                itemCount: model.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              height: size.height * 0.22,
                              width: size.width * 0.40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: AssetImage(model[index].imageUrl),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Column(
                              spacing: size.height * 0.01,
                              children: [
                                Text(
                                  "4 Seat limited edition",
                                  style: customTitleTextStyle,
                                ),
                                Text(
                                  "Price  : 50000 ",
                                  style: cutomPriceTextStyle,
                                ),
                                Text(
                                  "Swap Points  : 5000",
                                  style: cutomPriceTextStyle,
                                ),
                                SizedBox(
                                  height: size.height * 0.06,
                                  width: size.width * 0.27,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          backgroundColor:
                                              Theme.of(context).primaryColor),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RedeemPage()));
                                      },
                                      child: Text(
                                        "Redeem",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  OutlinedButton customOutlinedButton(String label) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedButton = label;
        });
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: selectedButton == label ? Colors.blue : Colors.grey,
        ),
        backgroundColor: selectedButton == label
            ? Colors.blue.withOpacity(0.1)
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selectedButton == label ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
