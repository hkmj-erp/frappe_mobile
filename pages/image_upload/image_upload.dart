import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import '../../utils/local.dart';
import '../../widgets/ui.dart';

class ImageUploadService extends StatefulWidget {
  const ImageUploadService({super.key});

  @override
  State<ImageUploadService> createState() => _ImageUploadServiceState();
}

class _ImageUploadServiceState extends State<ImageUploadService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(" Please select the option below:"),
            const SizedBox(height: 50),
            ReusableButton(
                title: "Camera",
                onTap: () async {
                  String? path = await pickImage(sourceType: ImageSource.camera);
                  if (!mounted) return;
                  Navigator.pop(context, path);
                }),
            const SizedBox(height: 20),
            ReusableButton(
                title: "Gallery",
                onTap: () async {
                  String? path = await pickImage(sourceType: ImageSource.gallery);
                  if (!mounted) return;
                  Navigator.pop(context, path);
                })
          ],
        ),
      ),
    );
  }

  Future<String?> pickImage({required ImageSource sourceType}) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: sourceType);
    if (pickedImage == null) return null;

    String? croppedImagePath = await _cropImage(pickedImage.path);
    if (croppedImagePath == null) return pickedImage.path;

    String? compressedFilePath = await compressAndGetFile(croppedImagePath);
    return compressedFilePath;
  }

  Future<String?> _cropImage(String pickedImagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedImagePath,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: const Color.fromARGB(255, 0, 0, 0),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Image Cropper',
        ),
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(
            width: 520,
            height: 520,
          ),
          viewPort: const CroppieViewPort(width: 480, height: 480, type: 'circle'),
          enableExif: true,
          enableZoom: true,
          showZoomer: true,
        ),
      ],
    );
    return croppedFile?.path;
  }

  Future<String?> compressAndGetFile(String filePath) async {
    String fileExtension = path.extension(filePath);
    Directory appDir = await getApplicationDocumentsDirectory();
    String newFilePath = path.join(appDir.path, generateRandomString(6) + fileExtension);

    CompressFormat format;

    switch (fileExtension) {
      case ".png":
        format = CompressFormat.png;
        break;
      case ".webp":
        format = CompressFormat.webp;
        break;
      default:
        format = CompressFormat.jpeg;
    }

    var result = await FlutterImageCompress.compressAndGetFile(filePath, newFilePath,
        minHeight: 360, minWidth: 640, format: format);
    return result?.path;
  }
}
