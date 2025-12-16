# ProgressHUDView

Un HUD (Heads-Up Display) para mostrar indicadores de carga con animaciones Lottie.

## Overview

`ProgressHUDView` es un componente que cubre la pantalla con un efecto blur y muestra una animación Lottie. Es útil para indicar que una operación está en progreso y bloquear la interacción del usuario.

## Usos

Utiliza `ProgressHUDView` para:
- Mostrar indicadores de carga durante operaciones asincrónicas
- Bloquear la interacción mientras se procesa
- Mostrar feedback visual al usuario

## Ejemplo de Uso

```swift
import Gentera_UI

// Crear y mostrar HUD
let hud = ProgressHUDView(animationName: "Loader")
hud.present(on: view, animated: true)

// Simular operación
DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
    hud.dismiss(animated: true)
}

// Mostrar HUD con personalización
let customHUD = ProgressHUDView(
    animationName: "Loader",
    loaderSize: 120,
    blurStyle: .light,
    dimAlpha: 0.3
)
customHUD.present(on: view)
```

## Inicializadores

### init(animationName:)

```swift
public convenience init(animationName: String)
```

Crea un HUD con los valores por defecto.

**Parámetros:**
- `animationName`: Nombre del archivo de animación Lottie (sin extensión)

### init(animationName:loaderSize:blurStyle:dimAlpha:)

```swift
public init(animationName: String,
            loaderSize: CGFloat = 100,
            blurStyle: UIBlurEffect.Style = .dark,
            dimAlpha: CGFloat = 0.2)
```

Crea un HUD completamente personalizable.

**Parámetros:**
- `animationName`: Nombre del archivo de animación Lottie
- `loaderSize`: Tamaño del loader en puntos (default: 100)
- `blurStyle`: Estilo del blur (`.dark`, `.light`, `.extraLight`, default: `.dark`)
- `dimAlpha`: Transparencia de la capa de oscuridad (0.0-1.0, default: 0.2)

## API Pública

### Métodos

#### present(on:animated:)

```swift
public func present(on view: UIView, animated: Bool = true)
```

Muestra el HUD cubriendo completamente la vista especificada.

**Parámetros:**
- `view`: Vista sobre la que mostrar el HUD
- `animated`: Si es `true`, anima la aparición con fade in

#### dismiss(animated:completion:)

```swift
public func dismiss(animated: Bool = true, completion: (() -> Void)? = nil)
```

Oculta el HUD.

**Parámetros:**
- `animated`: Si es `true`, anima la desaparición con fade out
- `completion`: Closure ejecutado cuando finaliza la animación

## Animaciones Disponibles

El componente usa animaciones Lottie. Puedes usar cualquier archivo `.json` de Lottie disponible en tu proyecto:

- `"Loader"`: Animación de carga incluida en Gentera-UI

## Características

- **Efecto Blur**: Fondo borroso con opción de oscuridad personalizable
- **Animación**: Usa animaciones Lottie con loop continuo
- **Bloqueo de Interacción**: Impide que el usuario interactúe con la UI debajo
- **Seguridad de Thread**: Detecta si se llama desde el thread principal
- **Accesibilidad**: Incluye etiqueta para VoiceOver

## Comportamiento

- **Thread Safety**: Detecta si se llama desde un thread secundario y automáticamente cambia al thread principal
- **Animación**: El loader tiene `loopMode = .loop` por defecto
- **Velocidad**: La velocidad de animación es 1.0 (velocidad normal)
- **Content Mode**: Las animaciones usan `.scaleAspectFit`

## Ejemplo Avanzado

```swift
// HUD con operación asincrónica
let hud = ProgressHUDView(animationName: "Loader", loaderSize: 100)
hud.present(on: self.view, animated: true)

// Realizar operación
DispatchQueue.global().async {
    // Operación larga
    sleep(3)
    
    DispatchQueue.main.async {
        hud.dismiss(animated: true) {
            print("HUD desaparecido")
            self.showSuccessMessage()
        }
    }
}

// HUD con estilo light
let lightHUD = ProgressHUDView(
    animationName: "Loader",
    loaderSize: 80,
    blurStyle: .light,
    dimAlpha: 0.1
)
lightHUD.present(on: self.view)
```

## Personalización

### Cambiar tamaño del loader

```swift
let hud = ProgressHUDView(animationName: "Loader", loaderSize: 150)
```

### Cambiar estilo de blur

```swift
let hud = ProgressHUDView(
    animationName: "Loader",
    blurStyle: .light
)
```

### Cambiar intensidad de oscuridad

```swift
let hud = ProgressHUDView(
    animationName: "Loader",
    dimAlpha: 0.5  // Más oscuro
)
```

## Propiedades Accesibles

| Propiedad | Tipo | Default | Descripción |
|-----------|------|---------|-------------|
| `loaderSize` | `CGFloat` | `100` | Tamaño del loader (solo lectura después de init) |
| `blurView` | `UIVisualEffectView` | - | Vista de blur (solo lectura) |
| `loader` | `LottieAnimationView` | - | Vista de animación Lottie (solo lectura) |

## Notas Importantes

- El componente usa `translatesAutoresizingMaskIntoConstraints = false`
- Bloquea la interacción con vistas debajo mediante `isUserInteractionEnabled = true`
- Compatible con iOS 12+
- Requiere la dependencia `lottie-ios`
- Thread-safe: puede llamarse desde cualquier thread
