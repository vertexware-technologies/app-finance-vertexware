enum PaymentMethod {
  pix,
  card,
  boleto,
}

extension PaymentMethodExtension on PaymentMethod {
  String get value {
    switch (this) {
      case PaymentMethod.pix:
        return 'pix';
      case PaymentMethod.card:
        return 'card';
      case PaymentMethod.boleto:
        return 'boleto';
    }
  }

  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere((e) => e.value == value);
  }
}
