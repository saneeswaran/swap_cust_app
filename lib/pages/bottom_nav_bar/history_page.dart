import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swap_cust_app/constants/constants.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    //custom text style
    TextStyle customBlueText = TextStyle(fontSize: 14);
    Size size = MediaQuery.of(context).size;

    //date time
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Reedem Credits',
            style: TextStyle(
                color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: size.height * 0.01,
            children: [
              SizedBox(height: size.height * 0.02),
              Center(
                child: Text(
                  "Transaction Redeemded",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                ),
              ),
              Center(
                child: Text(
                  "13000",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 2,
                thickness: 2,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Products",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 18),
                      ),
                    ),
                    ListView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            title: Row(
                              children: [
                                //image
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: size.height * 0.12,
                                      width: size.width * 0.25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2),
                                        image: DecorationImage(
                                            image: AssetImage(add),
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  margin: const EdgeInsets.only(
                                      top: 25, bottom: 20),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: size.height * 0.01,
                                        children: [
                                          Text(
                                            "A to Z Furniture",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            "product name",
                                            style: customBlueText,
                                          ),
                                          Text(
                                            formattedDate.toString(),
                                            style: customBlueText,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            children: [
                              Text("Order Date"),
                              Text("Delivery Date"),
                              Text("SOMETHING"),
                              Text("SOMETHING"),
                            ],
                          );
                        })
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
