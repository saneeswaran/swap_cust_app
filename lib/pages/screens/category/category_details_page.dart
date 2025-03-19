// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CategoryDetailsPage extends StatefulWidget {
  final int productId;
  const CategoryDetailsPage({
    super.key,
    required this.productId,
  });

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Swap shop details",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: size.height * 0.30,
              width: size.width * 1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(''), fit: BoxFit.cover)),
            ),
          ],
        ),
      ),
    );
  }
}
