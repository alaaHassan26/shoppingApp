import 'package:flutter/material.dart';

class CustomItemModel {
  final String textTitle;
  final String textSubTitle;
  final Widget trailing;

  const CustomItemModel(
      {required this.textTitle,
      required this.textSubTitle,
      required this.trailing});
}
