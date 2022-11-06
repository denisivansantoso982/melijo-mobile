// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class PaymentProofScreen extends StatefulWidget {
  const PaymentProofScreen({Key? key}) : super(key: key);

  static const String route = '/payment_proof_screen';

  @override
  _PaymentProofScreenState createState() => _PaymentProofScreenState();
}

class _PaymentProofScreenState extends State<PaymentProofScreen> {
  final ImagePicker _picker = ImagePicker();
  late Map argument;
  XFile? file;
  Uint8List? image;

  Future<void> pickPaymentProof() async {
    try {
      XFile? theImage = await _picker.pickImage(source: ImageSource.gallery);
      if (theImage != null) {
        Uint8List dataImage = await theImage.readAsBytes();
        setState(() {
          file = theImage;
          image = dataImage;
        });
      }
    } catch (error) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colours.white,
          ),
          child: ModalBottom(
            title: 'Terjadi Kesalahan!',
            message: '$error',
            widgets: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colours.deepGreen, width: 1),
                  fixedSize: const Size.fromWidth(80),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Oke',
                  style: TextStyle(
                    color: Colours.deepGreen,
                    fontSize: 18,
                    fontWeight: FontStyles.regular,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Future<void> pay(BuildContext context) async {
    try {
      LoadingWidget.show(context);
      final String txid = argument['transactions']['transaction']['txid'];
      final int total = argument['total'];
      await payment(txid, file!, total);
      LoadingWidget.close(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Bukti Pembayaran Telah Dikirim!'),
        backgroundColor: Colours.deepGreen,
      ));
      Navigator.of(context).pop(true);
    } catch (error) {
      LoadingWidget.close(context);
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colours.white,
          ),
          child: ModalBottom(
            title: 'Terjadi Kesalahan!',
            message: '$error',
            widgets: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colours.deepGreen, width: 1),
                  fixedSize: const Size.fromWidth(80),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Oke',
                  style: TextStyle(
                    color: Colours.deepGreen,
                    fontSize: 18,
                    fontWeight: FontStyles.regular,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget generateContent(Size screenSize) {
    if (image == null) {
      return IconButton(
        onPressed: () => pickPaymentProof(),
        color: Colours.deepGreen,
        iconSize: 64,
        icon: const Icon(
          Icons.upload,
        ),
      );
    }
    return GestureDetector(
      onTap: () => pickPaymentProof(),
      child: Image(
        image: MemoryImage(image!),
        fit: BoxFit.cover,
        height: screenSize.height * .5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    argument = ModalRoute.of(context)!.settings.arguments as Map;
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1, -1),
              end: Alignment(0.2, 0.8),
              colors: [
                Colours.oliveGreen,
                Colours.deepGreen,
              ],
            ),
          ),
        ),
        title: const Text(
          'Konfirmasi Pembayaran',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontStyles.bold,
            fontFamily: FontStyles.lora,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colours.white,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colours.black.withOpacity(.25),
              offset: const Offset(2, 2),
            ),
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(child: generateContent(screenSize)),
                const SizedBox(height: 16),
                const Text(
                  'Upload bukti transfer disini',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                    color: Colours.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Butuh Bantuan?',
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                    color: Colours.black,
                  ),
                ),
                Text(
                  ' Hubungi CS Melijo.id',
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontStyles.medium,
                    fontFamily: FontStyles.leagueSpartan,
                    color: Colours.deepGreen,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        height: 72,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colours.lightGray,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            // *Buy Button
            ElevatedButton(
              onPressed: () {
                if (image == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Bukti Pembayaran dibutuhkan!'),
                    backgroundColor: Colours.red,
                  ));
                } else {
                  pay(context);
                }
              },
              child: const Text(
                'Kirim Sekarang',
                style: TextStyle(
                  color: Colours.white,
                  fontSize: 14,
                  fontWeight: FontStyles.medium,
                  fontFamily: FontStyles.leagueSpartan,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
