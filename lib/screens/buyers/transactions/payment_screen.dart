// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:melijo/configs/functions/action.dart';
import 'package:melijo/models/buyers/cart_buyers_model.dart';
import 'package:melijo/models/buyers/promo_buyers_model.dart';
import 'package:melijo/screens/buyers/dashboard/dashboard_buyers_screen.dart';
import 'package:melijo/screens/buyers/transactions/payment_proof_screen.dart';
import 'package:melijo/utils/colours.dart';
import 'package:melijo/utils/font_styles.dart';
import 'package:melijo/widgets/loading_widget.dart';
import 'package:melijo/widgets/modal_bottom.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  static const String route = '/payment_screen';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late List<CartBuyersModel> carts;
  late DateTime date_distribution;
  late String distribution_info;
  final List<PromoBuyersModel> _promoList = [];
  String? payment_method;
  String? selected_promo;
  bool paid = false;
  bool isExpandedPaymentMethod = false;
  bool isExpandedPromo = false;
  bool result = false;

  @override
  void initState() {
    getPromo();
    super.initState();
  }

  Future<void> getPromo() async {
    try {
      final List<PromoBuyersModel> listPromo = await getPromos();
      setState(() {
        _promoList.addAll(listPromo);
      });
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

  int totalEachProduct(int index) {
    return carts[index].product.price * carts[index].quantity;
  }

  int totalProduct() {
    int subTotal = 0;
    for (CartBuyersModel element in carts) {
      subTotal += element.product.price * element.quantity;
    }
    for (PromoBuyersModel promo
        in _promoList.where((element) => element.checked)) {
      subTotal -= promo.promo_total;
    }
    return subTotal;
  }

  Future<void> newTransaction() async {
    try {
      LoadingWidget.show(context);
      PromoBuyersModel? promo =
          _promoList.where((element) => element.checked).isEmpty
              ? null
              : _promoList.firstWhere((element) => element.checked);
      final Map transaction = await addTransaction(
          carts, promo, date_distribution, totalProduct(), distribution_info);
      LoadingWidget.close(context);
      bool result = await Navigator.of(context).pushNamed(
        PaymentProofScreen.route,
        arguments: {
          'transactions': transaction,
          'total': totalProduct(),
        },
      ) as bool;
      setState(() {
        this.result = result;
      });
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

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    carts = arguments['products'];
    date_distribution = arguments['distribution_date'];
    distribution_info = arguments['distribution_info'];
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
          'Pembayaran',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontStyles.bold,
            fontFamily: FontStyles.lora,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // * Product List
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: carts.length,
            itemBuilder: (context, index) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // * Product
                Expanded(
                  flex: 3,
                  child: Text(
                    '${carts[index].product.product_name} (x${carts[index].quantity})',
                    style: const TextStyle(
                      color: Colours.black,
                      fontFamily: FontStyles.leagueSpartan,
                      fontWeight: FontStyles.regular,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
                // * Total Price for each product
                Expanded(
                  flex: 1,
                  child: Text(
                    'Rp. ${thousandFormat(totalEachProduct(index))}',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colours.gray,
                      fontFamily: FontStyles.leagueSpartan,
                      fontWeight: FontStyles.regular,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                    color: Colours.gray,
                    width: 1,
                  )),
                ),
              )),
              const Text(
                ' +',
                style: TextStyle(
                  color: Colours.gray,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: carts[0].grouping != 'none',
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8,),
                  color: Colours.deepGreen,
                  child: Text(
                    carts[0].grouping,
                    style: const TextStyle(
                      color: Colours.white,
                      fontSize: 16,
                      fontFamily: FontStyles.leagueSpartan,
                      fontWeight: FontStyles.regular,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Rp. ${thousandFormat(totalProduct())}',
                style: const TextStyle(
                  color: Colours.gray,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // * Payment Method
          ExpansionPanelList(
            expansionCallback: (int item, bool status) {
              setState(() {
                isExpandedPaymentMethod = !isExpandedPaymentMethod;
              });
            },
            children: [
              ExpansionPanel(
                isExpanded: isExpandedPaymentMethod,
                headerBuilder: (context, isExpanded) => Container(
                  padding: const EdgeInsets.all(18),
                  child: const Text(
                    'Online Payment Via Transfer',
                    style: TextStyle(
                      color: Colours.black,
                      fontSize: 16,
                      fontFamily: FontStyles.leagueSpartan,
                    ),
                  ),
                ),
                body: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Card(
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: Colours.deepGreen,
                                fontSize: 16,
                                fontWeight: FontStyles.bold,
                                fontFamily: FontStyles.leagueSpartan,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Pilih transfer ke rekening berikut :',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colours.black,
                                    fontSize: 16,
                                    fontFamily: FontStyles.leagueSpartan,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // * BCA
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'lib/assets/images/bca.png'),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                      height: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      '3160330341\nan Farah Fathimah Azzahra',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        color: Colours.gray,
                                        fontSize: 16,
                                        height: 1.1,
                                        fontWeight: FontStyles.regular,
                                        fontFamily: FontStyles.leagueSpartan,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () async {
                                        await Clipboard.setData(
                                            const ClipboardData(
                                                text: '3160330341'));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('Nomor Rekening tersalin!'),
                                          backgroundColor: Colours.deepGreen,
                                        ));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: Colours.deepGreen
                                                .withOpacity(.25),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(64))),
                                        child: const Text(
                                          'SALIN',
                                          style: TextStyle(
                                            color: Colours.deepGreen,
                                            fontSize: 16,
                                            fontWeight: FontStyles.regular,
                                            fontFamily:
                                                FontStyles.leagueSpartan,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // * BRI
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'lib/assets/images/bri.png'),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                      height: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      '0554 0103 1005 509\nan Habib Fitriana Azzahra',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        color: Colours.gray,
                                        fontSize: 16,
                                        height: 1.1,
                                        fontWeight: FontStyles.regular,
                                        fontFamily: FontStyles.leagueSpartan,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () async {
                                        await Clipboard.setData(
                                            const ClipboardData(
                                                text: '0554 0103 1005 509'));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('Nomor Rekening tersalin!'),
                                          backgroundColor: Colours.deepGreen,
                                        ));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: Colours.deepGreen
                                                .withOpacity(.25),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(64))),
                                        child: const Text(
                                          'SALIN',
                                          style: TextStyle(
                                            color: Colours.deepGreen,
                                            fontSize: 16,
                                            fontWeight: FontStyles.regular,
                                            fontFamily:
                                                FontStyles.leagueSpartan,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // * BTN
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'lib/assets/images/btn.png'),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                      height: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      '6221 0082 0861 3128\nan Habib Fitriana Azzahra',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        color: Colours.gray,
                                        fontSize: 16,
                                        height: 1.1,
                                        fontWeight: FontStyles.regular,
                                        fontFamily: FontStyles.leagueSpartan,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () async {
                                        await Clipboard.setData(
                                            const ClipboardData(
                                                text: '6221 0082 0861 3128'));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('Nomor Rekening tersalin!'),
                                          backgroundColor: Colours.deepGreen,
                                        ));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: Colours.deepGreen
                                                .withOpacity(.25),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(64))),
                                        child: const Text(
                                          'SALIN',
                                          style: TextStyle(
                                            color: Colours.deepGreen,
                                            fontSize: 16,
                                            fontWeight: FontStyles.regular,
                                            fontFamily:
                                                FontStyles.leagueSpartan,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Card(
                            child: Text(
                              '2',
                              style: TextStyle(
                                color: Colours.deepGreen,
                                fontSize: 16,
                                fontWeight: FontStyles.bold,
                                fontFamily: FontStyles.leagueSpartan,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Kirimkan bukti bayar di kolom kanan bawah',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colours.black,
                                fontSize: 16,
                                fontFamily: FontStyles.leagueSpartan,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // * Promo
          ExpansionPanelList(
            expansionCallback: (int item, bool status) {
              setState(() {
                isExpandedPromo = !isExpandedPromo;
              });
            },
            children: [
              ExpansionPanel(
                isExpanded: isExpandedPromo,
                headerBuilder: (context, isExpanded) => Container(
                  padding: const EdgeInsets.all(18),
                  child: const Text(
                    'Promo yang tersedia',
                    style: TextStyle(
                      color: Colours.black,
                      fontSize: 16,
                      fontFamily: FontStyles.leagueSpartan,
                    ),
                  ),
                ),
                body: Container(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _promoList.length,
                    itemBuilder: (context, index) => CheckboxListTile(
                      title: Text(_promoList[index].promo_title),
                      value: _promoList[index].checked,
                      activeColor: Colours.deepGreen,
                      onChanged: (value) {
                        setState(() {
                          for (PromoBuyersModel promo in _promoList) {
                            promo.checked = false;
                          }
                          _promoList[index].checked =
                              !_promoList[index].checked;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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
            // *Total Price
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Harga',
                  style: TextStyle(
                    color: Colours.black,
                    fontSize: 14,
                    fontWeight: FontStyles.regular,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
                Text(
                  'Rp. ${thousandFormat(totalProduct())} ${(_promoList.where((element) => element.checked).isNotEmpty ? '(Promo)' : '')}',
                  style: const TextStyle(
                    color: Colours.black,
                    fontSize: 16,
                    fontWeight: FontStyles.bold,
                    fontFamily: FontStyles.leagueSpartan,
                  ),
                ),
              ],
            ),
            // *Buy Button
            ElevatedButton(
              onPressed: () {
                if (result) {
                  Navigator.of(context).pushNamedAndRemoveUntil(DashboardBuyersScreen.route, (route) => false);
                } else {
                  newTransaction();
                }
              },
              child: Text(
                result ? 'Kembali ke Dashboard!' : 'Kirim Bukti Bayar',
                style: const TextStyle(
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
