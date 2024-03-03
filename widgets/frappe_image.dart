import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/server.dart';

class FrappeImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final Widget? defaultWidget;
  const FrappeImage(
      {super.key, required this.imagePath, this.width, this.height, this.defaultWidget});

  @override
  Widget build(BuildContext context) {
    try {
      return FutureBuilder(
          future: getabsoulteImagePath(imagePath),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done && snap.data != null) {
              return SizedBox(
                width: width,
                height: height,
                child: CachedNetworkImage(
                  imageUrl: snap.data!,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              );
            } else {
              return defaultWidget ?? const SizedBox.shrink();
            }
          });
    } catch (e) {
      return defaultWidget ?? const SizedBox.shrink();
    }
  }
}
