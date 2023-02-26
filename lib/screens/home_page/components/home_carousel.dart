// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mien_spa_mobile/global_component/image_container.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({Key? key}) : super(key: key);

  @override
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  List<Map<String, String>> carouselImage = [
    {
      "image":
          "https://images.unsplash.com/photo-1600334089648-b0d9d3028eb2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
    },
    {
      "image":
          "https://images.unsplash.com/photo-1596178060671-7a80dc8059ea?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80"
    },
    {
      "image":
          "https://images.unsplash.com/photo-1591343395082-e120087004b4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80"
    },
    {
      "image":
          "https://plus.unsplash.com/premium_photo-1661274122092-b9c89f8e9c70?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
    },
    {
      "image":
          "https://images.unsplash.com/photo-1664549760921-2198b054a592?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80"
    },
  ];

  late final PageController pageController;
  int pageNo = 0;

  Timer? carouselTimer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 2), (timer) {
      if (pageNo == carouselImage.length) {
        pageNo = 0;
      }
      if (pageController.hasClients) {
        pageController.animateToPage(pageNo,
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);
        pageNo++;
      }
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carouselTimer = getTimer();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              pageNo = index;
              setState(() {});
            },
            itemBuilder: (_, index) {
              return AnimatedBuilder(
                  animation: pageController,
                  builder: (context, child) {
                    return child!;
                  },
                  child: GestureDetector(
                    onPanDown: (d) {
                      carouselTimer?.cancel();
                      carouselTimer = null;
                    },
                    onPanCancel: () {
                      carouselTimer = getTimer();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          right: 8, left: 8, top: 24, bottom: 12),
                      child: ImageContainer(
                        boxfit: BoxFit.cover,
                        imageUrl: carouselImage[index]["image"].toString(),
                        width: double.infinity,
                      ),
                    ),
                  ));
            },
            itemCount: carouselImage.length,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              carouselImage.length,
              (index) => GestureDetector(
                  child: Container(
                margin: EdgeInsets.all(2.0),
                child: Icon(
                  Icons.circle,
                  size: 12,
                  color: pageNo == index ? Colors.black : Colors.grey.shade400,
                ),
              )),
            ))
      ]),
    );
  }
}
