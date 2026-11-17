# ServiTlax

Aplicación móvil para cotizar y solicitar transporte local en Tlaxiaco, Oaxaca.
Proyecto de la asignatura **Desarrollo de Aplicaciones Móviles** – TecNM Campus Tlaxiaco.

## Descripción

**ServiTlax** es una aplicación móvil para Android, hecha con Flutter, que permite a habitantes y visitantes de Tlaxiaco cotizar y solicitar transporte local de forma rápida y con un precio claro antes de viajar. El pasajero se registra, inicia sesión, revisa el catálogo de servicios, elige el origen y el destino, recibe una cotización y confirma su viaje; después puede consultarlo en su historial. Al registrarse, el usuario también puede elegir ser **conductor**: en ese caso ve las solicitudes de viaje, puede aceptarlas, cancelarlas o finalizarlas. Los datos se guardan en una base de datos MySQL y la app los obtiene a través de una API REST propia hecha con Dart Frog.

## Funcionalidades

### Pasajero
- Registro e inicio de sesión
- Catálogo y detalle de servicios de transporte
- Selección de recorrido (origen y destino)
- Cotización del viaje y confirmación
- Historial de viajes (Mis viajes)
- Perfil

### Conductor
- Ver solicitudes de viaje pendientes
- Aceptar un viaje
- Cancelar un viaje aceptado (regresa a pendiente para otro conductor)
- Finalizar un viaje (queda como completado)

### Estados de un viaje

```
pendiente  ──(conductor acepta)──▶  aceptado  ──(conductor finaliza)──▶  completado
    ▲                                   │
    └──────(conductor cancela)──────────┘
```

## Estado del proyecto

| Parte | Estado |
| --- | --- |
| Login, catálogo, detalle, recorrido, cotización y confirmación (con datos JSON locales) | Implementado (Unidad 3) |
| Diseño en Figma | En proceso |
| Base de datos MySQL | Pendiente |
| API REST con Dart Frog | Pendiente |
| Registro, Splash, Mis viajes, Perfil y pantallas del conductor | Pendiente |

## Tecnologías

| Parte | Tecnología | Motivo |
| --- | --- | --- |
| App móvil | Flutter (Dart) | Un solo código para todas las pantallas; el equipo ya lo usa |
| API REST | Dart Frog | Usa Dart, el mismo lenguaje de Flutter; es gratuita |
| Base de datos | MySQL + MySQL Workbench | Base de datos relacional gratuita; Workbench permite diseñarla y consultarla de forma visual |
| Diseño | Figma | Guía de estilo, pantallas y prototipo navegable |
| Control de versiones | Git y GitHub | Trabajo en ramas y pull requests revisados |

## Estructura de carpetas

```
lib/
├── main.dart
├── features/
│   ├── autenticacion/   # login (models, screens, utils, widgets)
│   ├── servicios/       # catálogo y detalle de servicios
│   └── viajes/          # recorrido, cotización y confirmación
└── shared/
    └── widgets/         # widgets reutilizables
assets/data/             # datos JSON locales (se reemplazarán por la API)
docs/                    # documentación y evidencias
```

## Cómo ejecutar la app

Requisitos: Flutter SDK, Android SDK y un emulador (Pixel 4 XL) o un teléfono Android.

```bash
git clone https://github.com/nallely-lopez/Servi_Taxi_Tlax.git
cd Servi_Taxi_Tlax
flutter pub get
flutter run
```

Usuarios de prueba (datos locales): `nallely` / `demo123` y `abelardo` / `demo456`.

> Las instrucciones para ejecutar la API y la base de datos se agregarán cuando estén listas.

## Forma de trabajo

- Cada funcionalidad se desarrolla en su propia rama: `feature/…`, `fix/…` o `docs/…`.
- Commits con prefijo: `feat:`, `fix:`, `docs:`, `style:`.
- La rama `main` está protegida: los cambios entran solo por pull request aprobado por el otro integrante.

## Equipo

| Integrante | Responsabilidad principal |
| --- | --- |
| Lizeth Nallely López García | Usuarios y conductor: Splash, Login, Registro, Perfil, Solicitudes y Detalle de solicitud; guía de estilo; base de la API |
| Abelardo Ortiz Ortiz | Servicios y viajes: Catálogo, Detalle, Recorrido, Cotización, Confirmación, Mis viajes y Viajes aceptados; diagrama de la base de datos; estructura base de la app |
