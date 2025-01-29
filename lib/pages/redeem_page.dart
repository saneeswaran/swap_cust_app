import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:swap_cust_app/model/popular_category_model.dart';
import 'package:swap_cust_app/pages/bottom_nav_bar.dart';

import '../widgets/custom_elevated_button.dart';

class RedeemPage extends StatefulWidget {
  const RedeemPage({
    super.key,
  });

  @override
  State<RedeemPage> createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  List<PopularCategoryModel> productDetails =
      PopularCategoryModel.popularCategoryList;

  //rating
  double rating = 0.0;
  double? ratingFuction(value) {
    setState(() {
      rating = value;
    });
    return null;
  }

//shortlist page button
  bool shortList = false;

  //custom text style
  TextStyle customTextStyle =
      TextStyle(color: Colors.grey.shade700, fontSize: 18);
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("dd/mm/yyyy").format(now);
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
      body: Container(
        padding: const EdgeInsets.all(20),
        height: size.height * 1,
        width: size.width * 1,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: size.height * 0.02,
            children: [
              //display user input image
              Container(
                height: size.height * 0.30,
                width: size.width * 1,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text("Image"),
                ),
              ),
              //category and date time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ITEM : ",
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
                        "description",
                        maxLines: 3,
                        style: customTextStyle,
                      ),
                    ),
                    Material(
                      shape: CircleBorder(),
                      color: Theme.of(context).primaryColor,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.directions_rounded,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),

              Text(
                "Age                : ",
                style: customTextStyle,
              ),
              Text("Price at buy  : ", style: customTextStyle),
              SizedBox(
                child: Row(
                  children: [
                    Text("Description   :  ", style: customTextStyle),
                    Expanded(
                      child: Text(
                        "content",
                        maxLines: 3,
                        style: customTextStyle,
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Text("Rating"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBar.builder(
                      minRating: 1,
                      direction: Axis.horizontal,
                      glow: true,
                      glowColor: Theme.of(context).primaryColor,
                      glowRadius: 0.2,
                      itemCount: 5,
                      itemSize: 30,
                      initialRating: 3,
                      allowHalfRating: true,
                      maxRating: 5.0,
                      unratedColor: Color(0xffE6EDBC),
                      itemPadding: EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Theme.of(context).primaryColor,
                      ),
                      onRatingUpdate: ratingFuction,
                    ),
                    LikeButton(
                        circleColor: const CircleColor(
                            start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: const BubblesColor(
                          dotPrimaryColor: Colors.blue,
                          dotSecondaryColor: Colors.white,
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            Icons.favorite,
                            color: isLiked
                                ? Colors.blue
                                : Colors.grey.withOpacity(0.5),
                            size: 40,
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 1,
                child: CustomElevatedButton(
                    text: "Accept Credit",
                    onPressed: () {
                      Future.delayed(const Duration(seconds: 2), () {
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavBar()),
                              (Route<dynamic> route) => false);
                        }
                      });
                    },
                    backgroundColor: Theme.of(context).primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
