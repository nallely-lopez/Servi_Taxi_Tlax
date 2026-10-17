# Inventario de pantallas y widgets reutilizables

## Pantallas del recorrido

| Ruta | Clase | Responsable |
|---|---|---|
| `lib/features/autenticacion/screens/login_screen.dart` | `LoginScreen` | Nallely |
| `lib/features/servicios/screens/servicios_screen.dart` | `ServiciosScreen` | Nallely |
| `lib/features/servicios/screens/detalle_servicio_screen.dart` | `DetalleServicioScreen` | Abelardo |
| `lib/features/viajes/screens/seleccion_recorrido_screen.dart` | `SeleccionRecorridoScreen` | Abelardo |
| `lib/features/viajes/screens/cotizacion_screen.dart` | `CotizacionScreen` | Abelardo |
| `lib/features/viajes/screens/confirmacion_screen.dart` | `ConfirmacionScreen` | Nallely |

## Widgets propios parametrizados

### Componentes de Nallely

1. **CampoAcceso** (`lib/features/autenticacion/widgets/campo_acceso_widget.dart`)
   - Parámetros: `etiqueta` (`String`, requerido), `controlador` (`TextEditingController`, requerido), `icono` (`IconData`, requerido), `ocultarTexto` (`bool`, opcional; predeterminado `false`).
   - Funcionalidad: campo de texto para ingresar credenciales, con etiqueta, ícono y opción para ocultar el texto.
2. **BotonPrincipal** (`lib/shared/widgets/boton_principal_widget.dart`)
   - Parámetros: `texto` (`String`, requerido), `onPressed` (`VoidCallback?`, requerido), `estaCargando` (`bool`, opcional; predeterminado `false`).
   - Funcionalidad: botón de acción principal que muestra un indicador de carga y se deshabilita mientras carga.
3. **EstadoCargaDatos** (`lib/shared/widgets/estado_carga_datos_widget.dart`)
   - Parámetros: `mensajeError` (`String?`, opcional; predeterminado `null`).
   - Funcionalidad: presenta un indicador de carga o, si se proporciona, un mensaje de error.
4. **TarjetaServicio** (`lib/features/servicios/widgets/tarjeta_servicios_widget.dart`)
   - Parámetros: `servicio` (`ServicioTransporte`, requerido), `onTap` (`VoidCallback`, requerido).
   - Funcionalidad: muestra los datos principales de un servicio de transporte y permite seleccionarlo.
5. **ComprobanteViaje** (`lib/features/viajes/widgets/comprobante_viaje.dart`)
   - Parámetros: `viaje` (`Viaje`, requerido).
   - Funcionalidad: confirma el viaje académico simulado y presenta el servicio, el recorrido, la distancia y el costo estimado en `ConfirmacionScreen`.

### Componentes de Abelardo

1. **CabeceraServicio** (`lib/features/servicios/widgets/cabecera_servicio.dart`)
   - Parámetros: `servicio` (`ServicioTransporte`, requerido).
   - Funcionalidad: muestra la imagen del servicio con estados de carga y error en `DetalleServicioScreen`.
2. **FichaServicio** (`lib/features/servicios/widgets/ficha_servicio.dart`)
   - Parámetros: `servicio` (`ServicioTransporte`, requerido).
   - Funcionalidad: presenta la capacidad, las tarifas y las características del servicio en `DetalleServicioScreen`.
3. **SelectorLugar** (`lib/features/viajes/widgets/selector_lugar.dart`)
   - Parámetros: `etiqueta` (`String`, requerido), `valorSeleccionado` (`Lugar?`, requerido), `lugares` (`List<Lugar>`, requerido), `onChanged` (`ValueChanged<Lugar?>`, requerido).
   - Funcionalidad: permite seleccionar un lugar de origen o destino en `SeleccionRecorridoScreen`.
4. **ResumenRecorrido** (`lib/features/viajes/widgets/resumen_recorrido.dart`)
   - Parámetros: `viaje` (`Viaje`, requerido).
   - Funcionalidad: resume el servicio, el origen, el destino y la distancia en `CotizacionScreen`.
5. **DesgloseCosto** (`lib/features/viajes/widgets/desglose_costo.dart`)
   - Parámetros: `viaje` (`Viaje`, requerido).
   - Funcionalidad: presenta la tarifa base, el cargo por distancia y el costo estimado total en `CotizacionScreen`.
