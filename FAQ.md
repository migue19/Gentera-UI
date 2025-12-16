# FAQ - Preguntas Frecuentes

Respuestas a preguntas comunes sobre Gentera-UI.

## Instalación y Configuración

### ¿Cómo instalo Gentera-UI?

Gentera-UI se distribuye mediante CocoaPods. Agrega la siguiente línea a tu `Podfile`:

```ruby
pod 'Gentera-UI', :git => 'https://github.com/tu-repo/Gentera-UI.git'
```

Luego ejecuta `pod install`.

### ¿Qué versión mínima de iOS soporta Gentera-UI?

Gentera-UI soporta iOS 12.0 y superior.

### ¿Necesito alguna dependencia adicional?

Gentera-UI requiere:
- **lottie-ios** (4.4.0+) - Para animaciones

Esta se instala automáticamente con CocoaPods.

## Uso General

### ¿Todos los componentes usan Auto Layout?

Sí, todos los componentes de Gentera-UI están diseñados para funcionar con Auto Layout. No se requieren Storyboards.

### ¿Debo establecer constraints para todos los componentes?

Sí, todos los componentes requieren constraints de Auto Layout. Usa `NSLayoutConstraint` o `UIView.addConstraints()`.

### ¿Puedo usar Gentera-UI con SwiftUI?

Gentera-UI está basado en UIKit. Para usarlo con SwiftUI, necesitas usar `UIViewRepresentable` o `UIViewControllerRepresentable`.

Ejemplo:
```swift
struct CustomButtonRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> CustomButton {
        return CustomButton(title: "Mi Botón", style: .primary)
    }
    
    func updateUIView(_ uiView: CustomButton, context: Context) {}
}
```

### ¿Cómo personalizo los colores de un componente?

Cada componente expone propiedades para personalizar colores:

```swift
let button = CustomButton(title: "Aceptar", style: .primary)
button.backgroundColor = .customColor

let progress = CustomProgressView()
progress.progressTintColor = .systemBlue
progress.trackTintColor = .lightGray
```

## CustomButton

### ¿Cuáles son los estilos de botón disponibles?

Hay tres estilos disponibles:
- `.primary` - Botón sólido negro con texto blanco
- `.secondary` - Botón con borde gris y texto negro
- `.link` - Botón transparente solo con texto

### ¿Puedo cambiar el tamaño del botón?

El botón tiene una altura fija de 50 puntos. Puedes cambiar el ancho con constraints. Para cambiar la altura:

```swift
button.heightAnchor.constraint(equalToConstant: 60).isActive = true
```

### ¿Cómo agrego una acción al botón?

```swift
button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
```

## CustomTextField

### ¿Cuáles son los tipos de campo disponibles?

- `.normal` - Campo de texto estándar
- `.phone` - Campo de teléfono con máscara (XXX) XXX-XXXX
- `.idCard` - Campo de cédula, solo dígitos
- `.date` - Campo de fecha con formato dd/mm/yyyy

### ¿Cómo manejo el evento de cambio de texto?

```swift
let textField = CustomTextField()
textField.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)

@objc func textChanged(_ sender: UITextField) {
    print("Texto actual: \(sender.text ?? "")")
}
```

### ¿Cómo implemento el botón de cámara para cédula?

```swift
let idField = CustomTextField(type: .idCard, title: "Cédula")
idField.onCameraTap = {
    self.presentCameraViewController()
}
```

### ¿Cómo manejo las fechas?

```swift
let dateField = CustomTextField(type: .date, title: "Fecha")
dateField.onCalendarTap = {
    self.presentDatePicker()
}

dateField.onEndEditing = { value in
    print("Fecha seleccionada: \(value)")
}
```

## OTPView

### ¿Cómo establezco un OTP desde código?

```swift
let otpView = OTPView(numberOfDigits: 6)
otpView.setOTP("123456")
```

### ¿Cómo obtengo el OTP actual?

```swift
let currentOTP = otpView.getOTP()  // Retorna String
```

### ¿Cómo limpio los campos?

```swift
otpView.clearOTP()  // Limpia y enfoca el primer campo
```

### ¿Soporta autofill de OTP?

Sí, el OTPView soporta autofill automático de códigos OTP del sistema (iOS 12+).

## ProgressHUDView

### ¿Cómo muestro un indicador de carga?

```swift
let hud = ProgressHUDView(animationName: "Loader")
hud.present(on: view, animated: true)

// Hacer algo asincrónico...

hud.dismiss(animated: true)
```

### ¿Puedo usar otras animaciones Lottie?

Sí, puedes usar cualquier archivo JSON de Lottie:

```swift
let hud = ProgressHUDView(animationName: "MiAnimacion")
```

### ¿Es thread-safe el ProgressHUDView?

Sí, detecta automáticamente si se llama desde un thread secundario y cambia al main thread.

### ¿Cómo cambio la opacidad del fondo?

```swift
let hud = ProgressHUDView(
    animationName: "Loader",
    dimAlpha: 0.5  // 0.0 (transparente) a 1.0 (opaco)
)
```

## TermsView

### ¿Cómo verifico si los términos fueron aceptados?

```swift
if termsView.isChecked {
    print("Términos aceptados")
} else {
    print("Términos no aceptados")
}
```

### ¿Cómo personalizo el texto de términos?

```swift
termsView.setTermsText(
    mainText: "Acepto la ",
    linkText: "Política de Privacidad"
)
```

### ¿Cómo manejo el tap en el enlace?

```swift
termsView.onTermsTap = {
    self.presentTermsOfService()
}
```

## CustomProgress y StepView

### ¿Cuál es el rango de progreso?

El progreso debe estar entre 0.0 (0%) y 1.0 (100%).

### ¿Cómo animo el cambio de progreso?

```swift
progress.setProgress(0.5, animated: true)
```

### ¿Cómo muestro el porcentaje?

```swift
progress.showsPercentage = true
```

### ¿Cómo uso StepView para pasos?

```swift
stepView.setStepLabel(currentStep: 2, totalSteps: 5)
stepView.progress.setProgress(0.4, animated: true)
```

## Accesibilidad

### ¿Todos los componentes soportan VoiceOver?

Sí, todos los componentes están diseñados con accesibilidad en mente y soportan VoiceOver.

### ¿Qué tamaños mínimos tienen los componentes?

Los botones y controles interactivos tienen un tamaño mínimo de 44x44 puntos para cumplir con las pautas de Apple.

## Localización

### ¿Soporta Gentera-UI múltiples idiomas?

La documentación está en español. Los componentes no contienen texto hardcodeado (excepto placeholders de ejemplo) por lo que son agnósticos al idioma.

## Problemas Comunes

### El componente no aparece

Verifica que:
1. El componente está agregado a la jerarquía de vistas (`addSubview`)
2. Se establecieron constraints válidas
3. El componente tiene un tamaño válido (width y height > 0)

### El constraint de Auto Layout causa conflictos

Verifica que:
1. No hay constraints conflictivos
2. El componente tiene `translatesAutoresizingMaskIntoConstraints = false`
3. Todas las restricciones necesarias están definidas

### El OTPView no acepta entrada

Verifica que:
1. El primer campo está enfocado (`focusFirstField()`)
2. El teclado es correcto (debe ser numérico)
3. Solo estás ingresando dígitos

### El ProgressHUDView no desaparece

Verifica que:
1. Llamaste a `dismiss(animated:completion:)`
2. Estás en el main thread
3. No hay errores en la consola

## Rendimiento

### ¿Afecta el uso de múltiples componentes al rendimiento?

No, Gentera-UI está optimizado para rendimiento. Se puede usar múltiples componentes sin problemas de performance.

### ¿Cómo optimizo animaciones?

```swift
// Desactivar animaciones si no es necesario
progress.setProgress(0.5, animated: false)

// Usar duración más corta
progress.animationDuration = 0.1
```

## Contribuciones y Soporte

### ¿Cómo reporto un bug?

Abre un issue en el repositorio con:
- Descripción clara del problema
- Pasos para reproducir
- Versión de iOS y Xcode
- Screenshots si es aplicable

### ¿Cómo sugiero una nueva característica?

Abre un issue con la etiqueta `enhancement` describiendo:
- La característica sugerida
- Caso de uso
- Cómo debería funcionar

### ¿Puedo contribuir con código?

¡Sí! Lee [CONTRIBUTING.md](CONTRIBUTING.md) para conocer el proceso.

---

**¿No encontraste la respuesta?** Abre un issue o contacta al equipo de desarrollo.
