import 'package:flutter/material.dart';
import 'package:swap_cust_app/model/popular_category_model.dart';
import 'package:swap_cust_app/pages/collect_product_page.dart';

class CustomPopularCategory extends StatelessWidget {
  CustomPopularCategory({
    super.key,
    required this.size,
  });

  final Size size;

//popular category
  final List<PopularCategoryModel> list =
      PopularCategoryModel.popularCategoryList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: list.length,
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
                            builder: (context) => CollectProductPage(
                                categoryId: list[index].productId,
                                model: list[index])));
                  },
                  child: Container(
                    height: size.height * 0.15,
                    width: size.width * 0.40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: AssetImage(PopularCategoryModel
                              .popularCategoryList[index].imageUrl),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  PopularCategoryModel.popularCategoryList[index].category,
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
