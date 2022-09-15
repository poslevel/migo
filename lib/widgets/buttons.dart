import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    this.buttonTitle,
    required this.onPressed,
    this.imageLeft,
    this.iconLeft,
    this.iconRight,
    this.bgColor = const Color(0xffff6900),
    this.textColor = const Color(0xffffffff),
    this.iconBgColor = Colors.transparent,
    this.border = BorderSide.none,
    this.horzPad = 8,
    this.vertPad = 14,
  }) : super(key: key);
  final String? buttonTitle;
  final void Function()? onPressed;
  final Image? imageLeft;
  final Icon? iconLeft;
  final Icon? iconRight;
  final Color? bgColor;
  final Color? textColor;
  final Color? iconBgColor;
  final BorderSide border;
  final double vertPad;
  final double horzPad;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color?>(textColor),
        backgroundColor: MaterialStateProperty.all<Color?>(bgColor),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
            EdgeInsets.symmetric(vertical: vertPad, horizontal: horzPad)),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
          return RoundedRectangleBorder(
              side: border, borderRadius: BorderRadius.circular(8));
        }),
        elevation: MaterialStateProperty.all<double>(0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding:
                imageLeft == null ? null : const EdgeInsets.only(right: 12),
            child: imageLeft,
          ),
          Container(
            padding: iconLeft == null ? null : const EdgeInsets.all(8),
            margin: iconLeft == null
                ? null
                : buttonTitle != null
                    ? const EdgeInsets.only(right: 12)
                    : null,
            decoration: BoxDecoration(
                color: iconBgColor, borderRadius: BorderRadius.circular(8)),
            child: iconLeft,
          ),
          if (buttonTitle != null)
            Text(
              buttonTitle!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          Container(
            padding:
                iconRight == null ? null : const EdgeInsets.only(right: 12),
            child: iconRight,
          ),
        ],
      ),
    );
  }
}
