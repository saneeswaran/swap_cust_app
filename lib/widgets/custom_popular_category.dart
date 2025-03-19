import 'package:flutter/material.dart';

import '../pages/screens/collect product details/collect_product_page.dart';

class CustomPopularCategory extends StatelessWidget {
  CustomPopularCategory({
    super.key,
    required this.size,
  });

  final Size size;

//popular category

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 2,
        //  physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GridTile(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CollectProductPage()));
                  },
                  child: Container(
                    height: size.height * 0.15,
                    width: size.width * 0.40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: AssetImage(''), fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'category',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        });
  }
}
