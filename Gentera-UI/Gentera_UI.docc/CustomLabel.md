# CustomLabel

Una etiqueta personalizada con estilos predefinidos para títulos y subtítulos.

## Overview

`CustomLabel` es un componente UILabel mejorado que proporciona dos estilos visuales predefinidos: título y subtítulo. Ambos estilos incluyen tamaño de fuente, peso y alineación optimizados.

## Usos

Utiliza `CustomLabel` para:
- Mostrar títulos de secciones
- Mostrar subtítulos o descripciones
- Crear jerarquía visual en formularios

## Estilos Disponibles

- **title**: Fuente grande (24pt, negrita), texto centrado en negro
- **subtitle**: Fuente mediana (16pt, regular), texto centrado en gris oscuro

## Ejemplo de Uso

```swift
import Gentera_UI

// Crear un título
let titleLabel = CustomLabel(text: "Ingresa tus datos", style: .title)
view.addSubview(titleLabel)

// Crear un subtítulo
let subtitleLabel = CustomLabel(text: "Necesitamos verificar tu identidad", style: .subtitle)
view.addSubview(subtitleLabel)

// Agregar constraints
NSLayoutConstraint.activate([
    titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
    subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
])
```

## Inicializadores

### init(text:style:)

```swift
public init(text: String, style: CustomLabelStyle)
```

Crea una nueva etiqueta con el texto y estilo especificados.

**Parámetros:**
- `text`: El texto a mostrar
- `style`: El estilo visual (`.title`, `.subtitle`)

## API Pública

### Propiedades

| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| `style` | `CustomLabelStyle` | El estilo visual de la etiqueta (solo lectura) |

### Propiedades Heredadas de UILabel

- `text`: El texto mostrado en la etiqueta
- `textColor`: Color del texto
- `font`: Fuente del texto
- `numberOfLines`: Cantidad de líneas (predefinido a 0, permite múltiples líneas)

## Personalización

### Cambiar el texto

```swift
label.text = "Nuevo texto"
```

### Cambiar el color del texto

```swift
label.textColor = .blue
```

### Cambiar la alineación

```swift
label.textAlignment = .left
```

## Características

- **Múltiples líneas**: Ambos estilos soportan texto en múltiples líneas (`numberOfLines = 0`)
- **Centrado**: Alineación de texto centrada por defecto
- **Auto Layout**: Compatible con constraints de Auto Layout
- **Accesibilidad**: Compatible con VoiceOver

## Notas Importantes

- El componente usa `translatesAutoresizingMaskIntoConstraints = false`, requiere constraints
- Ambos estilos tienen `numberOfLines = 0` para permitir envolvimiento de texto
- La fuente y color se aplican automáticamente según el estilo seleccionado
- Compatible con iOS 12+
