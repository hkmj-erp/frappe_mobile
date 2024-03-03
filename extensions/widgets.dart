import 'package:flutter/material.dart';

extension CoverContainer on Widget {
  Container container(Color color) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
        child: FittedBox(fit: BoxFit.fitHeight, child: this));
  }
}
