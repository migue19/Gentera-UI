# Animation - Loader

Una animación Lottie para indicadores de carga.

## Overview

`Loader.json` es una animación Lottie de carga que se utiliza principalmente con `ProgressHUDView` para proporcionar feedback visual mientras se ejecutan operaciones asincrónicas.

## Ubicación del Recurso

```
Gentera-UI/
└── Animation/
    └── Loader.json
```

## Usos

La animación Loader se utiliza para:
- Mostrar indicadores de carga en HUDs
- Feedback visual durante operaciones asincrónicas
- Pantallas de carga
- Transiciones entre vistas

## Ejemplo de Uso con ProgressHUDView

```swift
import Gentera_UI

// Usar animación Loader con ProgressHUDView
let hud = ProgressHUDView(animationName: "Loader")
hud.present(on: view, animated: true)

// Simular operación
DispatchQueue.global().async {
    // Operación larga
    sleep(2)
    
    DispatchQueue.main.async {
        hud.dismiss(animated: true)
    }
}
```

## Configuración de Animación

### Tamaño del Loader

```swift
// Loader pequeño
let smallHUD = ProgressHUDView(
    animationName: "Loader",
    loaderSize: 80
)

// Loader grande
let largeHUD = ProgressHUDView(
    animationName: "Loader",
    loaderSize: 150
)
```

### Velocidad de Animación

```swift
let hud = ProgressHUDView(animationName: "Loader")
hud.present(on: view)

// Acceder a la animación para personalizar
hud.loader.animationSpeed = 1.5  // Más rápida
```

### Modo de Loop

```swift
let hud = ProgressHUDView(animationName: "Loader")
// Por defecto usa .loop para repetición continua
hud.loader.loopMode = .loop
```

### Color de la Animación

```swift
let hud = ProgressHUDView(animationName: "Loader")
// Personalizar el color de la animación si es compatible
hud.loader.colorValueProvider(for: .init(keypath: "**.Color"))?.setColor(.systemBlue)
```

## Características de la Animación

- **Formato**: JSON (Lottie)
- **Loop**: Configurado para repetición continua
- **Contenido Mode**: Scale Aspect Fit
- **Velocidad**: 1.0 (velocidad normal)
- **Compatible**: iOS 12+ mediante Lottie-iOS

## Especificaciones Técnicas

| Propiedad | Valor |
|-----------|-------|
| Extensión | `.json` |
| Librería | Lottie-iOS |
| Modo Loop | Continuo |
| Escala | Adaptable |

## Integración con Componentes

### Con ProgressHUDView

```swift
// Uso más común
let hud = ProgressHUDView(animationName: "Loader")
hud.present(on: self.view)
```

### Uso Directo con LottieAnimationView

```swift
import Lottie

// Si necesitas usar la animación directamente
let animationView = LottieAnimationView(name: "Loader")
animationView.loopMode = .loop
animationView.play()
view.addSubview(animationView)
```

## Personalizaciones Avanzadas

### Cambiar tamaño dinámicamente

```swift
let hud = ProgressHUDView(animationName: "Loader", loaderSize: 100)
hud.present(on: view)

// Redimensionar después (aunque no es lo recomendado)
hud.loader.frame.size = CGSize(width: 120, height: 120)
```

### Control manual de la animación

```swift
let hud = ProgressHUDView(animationName: "Loader")
hud.present(on: view)

// Pausar
hud.loader.pause()

// Reanudar
hud.loader.play()

// Detener
hud.loader.stop()
```

## Compatibilidad

- **iOS**: 12+
- **Dependencia**: lottie-ios
- **Formatos**: JSON (archivo Lottie)

## Ejemplos de Uso Completos

### Carga de datos

```swift
func loadUserData() {
    let hud = ProgressHUDView(animationName: "Loader")
    hud.present(on: self.view, animated: true)
    
    APIClient.shared.fetchUser { [weak self] result in
        DispatchQueue.main.async {
            hud.dismiss(animated: true) {
                switch result {
                case .success(let user):
                    self?.displayUser(user)
                case .failure(let error):
                    self?.showError(error.localizedDescription)
                }
            }
        }
    }
}
```

### Validación con timeout

```swift
func validateWithTimeout() {
    let hud = ProgressHUDView(animationName: "Loader")
    hud.present(on: self.view)
    
    // Timeout de 30 segundos
    let deadline = Date(timeIntervalSinceNow: 30)
    
    APIClient.shared.validate(timeout: deadline) { result in
        DispatchQueue.main.async {
            hud.dismiss(animated: true)
            // Manejar resultado
        }
    }
}
```

## Notas Importantes

- El archivo `Loader.json` debe estar incluido en el bundle del proyecto
- Requiere la dependencia `lottie-ios` instalada vía CocoaPods
- La animación se ejecuta en el thread principal
- Compatible con rotación de pantalla mientras está visible
