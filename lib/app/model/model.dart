import 'package:flutter/material.dart';

class Model {
  //complex drawer menu
  final IconData icon;
  final String title;
  final List<String> submenus;

  Model(this.icon, this.title, this.submenus);
}