// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mien_spa_mobile/global_component/image_container.dart';

class HomeServiceReuse extends StatelessWidget {
  const HomeServiceReuse(
      {Key? key,
      required this.name,
      required this.description,
      required this.image,
      required this.icon,
      required this.onPress,
      required this.width})
      : super(key: key);
  final String name;
  final String description;
  final String image;
  final IconData icon;
  final VoidCallback onPress;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Material(
          child: InkWell(
            onTap: onPress,
            child: ListTile(
              leading: SizedBox(
                width: 70,
                height: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageContainer(
                    boxfit: BoxFit.cover,
                    imageUrl: image,
                    width: width,
                  ),
                ),
              ),
              title: Column(children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.notoSansGeorgian(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  description,
                  style: GoogleFonts.roboto(fontSize: 16),
                ),
              ]),
              trailing: SizedBox(
                height: double.infinity,
                child: Icon(
                  icon,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
