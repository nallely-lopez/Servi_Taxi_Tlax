import 'package:flutter_test/flutter_test.dart';
import 'package:servi_taxi_tlax/main.dart';

void main() {
  testWidgets('Verifica elementos iniciales de LoginScreen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Iniciar Sesión'), findsOneWidget);
    expect(find.text('Ingresar'), findsOneWidget);
  });
}
