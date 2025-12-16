# Guía Rápida de Gentera-UI

Una guía introductoria rápida para comenzar con Gentera-UI.

## Instalación

### CocoaPods

Agrega Gentera-UI a tu `Podfile`:

```ruby
pod 'Gentera-UI', :git => 'https://github.com/tu-repo/Gentera-UI.git'
```

Luego ejecuta:

```bash
pod install
```

## Primeros Pasos

### 1. Importa Gentera-UI

```swift
import Gentera_UI
```

### 2. Componentes Básicos

#### Botón

```swift
let button = CustomButton(title: "Aceptar", style: .primary)
button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
view.addSubview(button)
```

#### Etiqueta

```swift
let label = CustomLabel(text: "Bienvenido", style: .title)
view.addSubview(label)
```

#### Campo de Texto

```swift
let textField = CustomTextField(placeholder: "Nombre", type: .normal, title: "Tu Nombre")
view.addSubview(textField)
```

#### Indicador de Carga

```swift
let hud = ProgressHUDView(animationName: "Loader")
hud.present(on: view, animated: true)

DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    hud.dismiss(animated: true)
}
```

## Ejemplos Comunes

### Formulario Simple

```swift
class FormViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Título
        let titleLabel = CustomLabel(text: "Registrarse", style: .title)
        view.addSubview(titleLabel)
        
        // Campo de email
        let emailField = CustomTextField(
            placeholder: "correo@ejemplo.com",
            type: .normal,
            title: "Email"
        )
        view.addSubview(emailField)
        
        // Campo de teléfono
        let phoneField = CustomTextField(
            placeholder: "(555) 123-4567",
            type: .phone,
            title: "Teléfono"
        )
        view.addSubview(phoneField)
        
        // Términos
        let termsView = TermsView()
        termsView.setTermsText(
            mainText: "Acepto los ",
            linkText: "Términos y Condiciones"
        )
        view.addSubview(termsView)
        
        // Botón de envío
        let submitButton = CustomButton(title: "Registrarse", style: .primary)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        view.addSubview(submitButton)
        
        // Constraints (simplificado)
        setupConstraints()
    }
    
    @objc func submit() {
        // Manejar envío
    }
    
    func setupConstraints() {
        // Agregar constraints aquí
    }
}
```

### Flujo de Pasos Multipasos

```swift
let stepView = StepView()
view.addSubview(stepView)

// Actualizar progreso
stepView.progress.setProgress(0.33, animated: true)
stepView.setStepLabel(currentStep: 1, totalSteps: 3)

// Personalizar colores
stepView.progress.progressTintColor = .systemBlue
```

### Entrada OTP

```swift
let otpView = OTPView(numberOfDigits: 6)
view.addSubview(otpView)

otpView.onOTPComplete = { otp in
    print("OTP completo: \(otp)")
    self.verifyOTP(otp)
}

otpView.focusFirstField()
```

## Personalización

### Estilos de Botón

```swift
let primaryButton = CustomButton(title: "Aceptar", style: .primary)
let secondaryButton = CustomButton(title: "Cancelar", style: .secondary)
let linkButton = CustomButton(title: "Ver más", style: .link)
```

### Tipos de Campo de Texto

```swift
let normalField = CustomTextField(type: .normal)
let phoneField = CustomTextField(type: .phone)
let idCardField = CustomTextField(type: .idCard)
let dateField = CustomTextField(type: .date)
```

### Cambiar Colores

```swift
let progress = CustomProgressView()
progress.progressTintColor = .systemGreen
progress.trackTintColor = UIColor(white: 0.95, alpha: 1)
progress.cornerRadius = 6
```

## Ayuda y Soporte

Para más detalles sobre cada componente, consulta la documentación específica:

- <doc:CustomButton>
- <doc:CustomLabel>
- <doc:CustomTextField>
- <doc:CustomProgress>
- <doc:StepView>
- <doc:OTPView>
- <doc:TermsView>
- <doc:ProgressHUDView>
- <doc:Animation-Loader>

## Tips

- **Auto Layout**: Todos los componentes requieren constraints
- **Thread Safety**: `ProgressHUDView` es thread-safe
- **Accesibilidad**: Todos los componentes soportan VoiceOver
- **Animaciones**: Los cambios de estado se animan automáticamente

## Requisitos

- iOS 12.0+
- Swift 5.0+
- Xcode 12.0+

## Dependencias

- [lottie-ios](https://github.com/airbnb/lottie-ios): Para animaciones

