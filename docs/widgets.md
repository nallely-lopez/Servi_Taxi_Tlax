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
   - Parámetros: `servicio` (ServicioTransporte).
   - Uso: Pantalla de detalle (`DetalleServicioScreen`).
2. **FichaServicio** (`lib/features/servicios/widgets/ficha_servicio.dart`):
   - Parámetros: `servicio` (ServicioTransporte).
   - Uso: Pantalla de detalle (`DetalleServicioScreen`).
3. **SelectorLugar** *(Pendiente para Paso 20)*.
4. **ResumenRecorrido** *(Pendiente para Paso 21)*.
5. **DesgloseCosto** *(Pendiente para Paso 21)*.