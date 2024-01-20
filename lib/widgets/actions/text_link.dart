import 'package:flutter/material.dart';

class TextLink extends StatefulWidget {

  final String prefix;
  final String suffix;
  final VoidCallback navigator;
  const TextLink({super.key, required this.prefix, required this.suffix, required this.navigator});

  @override
  State<TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.prefix),
        InkWell(
          onTap: widget.navigator,
          child: Text(widget.suffix, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
