import 'package:flutter/material.dart';

// Palet warna Dapur Ceria
const kMint = Color(0xFFD4F1E8);
const kYellow = Color(0xFFFFD84D);
const kLilac = Color(0xFFE3D4F7);
const kGreen = Color(0xFFC9EFD0);
const kCream = Color(0xFFFFF3B0);
const kText = Color(0xFF1F2A2E);

// Warna pastel bergantian untuk lingkaran emoji
Color pastelFor(int id) {
  const colors = [kLilac, kGreen, kCream];
  return colors[id % colors.length];
}