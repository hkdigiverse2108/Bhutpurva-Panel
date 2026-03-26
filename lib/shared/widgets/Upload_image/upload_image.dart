import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:bhutpurva_penal/core/constants/api_constants.dart';

class UploadImage extends StatefulWidget {
  final Function(XFile) onUpload;
  final String? imageUrl;

  const UploadImage({super.key, required this.onUpload, this.imageUrl});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 450,
        width: 420,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: _image != null
                      // ✅ NEW IMAGE
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: kIsWeb
                              ? Image.network(_image!.path, fit: BoxFit.cover)
                              : Image.file(
                                  File(_image!.path),
                                  fit: BoxFit.cover,
                                ),
                        )
                      // ✅ OLD IMAGE
                      : widget.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.imageUrl!.startsWith("http")
                                ? widget.imageUrl!
                                : ApiConstants.baseUrl + widget.imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      // ✅ EMPTY
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 50),
                            SizedBox(height: 10),
                            Icon(Icons.upload, size: 40),
                            SizedBox(height: 10),
                            Text("Tap to upload"),
                          ],
                        ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _image == null
                  ? null
                  : () {
                      widget.onUpload(_image!);
                    },
              child: const Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
