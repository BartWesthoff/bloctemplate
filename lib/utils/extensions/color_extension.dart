import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color operator +(Color other) => Color.alphaBlend(this, other);
}
