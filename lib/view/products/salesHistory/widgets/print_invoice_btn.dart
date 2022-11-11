import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/widgets/buttons.dart';

class PrintInvoiceBtn extends StatelessWidget {
  final Future<void> Function() printFunction;
  const PrintInvoiceBtn({
    Key? key,
    required this.printFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      buttonTitle: "Print Bill",
      onPressed: printFunction,
      iconLeft: const Icon(Iconsax.printer),
      bgColor: const Color(0xffDAEEB8),
      textColor: const Color(0xff1F212E),
      iconBgColor: const Color(0xffBEE29B),
    );
  }
}
