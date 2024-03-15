import 'package:alh/blocs/category/category_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:alh/models/category_model.dart';
import 'package:alh/models/models.dart';
import 'package:alh/widgetts/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Zero To Unicorn'),
      bottomNavigationBar: CustomNavBar(),
      body: Column(
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
            if (state is CategoryLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CategoryLoaded) {
              return CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1.5,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                items: Category.categories
                    .map((category) => HeroCarouselCard(category: category))
                    .toList(),
              );
            } else {
              return Text('Something went wrong.');
            }
          }),
          SectionTitle(title: 'RECOMMENDED'),
          ProductCarousel(
              products: Product.products
                  .where((product) => product.isRecommended)
                  .toList()),
          SectionTitle(title: 'MOST POPULAR'),
          ProductCarousel(
              products: Product.products
                  .where((product) => product.isPopular)
                  .toList()),
        ],
      ),
    );
  }
}
