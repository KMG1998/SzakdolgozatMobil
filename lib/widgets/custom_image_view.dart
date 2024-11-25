import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageView extends StatefulWidget {

  String? imagePath;
  double? height;
  double? width;
  Color? color;
  BoxFit? fit;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;

  CustomImageView({super.key, 
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
  });

  @override
  State<CustomImageView> createState() => _CustomImageViewState();
}

class _CustomImageViewState extends State<CustomImageView> {
  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: widget.onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  _buildCircleImage() {
    if (widget.radius != null) {
      return ClipRRect(
        borderRadius: widget.radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  _buildImageWithBorder() {
    if (widget.border != null) {
      return Container(
        decoration: BoxDecoration(
          border: widget.border,
          borderRadius: widget.radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (widget.imagePath != null) {
      switch (widget.imagePath!.imageType) {
        case ImageType.svg:
          return SizedBox(
            height: widget.height,
            width: widget.width,
            child: SvgPicture.asset(
              widget.imagePath!,
              height: widget.height,
              width: widget.width,
              fit: widget.fit ?? BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                  widget.color ?? Colors.transparent, BlendMode.srcIn),
            ),
          );
        case ImageType.png:
        default:
          return Image.asset(
            widget.imagePath!,
            height: widget.height,
            width: widget.width,
            fit: widget.fit ?? BoxFit.scaleDown,
            color: widget.color,
          );
      }
    }
    return const SizedBox();
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }
