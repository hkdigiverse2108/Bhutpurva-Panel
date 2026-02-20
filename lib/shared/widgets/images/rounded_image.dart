import 'dart:io';
import 'dart:typed_data';

import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:bhutpurva_penal/core/helpers/helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.applyImageRadius = true,
    this.border,
    this.borderRadius = SizeConst.md,
    this.fit = BoxFit.contain,
    this.image,
    this.file,
    this.overlayColor,
    this.backgroundColor,
    this.memoryImage,
    this.height = 56,
    this.width = 56,
    this.padding = SizeConst.sm,
    this.margin,
    required this.imageType,
  });

  final bool applyImageRadius;
  final BoxBorder? border;
  final double borderRadius;
  final BoxFit? fit;
  final String? image;
  final File? file;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Uint8List? memoryImage;
  final double height, width, padding;
  final double? margin;
  final ImageType imageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin != null ? EdgeInsets.all(margin!) : null,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        color: backgroundColor,
      ),
      child: _buildImageWidget(),
    );
  }

  Widget _buildImageWidget() {
    Widget imageWidget;

    switch (imageType) {
      case ImageType.network:
        imageWidget = _buildNetworkImage();
        break;
      case ImageType.file:
        imageWidget = _buildFileImage();
        break;
      case ImageType.memory:
        imageWidget = _buildMemoryImage();
        break;
      case ImageType.asset:
        imageWidget = _buildAssetImage();
        break;
    }

    return ClipRRect(
      borderRadius: applyImageRadius
          ? BorderRadius.circular(borderRadius)
          : BorderRadius.zero,
      child: imageWidget,
    );
  }

  Widget _buildNetworkImage() {
    if (image != null) {
      // Display image from network using Image widget
      return CachedNetworkImage(
        imageUrl: image!,
        fit: fit,
        color: overlayColor,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        progressIndicatorBuilder: (context, url, progress) =>
            _buildLoadingWidget(),
      );
    } else {
      // Return empty container if no image is provided
      return Container();
    }
  }

  Widget _buildMemoryImage() {
    if (memoryImage != null) {
      // Display image from memory using Image widget
      return Image.memory(memoryImage!, fit: fit, color: overlayColor);
    } else {
      // Return empty container if no memory image is provided
      return Container();
    }
  }

  Widget _buildFileImage() {
    if (file != null) {
      // Display image from file using Image widget
      return Image.file(file!, fit: fit, color: overlayColor);
    } else {
      // Return empty container if no file is provided
      return Container();
    }
  }

  Widget _buildAssetImage() {
    if (image != null) {
      // Display image from assets using Image is widget
      return Image(fit: fit, image: AssetImage(image!), color: overlayColor);
    } else {
      // Return empty container if no image is provided
      return Container();
    }
  }

  Widget _buildLoadingWidget() {
    final isDark = HelperFunctions.isDarkMode(Get.context!);

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
