# TermsView

Un componente para mostrar y gestionar la aceptación de términos y condiciones.

## Overview

`TermsView` proporciona un checkbox con texto de términos y condiciones integrado. Permite que el usuario acepte términos y generar callbacks cuando se interactúa con el componente.

## Usos

Utiliza `TermsView` para:
- Solicitar aceptación de términos y condiciones
- Mostrar checkbox de privacidad
- Crear formularios con acuerdos legales
- Términos de servicio y políticas

![Terms Checkbox](TermsView-Checkbox.svg)

## Ejemplo de Uso

```swift
import Gentera_UI

// Crear TermsView
let termsView = TermsView()
view.addSubview(termsView)

// Manejar cambios en el checkbox
termsView.onToggle = { isChecked in
    print("Términos \(isChecked ? "aceptados" : "rechazados")")
}

// Manejar tap en el enlace de términos
termsView.onTermsTap = {
    print("Usuario presionó el enlace de términos")
    // Abrir términos completos
}

// Constraints
NSLayoutConstraint.activate([
    termsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    termsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    termsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
])

// Verificar si está aceptado
if termsView.isChecked {
    print("Términos aceptados, proceder")
}
```

## Inicializadores

### init(frame:)

```swift
public override init(frame: CGRect)
```

Crea un nuevo TermsView con el frame especificado.

### init(coder:)

```swift
required init?(coder: NSCoder)
```

Crea un TermsView desde un archivo de interfaz (Storyboard/XIB).

## API Pública

### Propiedades

| Propiedad | Tipo | Acceso | Descripción |
|-----------|------|--------|-------------|
| `isChecked` | `Bool` | Solo lectura | Estado actual del checkbox |
| `checkboxButton` | `UIButton` | Público | Acceso al botón checkbox |
| `termsLabel` | `UILabel` | Público | Acceso a la etiqueta de texto |

### Callbacks

| Callback | Descripción |
|----------|-------------|
| `onToggle` | Se ejecuta cuando se presiona el checkbox |
| `onTermsTap` | Se ejecuta cuando se presiona el texto de términos |

### Métodos

#### setTermsText(mainText:linkText:)

```swift
public func setTermsText(mainText: String, linkText: String)
```

Establece el texto de términos con un enlace dentro del texto.

**Parámetros:**
- `mainText`: Texto principal (ej: "He leído y acepto los ")
- `linkText`: Texto del enlace (ej: "Términos y Condiciones")

**Ejemplo:**
```swift
termsView.setTermsText(
    mainText: "Acepto la ",
    linkText: "Política de Privacidad"
)
```

#### setChecked(_ checked: Bool)

```swift
public func setChecked(_ checked: Bool)
```

Establece el estado del checkbox programáticamente.

**Parámetros:**
- `checked`: `true` para marcar, `false` para desmarcar

#### toggleChecked()

```swift
@objc public func toggleChecked()
```

Alterna el estado del checkbox.

## Características

- **Checkbox visual**: Botón sistema con ícono de checkmark
- **Texto personalizable**: Soporte para texto de términos personalizado
- **Enlace integrado**: Detecta taps en el área de texto
- **Accesibilidad**: Compatible con VoiceOver
- **Layout horizontal**: Checkbox a la izquierda, texto a la derecha
- **Múltiples líneas**: Soporta texto de términos largo

## Comportamiento

- **Estado inicial**: Desmarquado por defecto
- **Animación**: El checkbox se anima al hacer tap
- **Interacción**: Tap en checkbox o en el texto alterna el estado
- **Etiqueta accesibilidad**: Actualizada automáticamente según el estado

## Ejemplo Avanzado

```swift
// Formulario con términos
class SignupViewController: UIViewController {
    let termsView = TermsView()
    let signupButton = CustomButton(title: "Registrarse", style: .primary)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar términos
        termsView.setTermsText(
            mainText: "Acepto los ",
            linkText: "Términos de Servicio"
        )
        
        // Deshabilitar botón hasta que se acepten términos
        termsView.onToggle = { isChecked in
            self.signupButton.isEnabled = isChecked
        }
        signupButton.isEnabled = false
        
        // Abrir términos completos
        termsView.onTermsTap = {
            self.presentTermsOfService()
        }
        
        view.addSubview(termsView)
        view.addSubview(signupButton)
    }
    
    func presentTermsOfService() {
        // Abrir URL o mostrar documento
    }
}

// Validación antes de enviar
func validateAndSubmit() {
    if !termsView.isChecked {
        showAlert(message: "Debes aceptar los términos")
        return
    }
    submitForm()
}
```

## Personalización

### Cambiar texto de términos

```swift
termsView.setTermsText(
    mainText: "Consiento ",
    linkText: "el procesamiento de datos"
)
```

### Cambiar color del checkbox

```swift
termsView.checkboxButton.tintColor = .systemBlue
```

### Cambiar fuente del texto

```swift
termsView.termsLabel.font = UIFont.systemFont(ofSize: 16)
```

### Cambiar color del texto

```swift
termsView.termsLabel.textColor = .darkGray
```

## Estados Visuales

| Estado | Apariencia |
|--------|-----------|
| Desmarquado | Checkbox vacío |
| Marcado | Checkbox con checkmark |

## Notas Importantes

- El componente usa `translatesAutoresizingMaskIntoConstraints = false`, requiere constraints
- El texto de términos puede contener múltiples líneas
- Compatible con iOS 12+
- Accesibilidad: compatible con VoiceOver y aumentamiento de texto
