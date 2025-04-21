import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AjustesItem extends StatelessWidget {
  final String texto;
  final VoidCallback? onTap;
  const AjustesItem({super.key, required this.texto, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        texto,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: onTap,
    );
  }
}