import 'package:flutter/material.dart';

import '../../models/qr.dart';

class ScannerControl extends StatelessWidget {
  final Qr qrkey;
  final double height;
  final double width;
  final VoidCallback scan;

  const ScannerControl(
      {Key? key,
      required this.qrkey,
      required this.scan,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return qrkey.isValid()
        ? _showNom(context, qrkey, scan, height, width)
        : _botoOutlined(context, scan, "Escanneja QR", height, width);
  }
}

Widget _botoOutlined(BuildContext context, VoidCallback metode, String text,
    double height, double width) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: Theme.of(context).primaryColor),
      padding: EdgeInsets.symmetric(
        horizontal: height,
        vertical: width,
      ),
    ),
    onPressed: metode,
    child: Text(text),
  );
}

Widget _showNom(BuildContext context, Qr qr, VoidCallback metode, double heigth,
    double width) {
  return Container(
    color: Theme.of(context).primaryColor,
    child: Row(
      children: [
        Flexible(
          child: Center(
            heightFactor: 1.1,
            child: Column(
              children: [
                Text(
                  qr.getFullName(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.replay_rounded,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: metode,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
