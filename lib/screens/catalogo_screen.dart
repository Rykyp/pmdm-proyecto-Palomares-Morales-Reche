import 'package:flutter/material.dart';
import '../data/productos_ejemplo.dart';
import '../models/producto.dart';
import '../widgets/producto_tile.dart';

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
                    // Pendiente: Navegación a Detalle (Pablo)
                  },
                  onLongPress: () {
                    // Pendiente: Alerta de borrado (Pablo)
                  },
                );
              },
            ),
    );
  }
}