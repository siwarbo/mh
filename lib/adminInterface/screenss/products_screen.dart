//import 'package:alh/adminInterface/controllers/product_controller.dart';
import 'package:alh/screens/product/product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:alh/adminInterface/models/models.dart';
import 'package:alh/adminInterface/screenss/screenss.dart';
import 'package:alh/adminInterface/controllers/controlllers.dart';

class ProductsScreen extends StatelessWidget {
  static const String routeName = '/products';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ProductsScreen(),
    );
  }

  ProductsScreen({super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products',style: TextStyle(
            color: Colors
                .white, // Couleur du texte blanche pour une meilleure visibilité
          ),),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Card(
                margin: EdgeInsets.zero,
                color: Colors.black,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/newProduct');
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Add a New Product',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
                    return SizedBox(
                      height: 210,
                      child: ProductsCard(
                        product: product,
                        index: index,
                      ),
                    );
                  },
                ),
              ),
              // child: FutureBuilder<List<Product>>(
              //   future: productController.getProducts(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(child: CircularProgressIndicator());
              //     }

              //     if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     }

              //     final products = snapshot.data!;

              //     return Obx(
              //       () => ListView.builder(
              //         itemCount: products.length,
              //         itemBuilder: (context, index) {
              //           final product = products[index];
              //           return SizedBox(
              //             height: 210,
              //             child: ProductsCard(
              //               product: product,
              //               index: index,
              //             ),
              //           );
              //         },
              //       ),
              //     );
              //   },
              // ),
              // child: Obx(
              //   () => ListView.builder(
              //     itemCount: productController.products.length,
              //     itemBuilder: (context, index) {
              //       return SizedBox(
              //         height: 210,
              //         child: ProductsCard(
              //           product: productController.products[index],
              //           index: index,
              //         ),
              //       );
              //     },
              //   ),
              // ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductsCard extends StatelessWidget {
  final Product product;
  final int index;
  ProductsCard({super.key, required this.product, required this.index});

  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Slider(
                            value: product.price,
                            min: 0,
                            max: 25,
                            divisions: 10,
                            activeColor: Colors.black,
                            inactiveColor: Colors.black12,
                            onChanged: (value) {
                              productController.updateProductPrice(
                                index,
                                product,
                                value,
                              );
                            },
                            onChangeEnd: (value) {
                              productController.saveNewProductPrice(
                                  product, 'price', value);
                            },
                          ),
                          Text(
                            '\DT ${product.price.toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Text(
                              'Qty.',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Slider(
                            value: product.quantity.toDouble(),
                            min: 0,
                            max: 100,
                            divisions: 10,
                            activeColor: Colors.black,
                            inactiveColor: Colors.black12,
                            onChanged: (value) {
                              productController.updateProductQuantity(
                                index,
                                product,
                                value.toInt(),
                              );
                            },
                            onChangeEnd: (value) {
                              productController.saveNewProductQuantity(
                                  product, 'quantity', value.toInt());
                            },
                          ),
                          Text(
                            '${product.quantity.toInt()}',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
