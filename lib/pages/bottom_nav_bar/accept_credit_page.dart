import 'package:flutter/material.dart';
import 'package:swap_cust_app/constants/constants.dart';
import 'package:swap_cust_app/widgets/custom_elevated_button.dart';

class AcceptCreditPage extends StatelessWidget {
  const AcceptCreditPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle customTextStyle = TextStyle(
        color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w400);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Store Name",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: size.height * 0.02,
            children: [
              //category and sid number
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Appliances",
                    style: customTextStyle,
                  ),
                  Text(
                    "SID : 1124",
                    style: customTextStyle,
                  ),
                ],
              ),

              //image
              Container(
                height: size.height * 0.20,
                width: size.width * 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    )),
                child: Center(
                  child: Text("Redeemed Image"),
                ),
              ),
              Text("Item Name :", style: customTextStyle),
              Text("Item Description :", style: customTextStyle),
              // price and point
              Text("Price :", style: customTextStyle),
              Text("Points :", style: customTextStyle),
              Text("Product Purchase Price :", style: customTextStyle),
              Text("Location :", style: customTextStyle),
              Text("Date :", style: customTextStyle),
              //qr code
              Center(
                child: Text("Order ID : 545487487854887"),
              ),
              Center(
                child: Container(
                  height: size.height * 0.20,
                  width: size.width * 0.40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(qr), fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 1,
                child: CustomElevatedButton(
                  text: "Accept",
                  onPressed: () {},
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
