import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubmitButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool processAction;
  final icon;

  const SubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.processAction = false,
    this.icon,
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: widget.processAction
          ? const SizedBox(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) Icon(widget.icon, size: 20),
          if (widget.icon != null) const SizedBox(width: 8),
          Text(widget.text),
        ],
      ),
    );
  }
}
