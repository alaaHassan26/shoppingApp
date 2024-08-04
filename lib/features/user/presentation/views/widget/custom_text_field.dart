import 'package:flutter/material.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.isPassword = false,
    this.controller,
    this.errorText,
    this.onChanged,
  });

  final String labelText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? errorText;
  final Function(String)? onChanged;

  @override
  State<StatefulWidget> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(widget.controller!.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && !isPasswordVisible,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: AppStyles.styleMedium20(context),
            suffixIcon: widget.isPassword
                ? Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : null,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.errorText!,
                style:
                    AppStyles.styleRegular14(context).copyWith(color: colorRed),
              ),
            ),
          ),
      ],
    );
  }
}
// class CustomTextFiled extends StatelessWidget {
//   const CustomTextFiled({super.key, required this.labeltext});
//   final String labeltext;
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       decoration: InputDecoration(
//           labelText: labeltext,
//           suffixIcon: const Icon(
//             Icons.check_sharp,
//             color: Colors.green,
//           ),
//           border: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(8)))),
//     );
//   }
// }
