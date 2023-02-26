// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductDetailsCarousel extends StatefulWidget {
  final List<String> imgList;
  const ProductDetailsCarousel({
    Key? key,
    required this.imgList,
  }) : super(key: key);

  @override
  _ProductDetailsCarouselState createState() => _ProductDetailsCarouselState();
}

class _ProductDetailsCarouselState extends State<ProductDetailsCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  late List<Widget> imageSliders = widget.imgList
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(item,
                      fit: BoxFit.cover, width: double.infinity),
                ],
              ),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            viewportFraction: 1,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            initialPage: 0,
            onPageChanged: (index, reason) {
              setState(
                () {
                  _current = index;
                },
              );
            },
          ),
          items: imageSliders,
        ),
      ],
    );
  }
}
