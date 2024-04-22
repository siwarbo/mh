import 'package:alh/blocs/cart/cart_bloc.dart';
import 'package:alh/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 14),
                ),
                Text(
                  //'\$${product.price}',
                  '\DT ${product.price.toStringAsFixed(1)}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            return Row(
              children: [
                IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      context.read<CartBloc>().add(CartProductRemoved(product));
                    }),
                Text(
                  '$quantity',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 14),
                ),
                IconButton(
                    icon: Icon(Icons.add_circle),
                    onPressed: () {
                      context.read<CartBloc>().add(CartProductAdded(product));
                    }),
              ],
            );
          })
        ],
      ),
    );
  }
}
