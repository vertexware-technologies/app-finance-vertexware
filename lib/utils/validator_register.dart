class ValidatorRegister {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe o nome';
    }
    if (value.length < 3) {
      return 'O nome deve ter pelo menos 3 caracteres';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe o email';
    }
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Informe um email válido';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe a senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  static String? validatePasswordConfirmation(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirme a senha';
    }
    if (value != password) {
      return 'As senhas não correspondem';
    }
    return null;
  }
}
