import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowQR extends StatelessWidget {
  late String data;
   ShowQR({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: 200.0,
    );
  }
}
