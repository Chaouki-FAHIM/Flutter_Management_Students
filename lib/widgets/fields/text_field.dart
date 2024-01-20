import 'package:flutter/material.dart';

class BuildTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  late bool obscured;

  BuildTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.obscured=false
  });

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscured,
      decoration: InputDecoration(
        hintText: widget.hintText,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        prefixIcon: widget.prefixIcon != null ?
        Icon(widget.prefixIcon, color: Colors.purple) : null,
        suffixIcon: widget.hintText == 'Password' ?
        IconButton(
          icon: Icon(
            widget.obscured ? Icons.visibility : Icons.visibility_off,
            color: Colors.purple,
          ),
          onPressed: () {
            setState(() {
              widget.obscured = !widget.obscured;
            });
          },
        ) : null,
      ),
    );
  }
}
