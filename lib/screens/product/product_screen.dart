import 'package:alh/blocs/cart/cart_bloc.dart';
import 'package:alh/blocs/wishlist/wishlist_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:alh/widgetts/widgets.dart';
import 'package:alh/models/product_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route({required Product product}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ProductScreen(product: product),
    );
  }

  final Product product;

  const ProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.share, color: Colors.white),
                onPressed: () {},
              ),
              BlocBuilder<WishlistBloc, WishlistState>(
                  builder: (context, state) {
                return IconButton(
                  icon: Icon(Icons.favorite, color: Colors.white),
                  onPressed: () {
                    context
                        .read<WishlistBloc>()
                        .add(AddWishListProduct(product));

                    final snackBar =
                        SnackBar(content: Text('Added to your Wishlist!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                );
              }),
              BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    context.read<CartBloc>().add(CartProductAdded(product));
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: Text('ADD TO CART',
                      style: Theme.of(context).textTheme.headline5!),
                );
              })
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1.5,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              // enableInfiniteScroll: false,
            ),
            items: [
              HeroCarouselCard(
                product: product,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.bottomCenter,
                  color: Colors.black.withAlpha(50),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 50,
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          //'\DT ${product.price}',
                          '\DT ${product.price.toStringAsFixed(1)}',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text('Product Information',
                  style: Theme.of(context).textTheme.headline5),
              children: [
                ListTile(
                  title: Text(
                      'Discover a symphony of flavors at our restaurant, where every dish is a masterpiece crafted with the finest ingredients.',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              title: Text('Delevery Information',
                  style: Theme.of(context).textTheme.headline5),
              children: [
                ListTile(
                  title: Text(
                      'Enjoy the convenience of having your favorite dishes delivered straight to your doorstep! Our delivery service ensures that your food arrives fresh and hot, ready to be savored in the comfort of your own home',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
