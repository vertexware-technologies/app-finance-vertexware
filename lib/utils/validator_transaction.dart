import 'package:finance_vertexware/enum/payment_method.dart';

String? validateCategory(int? value) {
  if (value == null) {
    return 'Selecione uma categoria';
  }
  return null;
}

String? validateAccountType(int? value) {
  if (value == null) {
    return 'Selecione um tipo de conta';
  }
  return null;
}

String? validateDescription(String? value) {
  if (value == null || value.isEmpty) {
    return 'Informe a descrição';
  }
  return null;
}

String? validateAmount(String? value) {
  if (value == null || double.tryParse(value) == null) {
    return 'Informe um valor válido';
  }
  return null;
}

String? validatePaymentMethod(PaymentMethod? value) {
  if (value == null) {
    return 'Selecione um método de pagamento';
  }
  return null;
}
