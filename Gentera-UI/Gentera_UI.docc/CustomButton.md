# CustomButton

Un botón personalizable con soporte para múltiples estilos visuales.

## Overview

`CustomButton` es un componente UIButton mejorado que proporciona tres estilos visuales predefinidos (primario, secundario y enlace). El botón maneja automáticamente estados de habilitación/deshabilitación con cambios visuales suaves.

## Usos

Utiliza `CustomButton` para:
- Acciones principales del formulario (confirmar, enviar, etc.)
- Acciones secundarias con bordes
- Enlaces interactivos sin relleno de fondo

## Estilos Disponibles

- **primary**: Botón sólido negro con texto blanco (para acciones principales)
  ![Primary Button](CustomButton-Primary.svg)
  
- **secondary**: Botón con borde gris y texto negro
  ![Secondary Button](CustomButton-Secondary.svg)
  
- **link**: Botón transparente solo con texto (para enlaces)
  ![Link Button](CustomButton-Link.svg)

## Ejemplo de Uso

```swift
import Gentera_UI

// Crear un botón primario
let button = CustomButton(title: "Aceptar", style: .primary)
button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
view.addSubview(button)

// Ancho automático con constraints
NSLayoutConstraint.activate([
    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    button.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
])
```

## Inicializadores

### init(title:style:)

```swift
public init(title: String, style: CustomButtonStyle)
```

Crea un nuevo botón con el título y estilo especificados.

**Parámetros:**
- `title`: El texto del botón
- `style`: El estilo visual (`.primary`, `.secondary`, `.link`)

## API Pública

### Propiedades

| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| `style` | `CustomButtonStyle` | El estilo visual del botón (solo lectura) |

### Propiedades Heredadas de UIButton

- `isEnabled`: Habilita/deshabilita el botón (los cambios aplican automáticamente el estilo)
- `titleLabel`: Acceso a la etiqueta del título para personalización avanzada
- `backgroundColor`: Color de fondo (reemplazado por los estilos)

## Personalización

### Cambiar el título

```swift
button.setTitle("Nuevo Texto", for: .normal)
```

### Cambiar estado habilitado

```swift
button.isEnabled = false  // Se aplica automáticamente el estilo deshabilitado
```

### Agregar acciones

```swift
button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
```

## Comportamiento

- **Altura fija**: El botón tiene una altura de 50 puntos
- **Radio de esquinas**: 8 puntos (bordes redondeados)
- **Animación**: Los cambios de estado se animan suavemente (0.18 segundos)
- **Accesibilidad**: Compatible con VoiceOver

## Estados

El botón adapta automáticamente su apariencia según su estado:

| Estado | Efecto |
|--------|--------|
| Habilitado | Colores opacos, interactivo |
| Deshabilitado | Colores atenuados, semitransparente, no interactivo |

## Notas Importantes

- El componente usa `translatesAutoresizingMaskIntoConstraints = false`, por lo que debe agregarse al menos una restricción de alto o ancho
- Los cambios en `isEnabled` aplican automáticamente los cambios de estilo
- Compatible con iOS 12+
