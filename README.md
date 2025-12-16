# Gentera-UI

Una librería iOS moderna de componentes UI personalizables para aplicaciones Gentera.

## Descripción

Gentera-UI proporciona un conjunto completo de componentes UIKit reutilizables y fáciles de personalizar diseñados específicamente para las necesidades de Gentera. Todos los componentes están construidos con Auto Layout (sin Storyboards), accesibilidad y animaciones modernas en mente.

## ✨ Características

- **Componentes Listos para Usar**: Botones, etiquetas, campos de entrada, vistas de progreso y más
- **Totalmente Personalizable**: Colores, tamaños, estilos y comportamientos ajustables
- **Auto Layout**: Todos los componentes usan constraints de Auto Layout
- **Accesibilidad**: Compatible con VoiceOver y otras herramientas de accesibilidad iOS
- **Animaciones**: Efectos visuales suaves e indicadores de carga con Lottie
- **Thread-Safe**: Componentes seguros para uso en múltiples threads

## 📦 Componentes

### Controles Básicos

- **CustomButton** - Botón personalizado con múltiples estilos (primario, secundario, enlace)
- **CustomLabel** - Etiqueta con estilos predefinidos (título, subtítulo)

### Entrada de Datos

- **CustomTextField** - Campo de texto con soporte para múltiples tipos (normal, teléfono, cédula, fecha)
- **OTPView** - Componente para entrada de códigos OTP con autofill

### Indicadores de Progreso

- **CustomProgressView** - Barra de progreso animada y personalizable
- **StepView** - Indicador de progreso para procesos multipasos

### Vistas Especializadas

- **TermsView** - Checkbox con texto de términos y condiciones
- **ProgressHUDView** - HUD de carga con animaciones Lottie

### Animaciones

- **Loader** - Animación Lottie para indicadores de carga

## 🚀 Instalación

### CocoaPods

1. Agrega a tu `Podfile`:

```ruby
pod 'Gentera-UI', :git => 'https://github.com/tu-repo/Gentera-UI.git'
```

2. Ejecuta:

```bash
pod install
```

3. Importa en tu código:

```swift
import Gentera_UI
```

## 📚 Documentación

Para documentación detallada de cada componente, consulta el [DocC Documentation](https://swift.org/documentation).

### Guía Rápida

```swift
import Gentera_UI

// Botón
let button = CustomButton(title: "Aceptar", style: .primary)

// Etiqueta
let label = CustomLabel(text: "Hola", style: .title)

// Campo de texto
let textField = CustomTextField(placeholder: "Nombre", type: .normal, title: "Tu Nombre")

// OTP
let otpView = OTPView(numberOfDigits: 6)
otpView.onOTPComplete = { otp in
    print("OTP: \(otp)")
}

// Indicador de carga
let hud = ProgressHUDView(animationName: "Loader")
hud.present(on: self.view, animated: true)
```

## 🎯 Requisitos

- iOS 12.0+
- Swift 5.0+
- Xcode 12.0+

## 📦 Dependencias

- [lottie-ios](https://github.com/airbnb/lottie-ios) - Para animaciones

## 🏗️ Estructura del Proyecto

```
Gentera-UI/
├── Gentera-UI/
│   ├── CustomButton.swift
│   ├── CustomLabel.swift
│   ├── CustomProgress.swift
│   ├── CustomTextField.swift
│   ├── OTPView.swift
│   ├── ProgressHUDView.swift
│   ├── StepView.swift
│   ├── TermsView.swift
│   ├── Animation/
│   │   └── Loader.json
│   └── Gentera_UI.docc/
│       ├── Documentation.md
│       ├── GettingStarted.md
│       ├── CustomButton.md
│       ├── CustomLabel.md
│       ├── CustomTextField.md
│       ├── CustomProgress.md
│       ├── StepView.md
│       ├── OTPView.md
│       ├── TermsView.md
│       ├── ProgressHUDView.md
│       └── Animation-Loader.md
└── Gentera-UITests/
```

## 📝 Ejemplos

### Formulario Simple

```swift
class FormViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = CustomLabel(text: "Registrarse", style: .title)
        let emailField = CustomTextField(placeholder: "email@ejemplo.com", type: .normal, title: "Email")
        let submitButton = CustomButton(title: "Enviar", style: .primary)
        
        view.addSubview(titleLabel)
        view.addSubview(emailField)
        view.addSubview(submitButton)
        
        // Agregar constraints...
    }
}
```

### Verificación OTP

```swift
let otpView = OTPView(numberOfDigits: 6)

otpView.onOTPComplete = { otp in
    let hud = ProgressHUDView(animationName: "Loader")
    hud.present(on: self.view)
    
    self.verifyOTP(otp) { success in
        hud.dismiss(animated: true)
        if success {
            print("OTP válido")
        } else {
            otpView.clearOTP()
        }
    }
}
```

## ♿ Accesibilidad

Todos los componentes están diseñados con accesibilidad en mente:

- Compatible con VoiceOver
- Etiquetas accesibles descriptivas
- Soporte para aumentamiento de texto
- Contraste de colores adecuado
- Tamaños de toque mínimos (44x44 puntos)

## 🔄 Actualizaciones

Para mantenerte actualizado con las últimas actualizaciones, consulta el [CHANGELOG.md](CHANGELOG.md).

## 📄 Licencia

Este proyecto está bajo la licencia especificada en el archivo [LICENSE](LICENSE).

## 👥 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📧 Soporte

Para preguntas o problemas, contacta al equipo de desarrollo de Gentera.

## 🙏 Agradecimientos

- [Airbnb Lottie](https://github.com/airbnb/lottie-ios) - Para animaciones
- Apple - Por los marcos de iOS

---

**Desarrollado con ❤️ por el equipo de Gentera**
