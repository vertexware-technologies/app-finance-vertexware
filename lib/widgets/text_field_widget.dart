import 'package:novo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final bool border;
  final TextInputType? textInputType;
  final int? maxLines;
  final Color? fillColor; // Novo parâmetro

  const TextFieldWidget({
    Key? key,
    required this.icon,
    required this.label,
    this.isSecret = false,
    this.inputFormatters,
    this.initialValue,
    this.readOnly = false,
    this.validator,
    this.controller,
    this.border = true,
    this.textInputType,
    this.onSaved,
    this.onTap,
    this.maxLines = 1,
    this.fillColor, // Adicione aqui
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: widget.controller,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onChanged: (value) {},
        onTap: widget.onTap,
        keyboardType: widget.textInputType,
        maxLines: widget.maxLines,
        style: const TextStyle(color: Colors.white), // Texto digitado em branco
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: AppColors.primaryDark),
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.primaryDark),
                )
              : null,
          labelText: widget.label,
          labelStyle: const TextStyle(color: AppColors.primaryDark),
          isDense: true,
          filled: true, // Habilita o preenchimento de fundo
          fillColor: widget.fillColor ?? Colors.transparent, // Cor do fundo
          border: widget.border
              ? OutlineInputBorder(borderRadius: BorderRadius.circular(18.0))
              : null,
          focusedBorder: widget.border
              ? OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(18.0),
                )
              : null,
        ),
      ),
    );
  }
}
