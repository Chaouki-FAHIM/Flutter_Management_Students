import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BuildAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.purple,
      title: Center(
          child: Text(
              title,
              style: const TextStyle(color: Colors.white)
          )
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);  // Fournit la taille préférée pour AppBar.
}
