import 'package:alh/adminInterface/models/product_model.dart';
import 'package:alh/adminInterface/services/database_service.dart';
import 'package:alh/adminInterface/services/storage_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:alh/adminInterface/controllers/controlllers.dart';

class NewProductScreen extends StatelessWidget {
  static const String routeName = '/newProduct';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => NewProductScreen(),
    );
  }

  NewProductScreen({super.key});
  final ProductController productController = Get.find();

  StorageService storage =
      StorageService(storageBucket: 'gs://alhm-3f712.appspot.com');

  DatabaseService database = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add a Product',
          style: TextStyle(
            color: Colors
                .white, // Couleur du texte blanche pour une meilleure visibilité
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: Colors.black,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            //Navigator.pushNamed(context, '/newProduct');
                            ImagePicker _picker = ImagePicker();
                            final XFile? _image = await _picker.pickImage(
                                source: ImageSource.gallery);

                            if (_image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No image was Selected.'),
                                ),
                              );
                            }

                            if (_image != null) {
                              await storage.uploadImage(_image);
                              var imageUrl =
                                  await storage.getDownloadURL(_image.name);

                              productController.newProduct.update(
                                  'imageUrl', (_) => imageUrl,
                                  ifAbsent: () => imageUrl);

                              //print(productController.newProduct['imageUrl']);
                            }
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Add an Image',
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
                const SizedBox(height: 20),
                const Text(
                  'Product Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTextFormField(
                  'Product ID',
                  'id',
                  productController,
                ),
                _buildTextFormField(
                  'Product Name',
                  'name',
                  productController,
                ),
                _buildTextFormField(
                  'Product Description',
                  'description',
                  productController,
                ),
                _buildTextFormField(
                  'Product Category',
                  'category',
                  productController,
                ),
                const SizedBox(height: 10),
                _buildSlider(
                  'Price',
                  'price',
                  productController,
                  productController.price,
                ),
                _buildSlider(
                  'Quantity',
                  'quantity',
                  productController,
                  productController.quantity,
                ),
                const SizedBox(height: 10),
                _buildCheckbox(
                  'Recommended',
                  'isRecommended',
                  productController,
                  productController.isRecommended,
                ),
                _buildCheckbox(
                  'Popular',
                  'isPopular',
                  productController,
                  productController.isPopular,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      //print(productController.newProduct);
                      database.addProduct(
                        Product(
                          id: productController.newProduct['id'],
                          name: productController.newProduct['name'],
                          category: productController.newProduct['category'],
                          description:
                              productController.newProduct['description'],
                          imageUrl: productController.newProduct['imageUrl'],
                          isRecommended:
                              productController.newProduct['isRecommended'],
                          isPopular: productController.newProduct['isPopular'],
                          price: productController.newProduct['price'],
                          quantity:
                              productController.newProduct['quantity'].toInt(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildCheckbox(
    String title,
    String name,
    ProductController productController,
    bool? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          checkColor: Colors.black,
          activeColor: Colors.black12,
          onChanged: (value) {
            productController.newProduct.update(
              name,
              (_) => value,
              ifAbsent: () => value,
            );
          },
        ),
      ],
    );
  }

  Row _buildSlider(
    String title,
    String name,
    ProductController productController,
    double? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: (controllerValue == null) ? 0 : controllerValue,
            min: 0,
            max: 25,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            onChanged: (value) {
              productController.newProduct.update(
                name,
                (_) => value,
                ifAbsent: () => value,
              );
            },
          ),
        ),
      ],
    );
  }

  TextFormField _buildTextFormField(
    String hintText,
    String name,
    ProductController productController,
  ) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      onChanged: (value) {
        productController.newProduct.update(
          name,
          (_) => value,
          ifAbsent: () => value,
        );
      },
    );
  }
}
