bool emailError(String email) {
  final RegExp regex = RegExp(
    r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$",
  );
  return regex.hasMatch(email);
}

String? emailValid(String email) {
  if (email.isEmpty) {
    return 'Campo obrigatório';
  } else if (!emailError(email)) {
    return 'Email inválido';
  }
  return null;
}

String? nameValid(String name) {
  if (name.isEmpty) {
    return 'Campo obrigatório';
  } else if (name.trim().split('').isEmpty) {
    return 'Preencha seu Nome completo';
  }
  return null;
}

String? passValid(String pass1) {
  if (pass1.isEmpty) {
    return 'Campo obrigatório';
  } else if (pass1.length < 6) {
    return 'Mínimo de 6 caracteres';
  }
  return null;
}
