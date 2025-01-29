import 'package:swap_cust_app/constants/constants.dart';

class PopularCategoryModel {
  String imageUrl;
  String category;
  int productId;
  PopularCategoryModel(
      {required this.imageUrl,
      required this.category,
      required this.productId});

  static List<PopularCategoryModel> popularCategoryList = [
    PopularCategoryModel(
        imageUrl: accessories, category: "Accessories", productId: 0),
    PopularCategoryModel(
        imageUrl: appliances, category: "Appliances", productId: 1),
    PopularCategoryModel(
        imageUrl: furniture, category: "Furniture", productId: 2),
    PopularCategoryModel(
        imageUrl: electronics, category: "Electronics", productId: 3),
    PopularCategoryModel(
        imageUrl: accessories, category: "Accessories", productId: 4),
    PopularCategoryModel(
        imageUrl: appliances, category: "Appliances", productId: 5),
    PopularCategoryModel(
        imageUrl: furniture, category: "Furniture", productId: 6),
    PopularCategoryModel(
        imageUrl: electronics, category: "Electronics", productId: 7),
    PopularCategoryModel(
        imageUrl: accessories, category: "Accessories", productId: 8),
    PopularCategoryModel(
        imageUrl: appliances, category: "Appliances", productId: 9),
    PopularCategoryModel(
        imageUrl: furniture, category: "Furniture", productId: 10),
    PopularCategoryModel(
        imageUrl: electronics, category: "Electronics", productId: 11),
    PopularCategoryModel(
        imageUrl: accessories, category: "Accessories", productId: 12),
    PopularCategoryModel(
        imageUrl: appliances, category: "Appliances", productId: 13),
    PopularCategoryModel(
        imageUrl: furniture, category: "Furniture", productId: 14),
    PopularCategoryModel(
        imageUrl: electronics, category: "Electronics", productId: 15),
  ];
}
