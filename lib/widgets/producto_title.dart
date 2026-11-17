import 'package:flutter/material.dart';
import '../models/producto.dart';

class ProductoTile extends StatelessWidget {
  final Producto producto;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const ProductoTile({
    super.key,
    required this.producto,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(producto.nombre[0].toUpperCase()),
        ),
        title: Text(
          producto.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(producto.categoria),
        trailing: Text(
          '${producto.precio.toStringAsFixed(2)} €',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}