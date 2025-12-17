# OTPView

Un componente para entrada de códigos OTP (One-Time Password) con soporte para autofill.

## Overview

`OTPView` proporciona una interfaz visual para que los usuarios ingresen códigos OTP de múltiples dígitos. El componente automáticamente navega entre campos, valida la entrada y notifica cuando se completa el código.

## Usos

Utiliza `OTPView` para:
- Autenticación de dos factores
- Verificación de teléfono
- Verificación de email
- Códigos de confirmación

![OTP Input](OTPView-Input.svg)

## Ejemplo de Uso

```swift
import Gentera_UI

// Crear OTPView de 6 dígitos
let otpView = OTPView(numberOfDigits: 6)
view.addSubview(otpView)

// Manejar completitud
otpView.onOTPComplete = { otp in
    print("OTP completado: \(otp)")
    self.verifyOTP(otp)
}

// Manejar cambios
otpView.onOTPChange = { otp in
    print("OTP actual: \(otp)")
}

// Constraints
NSLayoutConstraint.activate([
    otpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    otpView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
])

// Enfocar primer campo
otpView.focusFirstField()
```

## Inicializadores

### init(numberOfDigits:)

```swift
public init(numberOfDigits: Int = 6)
```

Crea un nuevo OTPView con el número de dígitos especificado.

**Parámetros:**
- `numberOfDigits`: Número de campos (default: 6)

## API Pública

### Propiedades

| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| `numberOfDigits` | `Int` | Cantidad de campos OTP (solo lectura) |

### Callbacks

| Callback | Descripción |
|----------|-------------|
| `onOTPComplete` | Se ejecuta cuando se completan todos los dígitos |
| `onOTPChange` | Se ejecuta cuando cambia cualquier dígito |

### Métodos

#### getOTP() -> String

```swift
public func getOTP() -> String
```

Retorna el código OTP actual como una cadena de dígitos.

#### clearOTP()

```swift
public func clearOTP()
```

Limpia todos los campos y enfoca el primer campo.

#### setOTP(_ otp: String)

```swift
public func setOTP(_ otp: String)
```

Establece el OTP desde una cadena. La cadena debe contener solo dígitos.

**Parámetros:**
- `otp`: Cadena con el código OTP (ej: "123456")

#### focusFirstField()

```swift
public func focusFirstField()
```

Enfoca el primer campo y abre el teclado.

## Características

- **Entrada automática**: Se mueve automáticamente al siguiente campo
- **Validación en tiempo real**: Solo acepta números
- **Autofill**: Soporte para autofill de OTP del sistema
- **Bordes visuales**: Cambio de color al enfoque (gris → negro)
- **Accesibilidad**: Compatible con VoiceOver

## Comportamiento

- **Navegación**: Al ingresar un dígito, se mueve automáticamente al siguiente campo
- **Retroceso**: Al presionar retroceso en un campo vacío, retrocede al campo anterior
- **Completitud**: `onOTPComplete` se ejecuta cuando se completan todos los dígitos
- **Cambios**: `onOTPChange` se ejecuta en cada cambio de dígito

## Ejemplo Avanzado

```swift
// OTPView con validación
let otpView = OTPView(numberOfDigits: 4)

otpView.onOTPComplete = { otp in
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.verifyOTP(otp) { success in
            if success {
                print("OTP válido")
            } else {
                otpView.clearOTP()
            }
        }
    }
}

// Mostrar indicador de carga
otpView.onOTPComplete = { otp in
    let hud = ProgressHUDView(animationName: "Loader")
    hud.present(on: self.view)
    
    self.verifyOTP(otp) { success in
        hud.dismiss(animated: true)
        // Procesar resultado
    }
}
```

## Personalización

### Cambiar número de dígitos

El número de dígitos se especifica en la inicialización y no puede cambiarse después.

```swift
let otpView = OTPView(numberOfDigits: 4)  // Para 4 dígitos
```

## Notas Importantes

- El componente usa `translatesAutoresizingMaskIntoConstraints = false`, requiere constraints
- Solo acepta dígitos (0-9)
- Compatible con autofill de OTP del sistema (iOS 12+)
- El teclado es numérico para mejor UX
- Compatible con iOS 12+
