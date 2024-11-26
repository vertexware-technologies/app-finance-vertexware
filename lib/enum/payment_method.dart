enum PaymentMethod {
  PIX,
  CARTAO,
  BOLETO,
}

extension PaymentMethodExtension on PaymentMethod {
  String get value {
    switch (this) {
      case PaymentMethod.PIX:
        return 'pix';
      case PaymentMethod.CARTAO:
        return 'cartão';
      case PaymentMethod.BOLETO:
        return 'boleto';
    }
  }

  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere((e) => e.value == value);
  }
}
