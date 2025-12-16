# CustomProgress

Una barra de progreso personalizable con opciones de animación y porcentaje.

## Overview

`CustomProgressView` es un componente de barra de progreso que proporciona una visualización animada del progreso. Permite personalizar colores, radio de esquinas y mostrar opcionalmente el porcentaje.

## Usos

Utiliza `CustomProgressView` para:
- Mostrar progreso de descarga o carga
- Mostrar completitud de un formulario
- Indicar progreso de un proceso de varios pasos

## Ejemplo de Uso

```swift
import Gentera_UI

// Crear una barra de progreso
let progressView = CustomProgressView()
progressView.showsPercentage = true
view.addSubview(progressView)

// Animar el progreso
progressView.setProgress(0.5, animated: true)

// Constraints
NSLayoutConstraint.activate([
    progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    progressView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
])
```

## Inicializadores

### init(frame:)

```swift
public override init(frame: CGRect)
```

Crea una nueva barra de progreso con el frame especificado.

### init(coder:)

```swift
required init?(coder: NSCoder)
```

Crea una barra de progreso desde un archivo de interfaz (Storyboard/XIB).

## API Pública

### Propiedades

| Propiedad | Tipo | Default | Descripción |
|-----------|------|---------|-------------|
| `progress` | `CGFloat` | `0.0` | Valor de progreso entre 0.0 y 1.0 |
| `trackTintColor` | `UIColor` | Gris claro (0.9) | Color de la pista (fondo) |
| `progressTintColor` | `UIColor` | Negro | Color de la barra de progreso |
| `cornerRadius` | `CGFloat` | `8` | Radio de esquinas en puntos |
| `showsPercentage` | `Bool` | `false` | Muestra el porcentaje sobre la barra |
| `animationDuration` | `TimeInterval` | `0.25` | Duración de la animación en segundos |

### Métodos

#### setProgress(_:animated:)

```swift
public func setProgress(_ value: CGFloat, animated: Bool)
```

Actualiza el valor de progreso con animación opcional.

**Parámetros:**
- `value`: Valor entre 0.0 y 1.0
- `animated`: Si es `true`, anima el cambio

## Personalización

### Cambiar colores

```swift
let progress = CustomProgressView()
progress.trackTintColor = UIColor(white: 0.95, alpha: 1)
progress.progressTintColor = .blue
```

### Cambiar radio de esquinas

```swift
progress.cornerRadius = 12
```

### Mostrar porcentaje

```swift
progress.showsPercentage = true
```

### Cambiar velocidad de animación

```swift
progress.animationDuration = 0.5  // 500ms
```

## Comportamiento

- **Rango de valores**: El progreso debe estar entre 0.0 y 1.0
- **Valores fuera de rango**: Se comportan correctamente (valores menores a 0 se tratan como 0)
- **Accesibilidad**: Incluye etiquetas para VoiceOver que se actualizan con el progreso
- **Layout**: Ajusta el ancho automáticamente según el progreso

## Notas Importantes

- El componente usa `translatesAutoresizingMaskIntoConstraints = false`, requiere constraints
- La altura se ajusta automáticamente según `cornerRadius`
- Compatible con iOS 12+
- El porcentaje se calcula como `progress * 100` redondeado a entero
