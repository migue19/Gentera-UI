# CustomTextField

Un campo de texto personalizado con soporte para múltiples tipos y máscaras de entrada.

## Overview

`CustomTextField` es un componente de entrada de texto que soporta diferentes tipos (normal, teléfono, cédula, fecha) con máscaras automáticas y validación. Incluye etiqueta integrada, botones de acción y controles de entrada específicos por tipo.

## Tipos de Campo

- **normal**: Campo de texto estándar
- **phone**: Campo de teléfono con máscara (XXX) XXX-XXXX
- **idCard**: Campo de cédula con solo dígitos
- **date**: Campo de fecha con selector de calendario

![TextField Input](CustomTextField-Input.svg)

## Ejemplo de Uso

```swift
import Gentera_UI

// Campo de texto normal
let textField = CustomTextField(placeholder: "Nombre completo", type: .normal, title: "Nombre")
view.addSubview(textField)

// Campo de teléfono
let phoneField = CustomTextField(placeholder: "555-1234", type: .phone, title: "Teléfono")
view.addSubview(phoneField)

// Campo de fecha
let dateField = CustomTextField(placeholder: "dd/mm/yyyy", type: .date, title: "Fecha de Nacimiento")
view.addSubview(dateField)

// Constraints
NSLayoutConstraint.activate([
    textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
])
```

## Inicializadores

### init(placeholder:type:title:)

```swift
public init(placeholder: String = "", type: CustomTextFieldType = .normal, title: String? = nil)
```

Crea un nuevo campo de texto con los parámetros especificados.

**Parámetros:**
- `placeholder`: Texto de placeholder (vacío por defecto)
- `type`: Tipo de campo (`.normal` por defecto)
- `title`: Etiqueta del campo (opcional)

## API Pública

### Propiedades

| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| `type` | `CustomTextFieldType` | El tipo de campo (solo lectura) |
| `textField` | `UITextField` | Acceso al campo de texto subyacente |

### Callbacks

| Callback | Descripción |
|----------|-------------|
| `onCameraTap` | Se ejecuta cuando se presiona el botón de cámara (tipo idCard) |
| `onCalendarTap` | Se ejecuta cuando se presiona el botón de calendario (tipo date) |
| `onEndEditing` | Se ejecuta cuando finaliza la edición, pasa el valor procesado |

## Tipos de Campo y Máscaras

### Normal

```swift
let field = CustomTextField(placeholder: "Ingrese texto", type: .normal, title: "Texto")
```

- Entrada de texto estándar
- Sin máscaras
- Sin restricciones de caracteres

### Phone

```swift
let field = CustomTextField(placeholder: "(555) 123-4567", type: .phone, title: "Teléfono")
```

- Máscara: `(XXX) XXX-XXXX`
- Solo dígitos permitidos
- Máximo 10 dígitos

### ID Card

```swift
let field = CustomTextField(placeholder: "12345678", type: .idCard, title: "Cédula")
field.onCameraTap = {
    // Abrir cámara
}
```

- Solo dígitos permitidos
- Botón de cámara en la derecha
- Máximo 13 caracteres

### Date

```swift
let field = CustomTextField(placeholder: "dd/mm/yyyy", type: .date, title: "Fecha")
field.onCalendarTap = {
    // Mostrar selector de fecha
}
```

- Formato: `dd/mm/yyyy`
- Botón de calendario en la derecha
- Validación de fecha

## Personalización

### Cambiar el valor del campo

```swift
field.textField.text = "Nuevo valor"
```

### Cambiar el placeholder

```swift
field.textField.placeholder = "Nuevo placeholder"
```

### Personalizar estilos

```swift
field.textField.font = UIFont.systemFont(ofSize: 16)
field.textField.textColor = .blue
```

## Características

- **Etiqueta integrada**: Mostrada automáticamente si se proporciona
- **Auto Layout**: Compatible con constraints
- **Validación**: Aplicada automáticamente según el tipo
- **Botones contextuales**: Cámara para cédula, calendario para fecha
- **Accesibilidad**: Compatible con VoiceOver

## Comportamiento

- **Validación de entrada**: Se aplica en tiempo real según el tipo
- **Limpieza automática**: Los valores se procesan y limpian según el tipo
- **Radio de esquinas**: 8 puntos
- **Borde**: 1 punto de grosor, gris claro por defecto

## Notas Importantes

- El componente usa `translatesAutoresizingMaskIntoConstraints = false`, requiere constraints
- Para campos de fecha y cédula, implementa los callbacks `onCalendarTap` y `onCameraTap`
- El método `onEndEditing` proporciona el valor sin máscara para procesamiento
- Compatible con iOS 12+
