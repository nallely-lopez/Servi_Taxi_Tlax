# Registro de Componentes Reutilizables

## Componentes de Nallely
1. **CampoAcceso** (`lib/features/autenticacion/widgets/campo_acceso.dart`):
   - Parámetros: `etiqueta` (String), `controlador` (TextEditingController), `icono` (IconData), `ocultarTexto` (bool).
   - Uso: Pantalla de inicio de sesión (`LoginScreen`).
2. **BotonPrincipal** (`lib/shared/widgets/boton_principal.dart`):
   - Parámetros: `texto` (String), `onPressed` (VoidCallback?), `estaCargando` (bool).
   - Uso: `LoginScreen`, `SeleccionRecorridoScreen`, `CotizacionScreen`, `ConfirmacionScreen`.
3. **EstadoCargaDatos** (`lib/shared/widgets/estado_carga_datos.dart`):
   - Parámetros: `mensajeError` (String?).
   - Uso: `ServiciosScreen` y pantallas que carguen datos asíncronos.
4. **TarjetaServicio** (`lib/features/servicios/widgets/tarjeta_servicio.dart`):
   - Parámetros: `servicio` (ServicioTransporte), `onTap` (VoidCallback).
   - Uso: Catálogo de servicios (`ServiciosScreen`).
5. **ComprobanteViaje** *(Pendiente para Paso 22)*.

## Componentes de Abelardo
1. **CabeceraServicio** (`lib/features/servicios/widgets/cabecera_servicio.dart`):
   - Parámetros: `servicio` (`ServicioTransporte`).
   - Uso: Presenta la imagen de red con estados de carga y error en `DetalleServicioScreen`.
2. **FichaServicio** (`lib/features/servicios/widgets/ficha_servicio.dart`):
   - Parámetros: `servicio` (`ServicioTransporte`).
   - Uso: Muestra capacidad, tarifas y características del servicio en `DetalleServicioScreen`.
3. **SelectorLugar** (`lib/features/viajes/widgets/selector_lugar.dart`):
   - Parámetros: `etiqueta` (`String`), `valorSeleccionado` (`Lugar?`), `lugares` (`List<Lugar>`) y `onChanged` (`ValueChanged<Lugar?>`).
   - Uso: Selecciona origen y destino en `SeleccionRecorridoScreen`.
4. **ResumenRecorrido** (`lib/features/viajes/widgets/resumen_recorrido.dart`):
   - Parámetros: `viaje` (`Viaje`).
   - Uso: Muestra servicio, origen, destino y distancia en `CotizacionScreen`.
5. **DesgloseCosto** (`lib/features/viajes/widgets/desglose_costo.dart`):
   - Parámetros: `viaje` (`Viaje`).
   - Uso: Desglosa tarifa base, cargo por distancia y total estimado en `CotizacionScreen`.