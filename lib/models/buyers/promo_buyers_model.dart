// ignore_for_file: non_constant_identifier_names

class PromoBuyersModel {
  PromoBuyersModel({
    required this.promo_code,
    required this.promo_title,
    required this.promo_description,
    required this.promo_total,
    required this.promo_end,
  });

  final String promo_code;
  final String promo_title;
  final String promo_description;
  final String promo_end;
  final int promo_total;
  bool checked = false;
}
