import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'upi_payment_qrcode_generator.dart';

/// Generates the UP IPayment QRCode
class UPIPaymentQRCode extends StatefulWidget {
  const UPIPaymentQRCode({
    Key? key,
    required this.upiDetails,
    this.size,
    this.loader,
    this.noBarcodeWidget,
  }) : super(key: key);

  /// The [upiDetails] is required, where we need to pass the object of the UPI Details contains in the UPI Object
  ///
  final UPIDetails upiDetails;

  /// The [size] parameter is completely a optional,
  ///
  /// Default value is null, It is basically for the QRCode width and height
  ///
  final double? size;

  /// The [loader] parameter is completely Optional,
  ///
  /// Default Circular Progress Loader will be shown
  ///
  final Widget? loader;

  /// The [noBarcodeWidget] paramete is used, If No Barcode gets generated in that case you need to provide a message
  ///
  /// Default value is a Text message No Data Found for Barcode", It is basically for the QRCode width and height
  ///
  final Widget? noBarcodeWidget;

  @override
  // ignore: library_private_types_in_public_api
  _UPIPaymentQRCodeState createState() => _UPIPaymentQRCodeState();
}

class _UPIPaymentQRCodeState extends State<UPIPaymentQRCode> {
  bool isLoading = true;
  String? barcodeData;

  @override
  void initState() {
    _loadBarcode();
    super.initState();
  }

  Future _loadBarcode() async {
    isLoading = true;
    setState(() {});
    barcodeData =
        _getBarcodeData(Barcode.qrCode(), widget.upiDetails.qrCodeValue);
    isLoading = false;
    setState(() {});
  }

  String _getBarcodeData(
    Barcode bc,
    String data,
  ) {
    return bc.toSvg(
      data,
      width: widget.size ?? MediaQuery.of(context).size.width * 0.7,
      height: widget.size ?? MediaQuery.of(context).size.width * 0.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: isLoading
          ? Center(
              child: widget.loader ?? const CircularProgressIndicator(),
            )
          : barcodeData == null
              ? widget.noBarcodeWidget ??
                  const Text("No Data Found for Barcode")
              : SvgPicture.string('''$barcodeData'''),
    );
  }
}
