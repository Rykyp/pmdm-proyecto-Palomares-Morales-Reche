import 'package:flutter/material.dart';
import '../data/productos_ejemplo.dart';
import '../models/producto.dart';
import '../widgets/producto_title.dart';
import 'detalle_screen.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  late List<Producto> _productos;

  @override
  void initState() {
    super.initState();
    _productos = List.from(productosEjemplo);
  }

  void _confirmarBorrado(Producto producto) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: Text('¿Seguro que deseas eliminar "${producto.nombre}" del catálogo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                _productos.remove(producto);
              });
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${producto.nombre} eliminado')),
              );
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ferretería Europa - Catálogo'),
      ),
      body: _productos.isEmpty
          ? const Center(child: Text('No hay productos en el catálogo.'))
          : ListView.builder(
              itemCount: _productos.length,
              itemBuilder: (context, index) {
                final producto = _productos[index];
                return ProductoTile(
                  producto: producto,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalleScreen(producto: producto),
                      ),
                    );
                  },
                  onLongPress: () => _confirmarBorrado(producto),
                );
              },
            ),
    );
  }
}