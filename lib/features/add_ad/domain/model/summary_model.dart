class SummaryModel {
  final String? wallet;
  final String? coupon;
  final Details? details;

  SummaryModel({
    this.wallet,
    this.coupon,
    this.details,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      wallet: json['wallet'],
      coupon: json['coupon'],
      details:
          json['details'] != null ? Details.fromJson(json['details']) : null,
    );
  }
}

class Details {
  final String? price;
  final String? tax;
  final String? couponDiscount;
  final String? walletPaid;
  final String? total;
  final bool? isCredit;
  List<String?> itemsList = [];

  Details({
    this.price,
    this.tax,
    this.couponDiscount,
    this.walletPaid,
    this.total,
    this.isCredit,
  }) {
    itemsList.add(price);
    itemsList.add(tax);
    itemsList.add(total);
  }

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      price: json['price'],
      tax: json['tax'],
      couponDiscount: json['coupon_discount'],
      walletPaid: json['wallet_paid'],
      total: json['total'],
      isCredit: json['is_credit'],
    );
  }
}
