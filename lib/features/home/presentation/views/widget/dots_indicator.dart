import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({super.key, required this.currentPageIndex});
  final int currentPageIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          5,
          (index) => Padding(
                padding: const EdgeInsets.only(right: 6),
                child: CustomDot(isActive: index == currentPageIndex),
              )),
    );
  }
}

class CustomDot extends StatelessWidget {
  const CustomDot({super.key, required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 50 : 8,
      height: 8,
      decoration: ShapeDecoration(
        color: isActive
            ? const Color.fromARGB(255, 224, 9, 9)
            : const Color(0xFFE7E7E7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
