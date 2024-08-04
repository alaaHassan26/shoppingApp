import 'package:flutter/material.dart';
import 'package:shoping/features/home/data/models/image_model.dart';

class ImageApsectratio extends StatelessWidget {
  const ImageApsectratio({
    super.key,
    required this.imageModel,
    this.onTap,
  });
  final ImageModel imageModel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 330 / 215,
        child: Image.asset(
          imageModel.image,
          height: height,
          width: width,
        ),
      ),
    );
  }
}
