<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Dynamic List View Alerts

`dynamic_list_view_alerts` es un paquete de Flutter que permite mostrar una lista dinámica de alertas agrupadas por fecha. Cada alerta incluye información como título, mensaje, fecha de creación y acciones ocultas que se pueden mostrar al interactuar con la alerta.

## Características

- Agrupación automática de alertas por fecha.
- Interfaz interactiva con soporte para acciones ocultas al pasar el cursor sobre una alerta.
- Personalización de estilos utilizando el tema de Flutter.
- Soporte para mostrar alertas leídas y no leídas.

## Instalación

Agrega el paquete a tu archivo `pubspec.yaml`:

```yaml
dependencies:
  dynamic_list_view_alerts:
    git:
      url: https://github.com/tu-repositorio/dynamic_list_view_alerts.git
```

Luego, ejecuta:
`flutter pub get`

## Uso
Ejemplo básico de cómo usar el paquete:

```dart
import 'package:flutter/material.dart';
import 'package:dynamic_list_view_alerts/dynamic_list_view_alerts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Dynamic List View Alerts')),
        body: DynamicListViewAlerts(
          alerts: [
            DynamicAlert(
              id: '1',
              title: 'Alerta 1',
              message: 'Este es un mensaje de prueba.',
              createdAt: DateTime.now(),
              isRead: false,
              hidenActions: [TextButton(onPressed: () {}, child: const Text('Acción'))],
            ),
            DynamicAlert(
              id: '2',
              title: 'Alerta 2',
              message: 'Otro mensaje de prueba.',
              createdAt: DateTime.now().subtract(const Duration(days: 1)),
              isRead: true,
            ),
          ],
        ),
      ),
    );
  }
}
```

## Personalización
Puedes personalizar los estilos de las alertas utilizando el tema de tu aplicación. Por ejemplo, puedes cambiar los colores, fuentes y tamaños de texto a través de ThemeData.

