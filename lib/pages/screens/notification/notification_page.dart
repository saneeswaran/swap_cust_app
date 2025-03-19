import 'package:flutter/material.dart';

import 'notification_store_details.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

//custom text style
TextStyle customRowContainerTextStyle =
    TextStyle(color: Colors.grey, fontSize: 16);
//model

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    //custom text style
    TextStyle customBlueText =
        TextStyle(color: Theme.of(context).primaryColor, fontSize: 14);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        //  backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: size.height * 0.01,
            children: [
              SizedBox(height: size.height * 0.04),
              //title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "SwapShops",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //desc
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Below are a list of Shops with the exchange credit points.",
                  style: TextStyle(
                      fontSize: 12, color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              // name and status
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: size.height * 0.05,
                width: size.width * 1,
                decoration: BoxDecoration(
                    color: Color(0xffF0F5F9),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Name", style: customRowContainerTextStyle),
                    Text(
                      "Status",
                      style: customRowContainerTextStyle,
                    )
                  ],
                ),
              ),
              ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          // height: size.height * 10,
                          // width: size.width * 1,
                          child: Row(
                            children: [
                              //image
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, top: 20, bottom: 3),
                                    height: size.height * 0.12,
                                    width: size.width * 0.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 2),
                                      image: DecorationImage(
                                          image: AssetImage(''),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                margin: const EdgeInsets.only(top: 25),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: size.height * 0.001,
                                      children: [
                                        Text(
                                          "A to Z Furniture",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "Location :",
                                          style: customBlueText,
                                        ),
                                        Text(
                                          "Credit :",
                                          style: customBlueText,
                                        ),
                                        Text("Minimum purchase :",
                                            style: customBlueText),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 55),
                                      child: SizedBox(
                                        height: size.height * 0.04,
                                        width: size.width * 0.19,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NotificationStoreDetails()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.orange,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                )),
                                            child: Text(
                                              "View",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey.shade400,
                          thickness: 0.8,
                        )
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
