import 'package:flutter/material.dart';
import '../data/productos_ejemplo.dart';
import '../models/producto.dart';
import '../widgets/producto_title.dart';
import 'detalle_screen.dart';
import 'nuevo_producto_screen.dart';

enum OrdenCatalogo {
  nombreAsc,
  precioAsc,
  precioDesc,
}

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  late List<Producto> _productos;
  OrdenCatalogo _ordenActual = OrdenCatalogo.nombreAsc;

  @override
  void initState() {
    super.initState();
    _productos = List.from(productosEjemplo);
    _aplicarOrden();
  }

  void _aplicarOrden() {
    switch (_ordenActual) {
      case OrdenCatalogo.nombreAsc:
        _productos.sort(
          (a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()),
        );
        break;
      case OrdenCatalogo.precioAsc:
        _productos.sort((a, b) => a.precio.compareTo(b.precio));
        break;
      case OrdenCatalogo.precioDesc:
        _productos.sort((a, b) => b.precio.compareTo(a.precio));
        break;
    }
  }

  Future<void> _abrirFormularioNuevo() async {
    final nuevoProducto = await Navigator.push<Producto>(
      context,
      MaterialPageRoute(
        builder: (_) => const NuevoProductoScreen(),
      ),
    );

    if (nuevoProducto != null) {
      setState(() {
        _productos.add(nuevoProducto);
        _aplicarOrden();
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${nuevoProducto.nombre} añadido al catálogo')),
      );
    }
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
        actions: [
          PopupMenuButton<OrdenCatalogo>(
            icon: const Icon(Icons.sort),
            tooltip: 'Ordenar productos',
            initialValue: _ordenActual,
            onSelected: (nuevoOrden) {
              setState(() {
                _ordenActual = nuevoOrden;
                _aplicarOrden();
              });
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: OrdenCatalogo.nombreAsc,
                child: Text('Nombre (A - Z)'),
              ),
              PopupMenuItem(
                value: OrdenCatalogo.precioAsc,
                child: Text('Precio (menor a mayor)'),
              ),
              PopupMenuItem(
                value: OrdenCatalogo.precioDesc,
                child: Text('Precio (mayor a menor)'),
              ),
            ],
          ),
        ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirFormularioNuevo,
        tooltip: 'Añadir producto',
        child: const Icon(Icons.add),
      ),
    );
  }
}