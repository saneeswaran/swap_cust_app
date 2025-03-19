import 'package:flutter/material.dart';
import 'package:swap_cust_app/constants/constants.dart';
import 'package:swap_cust_app/widgets/custom_elevated_button.dart';

import '../../../widgets/custom_popular_category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        //  automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Welcome to Swap Shop",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // advertisement
            Container(
              margin: const EdgeInsets.all(20),
              height: size.height * 0.25,
              width: size.width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image:
                    DecorationImage(image: AssetImage(add), fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Who is looking to Exchange and But New?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    child: CustomElevatedButton(
                        text: "Swap Now",
                        onPressed: () {},
                        backgroundColor: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            // category

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Catergories that are popular",
                style: TextStyle(
                    color: Color(0xff909AA7),
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              height: size.height * 1,
              width: size.width * 1,
              child: CustomPopularCategory(size: size),
            )
          ],
        ),
      ),
    );
  }
}
