
import 'package:flutter/material.dart';

class SafetyInfoTileData {
  final IconData icon;
  final String label;
  final String description;
  final Color? tileColor; // <-- add this
  final Color? iconColor; // <-- and this

  SafetyInfoTileData({
    required this.icon,
    required this.label,
    required this.description,
    this.tileColor,
    this.iconColor,
  });
}