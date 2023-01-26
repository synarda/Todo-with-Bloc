// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_task/Utils/const.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    this.icon,
    this.controller,
    required this.limit,
    required this.obscure,
    this.type,
    this.focus = false,
  }) : super(key: key);

  final String label;
  final Widget? icon;
  final TextEditingController? controller;
  final int limit;
  final bool obscure;
  final TextInputType? type;
  final bool focus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        autofocus: focus,
        keyboardType: type,
        obscureText: obscure,
        style: TextStyle(color: Colorss().primary, fontSize: 12),
        inputFormatters: [
          LengthLimitingTextInputFormatter(limit),
        ],
        decoration: InputDecoration(
          prefixIcon: icon,
          labelText: label,
          labelStyle: TextStyle(color: Colorss().primary),
          filled: false,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colorss().primary),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colorss().primary),
          ),
        ),
        cursorColor: Colorss().primary,
        onChanged: (value) {},
        controller: controller,
      ),
    );
  }
}
