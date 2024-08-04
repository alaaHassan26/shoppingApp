import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoping/core/widget/shimmer_featured.dart';

class CustomCategoriesImage extends StatelessWidget {
  const CustomCategoriesImage(
      {super.key,
      required this.width,
      required this.height,
      required this.image});
  final double width;
  final double height;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: image,
          width: width,
          height: height,
          fit: BoxFit.cover,
          placeholder: (context, url) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const ShimmerFeaturedList()),
          errorWidget: (context, url, error) => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_outlined,
                size: 32,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Image Not Available',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
