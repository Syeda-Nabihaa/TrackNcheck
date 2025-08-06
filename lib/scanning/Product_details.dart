import 'package:flutter/material.dart';
import 'package:trackncheck/Services/ApiService.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/model/ProductModel.dart';

class ProductDetailsPage extends StatefulWidget {
  final String barcode;

  const ProductDetailsPage({Key? key, required this.barcode}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Product? product;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  void fetchProduct() async {
    final data = await fetchFromAllApis(widget.barcode);
    setState(() {
      product = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());
    if (product == null) return const Center(child: Text("Product not found"));

    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            if (product!.imageUrl != null)
              Center(child: Image.network(product!.imageUrl!, height: 200)),
            const SizedBox(height: 16),
            SubTitle(text: "Name: ${product!.name}", fontsize: 17),
            SubTitle(text: "Brand: ${product!.brand}", fontsize: 17),
            SubTitle(text: "Quantity: ${product!.quantity}", fontsize: 17),
            SubTitle(
              text: "Ingredients: ${product!.ingredients ?? 'N/A'}",
              fontsize: 17,
            ),
            SubTitle(text: "Labels: ${product!.labels ?? 'N/A'}", fontsize: 17),

            Text(
              "Expiry: ${product!.expirationDate ?? 'N/A'}",
              style: TextStyle(color: Colors.red , fontSize: 17),
            ),
            SubTitle(
              text: "Nutri-Score: ${product!.nutriScore ?? 'N/A'}",
              fontsize: 17,
            ),
            SubTitle(text: "Source: ${product!.source}", fontsize: 17),
          ],
        ),
      ),
    );
  }
}
