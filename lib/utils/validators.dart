String? emptyValidator(value) {
  if (value == null) {
    return "Informe o valor deste campo!";
  }
  return null;
}

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return "Digite seu e-mail!";
  }
  return null;
}

String? passwordValidator(password) {
  if (password == null || password.isEmpty) {
    return "Digite sua senha!";
  }
  if (password.length < 6) {
    return "Sua senha deve ter no mínimo 6 caracteres.";
  }
  return null;
}

String? nameValidator(name) {
  if (name == null || name.isEmpty) {
    return "Digite o nome!";
  }
  return null;
}
