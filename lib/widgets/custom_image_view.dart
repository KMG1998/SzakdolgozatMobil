import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageView extends StatelessWidget {
  final String? imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final Alignment? alignment;

  const CustomImageView({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildImageView(),
          )
        : _buildImageView();
  }

  Widget _buildImageView() {
    if (imagePath != null) {
      switch (imagePath!.imageType) {
        case ImageType.svg:
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imagePath!,
              height: height,
              width: width,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(color ?? Colors.transparent, BlendMode.srcIn),
            ),
          );
        default:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: BoxFit.scaleDown,
            color: color,
          );
      }
    }
    return const SizedBox();
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (endsWith('.svg')) {
      return ImageType.svg;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png }
