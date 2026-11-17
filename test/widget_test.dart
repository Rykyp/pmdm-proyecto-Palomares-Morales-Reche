import 'package:flutter_test/flutter_test.dart';
import 'package:comercio_app/main.dart';

void main() {
  testWidgets('Carga la pantalla principal del catálogo', (WidgetTester tester) async {
    await tester.pumpWidget(const ComercioApp());
    expect(find.text('Ferretería Europa - Catálogo'), findsOneWidget);
  });
}