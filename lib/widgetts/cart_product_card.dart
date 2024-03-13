import 'package:alh/models/models.dart';
import 'package:flutter/material.dart';


class CartProductCard extends StatelessWidget {
  final Product product;

  const CartProductCard({Key? key, required this.product}) : super(key: key);

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
                  '\$${product.price}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Row(
            children: [
              IconButton(icon: Icon(Icons.remove_circle), onPressed: () {}),
              Text(
                '1',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: 14),
              ),
              IconButton(icon: Icon(Icons.add_circle), onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }
}
