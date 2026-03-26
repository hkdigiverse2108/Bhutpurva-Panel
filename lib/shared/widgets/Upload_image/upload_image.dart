import 'dart:io';
import 'dart:ui';
import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:bhutpurva_penal/core/constants/api_constants.dart';

class UploadImage extends StatefulWidget {
  final Function(XFile) onUpload;
  final String? imageUrl;
  final bool isUploading;

  const UploadImage({
    super.key,
    required this.onUpload,
    this.imageUrl,
    this.isUploading = false,
  });

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    if (widget.isUploading) return;
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void _clearSelection() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasSelection = _image != null;
    bool hasOldImage = widget.imageUrl != null && widget.imageUrl!.isNotEmpty;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConst.cardRadiusLg),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        padding: const EdgeInsets.all(SizeConst.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hasSelection
                      ? "Preview"
                      : (hasOldImage ? "Current Image" : "Upload Image"),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  splashRadius: 20,
                ),
              ],
            ),

            const SizedBox(height: SizeConst.spaceBtwItems),

            // Image Preview / Upload Area
            Flexible(
              child: AspectRatio(
                aspectRatio: 1,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: ColorConst.softGrey,
                      borderRadius: BorderRadius.circular(
                        SizeConst.borderRadiusLg,
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Image Display
                        _buildImagePreview(hasSelection, hasOldImage),

                        // Overlay / Empty State
                        if (!hasSelection && !hasOldImage)
                          _buildEmptyState()
                        else
                          _buildChangeOverlay(),

                        // Remove Button (only for new selection)
                        if (hasSelection)
                          Positioned(
                            top: 10,
                            right: 10,
                            child: InkWell(
                              onTap: _clearSelection,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: SizeConst.spaceBtwSections),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: ColorConst.borderPrimary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          SizeConst.buttonRadius,
                        ),
                      ),
                      minimumSize: const Size.fromHeight(
                        SizeConst.buttonHeight,
                      ),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: SizeConst.spaceBtwItems),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (hasSelection && !widget.isUploading)
                        ? () => widget.onUpload(_image!)
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(
                        SizeConst.buttonHeight,
                      ),
                    ),
                    child: widget.isUploading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text("Upload"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(bool hasSelection, bool hasOldImage) {
    if (hasSelection) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(SizeConst.borderRadiusLg),
        child: kIsWeb
            ? Image.network(_image!.path, fit: BoxFit.cover)
            : Image.file(File(_image!.path), fit: BoxFit.cover),
      );
    } else if (hasOldImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(SizeConst.borderRadiusLg),
        child: Image.network(
          widget.imageUrl!.startsWith("http")
              ? widget.imageUrl!
              : ApiConstants.baseUrl + widget.imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildErrorState(),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildEmptyState() {
    return CustomPaint(
      painter: DashRectPainter(color: ColorConst.grey, gap: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            size: 48,
            color: ColorConst.primary.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 12),
          Text(
            "Tap to upload an image",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ColorConst.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Supports: JPG, PNG, WEBP",
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: ColorConst.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeOverlay() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.black38,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit, color: Colors.white, size: 16),
            SizedBox(width: 8),
            Text(
              "Tap to change",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, color: ColorConst.error, size: 40),
        SizedBox(height: 8),
        Text("Failed to load image", style: TextStyle(color: ColorConst.error)),
      ],
    );
  }
}

class DashRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashRectPainter({
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(SizeConst.borderRadiusLg),
        ),
      );

    Path dashPath = Path();
    double dashWidth = 10.0;
    double dashSpace = gap;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(DashRectPainter oldDelegate) => false;
}
