// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mien_spa_mobile/global_component/custom_circularProgressIndicator.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
    this.height = 125,
    this.borderRadius = 20,
    required this.width,
    required this.imageUrl,
    this.padding,
    this.margin,
    this.child,
    required this.boxfit,
  }) : super(key: key);

  final double width;
  final double height;
  final String imageUrl;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double borderRadius;
  final Widget? child;
  final BoxFit? boxfit;

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     height: height,
  //     width: width,
  //     margin: margin,
  //     padding: padding,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(borderRadius),
  //       image: DecorationImage(
  //         image: NetworkImage(imageUrl),
  //         fit: boxfit,
  //       ),
  //     ),
  //     child: child,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
            image: imageProvider,
            fit: boxfit,
          ),
        ),
        child: child,
      ),
      placeholder: (context, url) => CustomCircularProgressIndicator(
        duration: Duration(milliseconds: 600),
        strokeWidth: 3,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.contain,
    );
  }
}
