import 'package:flutter/material.dart';
import 'package:shoping/core/utils/colors.dart';

class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isEditing;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const ProfileInfoItem({
    super.key,
    required this.icon,
    required this.text,
    this.isEditing = false,
    this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      controller?.text = text;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: colorRed),
          const SizedBox(width: 20),
          isEditing
              ? Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: text,
                    ),
                  ),
                )
              : Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
        ],
      ),
    );
  }
}
