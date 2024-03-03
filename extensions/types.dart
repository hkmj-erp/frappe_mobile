import 'package:flutter/material.dart';

extension DoubleExtension on double {
  String get formatCurrency {
    String sign = '';
    late double amount;
    if (this < 0) {
      sign = '-';
      amount = -this;
    } else {
      amount = this;
    }
    if (amount < 1000) {
      return '$sign₹${amount.toStringAsFixed(2)}'; // Format as plain Rupees
    } else if (amount < 100000) {
      double inThousands = amount / 1000;
      return '$sign₹${inThousands.toStringAsFixed(2)} K'; // Format as thousand Rupees
    } else if (amount < 10000000) {
      double inLacs = amount / 100000;
      return '$sign₹${inLacs.toStringAsFixed(2)} L'; // Format in Lacs
    } else {
      double inCrores = amount / 10000000;
      return '$sign₹${inCrores.toStringAsFixed(2)} Cr'; // Format in Crores
    }
  }
}

extension IntExtension on int {
  get formatNumber {
    if (this < 10000) {
      return toString(); // No formatting for numbers less than 10000
    } else if (this < 100000) {
      double inThousands = this / 1000;
      return '${inThousands.toStringAsFixed(1)}K'; // Format in thousands with one decimal place
    } else if (this < 1000000) {
      double inLacs = this / 100000;
      return '${inLacs.toStringAsFixed(1)}L'; // Format in lacs with one decimal place
    } else {
      return '${toStringAsFixed(0)}L'; // Format in lacs (rounded to nearest integer)
    }
  }
}

extension ColorExtension on String {
  abbr() {
    List<String> words = split(" ");
    String abbreviation = "";
    for (String word in words) {
      if (word.isNotEmpty) {
        abbreviation += word[0].toUpperCase();
      }
    }
    return abbreviation;
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() =>
      replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');

  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
