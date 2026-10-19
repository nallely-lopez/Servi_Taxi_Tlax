import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:servi_taxi_tlax/main.dart';
import 'package:servi_taxi_tlax/features/viajes/models/lugar.dart';
import 'package:servi_taxi_tlax/features/viajes/widgets/selector_lugar.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    rootBundle.clear();
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    final datos = <String, Object>{
      'assets/data/usuarios.json': [
        {'id': 1, 'nombre': 'Prueba', 'usuario': 'demo', 'claveAcceso': 'demo'},
      ],
      'assets/data/servicios.json': [
        {
          'id': 1,
          'nombre': 'Taxi de prueba',
          'descripcion': 'Servicio de prueba',
          'imagen': 'https://example.invalid/taxi.png',
          'capacidad': 4,
          'tarifaBase': 20,
          'precioKm': 5,
          'caracteristicas': <String>[],
        },
      ],
      'assets/data/lugares.json': [
        {'id': 1, 'nombre': 'Origen de prueba'},
        {'id': 2, 'nombre': 'Destino de prueba'},
      ],
      'assets/data/rutas.json': [
        {'id': 1, 'origenId': 1, 'destinoId': 2, 'distanciaKm': 10},
      ],
    };
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
          final key = utf8.decode(
            message!.buffer.asUint8List(
              message.offsetInBytes,
              message.lengthInBytes,
            ),
          );
          final value = datos[key];
          if (value == null) return null;
          return ByteData.sublistView(
            Uint8List.fromList(utf8.encode(jsonEncode(value))),
          );
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', null);
  });

  Future<void> pulsar(WidgetTester tester, String texto) async {
    final boton = find.text(texto);
    await tester.ensureVisible(boton);
    await tester.tap(boton);
    await tester.pumpAndSettle();
  }

  Future<void> acceder(WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byType(TextField).at(0), 'demo');
    await tester.enterText(find.byType(TextField).at(1), 'demo');
    await pulsar(tester, 'Ingresar');
  }

  Future<void> abrirRecorrido(WidgetTester tester) async {
    await acceder(tester);
    await pulsar(tester, 'Taxi de prueba');
    await pulsar(tester, 'Seleccionar Recorrido');
  }

  Future<void> seleccionar(WidgetTester tester, int campo, int lugar) async {
    final selector = tester.widget<SelectorLugar>(
      find.byType(SelectorLugar).at(campo),
    );
    selector.onChanged(selector.lugares[lugar]);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    await tester.pumpAndSettle();
    final dropdown = tester.widget<DropdownButtonFormField<Lugar>>(
      find.byType(DropdownButtonFormField<Lugar>).at(campo),
    );
    expect(dropdown.initialValue?.id, selector.lugares[lugar].id);
  }

  testWidgets('Verifica elementos iniciales de LoginScreen', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Iniciar Sesión'), findsOneWidget);
    expect(find.text('Ingresar'), findsOneWidget);
  });

  testWidgets('Valida selecciones vacías, parciales, iguales y sin ruta', (
    tester,
  ) async {
    await abrirRecorrido(tester);
    await pulsar(tester, 'Cotizar Viaje');
    expect(
      find.text('Selecciona el origen y el destino antes de cotizar.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
    await seleccionar(tester, 0, 1);
    await pulsar(tester, 'Cotizar Viaje');
    expect(
      find.text('Selecciona el origen y el destino antes de cotizar.'),
      findsOneWidget,
    );
    await seleccionar(tester, 1, 1);
    await pulsar(tester, 'Cotizar Viaje');
    expect(
      find.text('El origen y el destino no pueden ser el mismo lugar.'),
      findsOneWidget,
    );
    await seleccionar(tester, 1, 0);
    await pulsar(tester, 'Cotizar Viaje');
    expect(
      find.text(
        'Ruta no disponible: no hay trayecto registrado entre los puntos seleccionados.',
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Finalizar vuelve al catálogo y cerrar sesión limpia los campos',
    (tester) async {
      await abrirRecorrido(tester);
      await seleccionar(tester, 0, 0);
      await seleccionar(tester, 1, 1);
      await pulsar(tester, 'Cotizar Viaje');
      expect(find.text('Cotización del Viaje'), findsOneWidget);
      await pulsar(tester, 'Confirmar Viaje');
      await pulsar(tester, 'Finalizar y Regresar al Catálogo');
      expect(find.text('Servicios de Transporte'), findsOneWidget);
      expect(find.byType(SelectorLugar), findsNothing);
      await tester.tap(find.byTooltip('Cerrar sesión'));
      await tester.pumpAndSettle();
      expect(find.text('Iniciar Sesión'), findsOneWidget);
      for (final campo in tester.widgetList<TextField>(
        find.byType(TextField),
      )) {
        expect(campo.controller!.text, isEmpty);
      }
      expect(tester.takeException(), isNull);
    },
  );
}
