# CHANGELOG.md

Todos los cambios notables en este proyecto se documentarán en este archivo.

El formato se basa en [Keep a Changelog](https://keepachangelog.com/) y este proyecto adhiere a [Semantic Versioning](https://semver.org/).

## [1.0.0] - 2025-12-16

### Added

#### Componentes de Interfaz

- **CustomButton**: Botón personalizable con tres estilos (primario, secundario, enlace)
  - Soporte para múltiples estados (habilitado/deshabilitado)
  - Animaciones suaves en cambios de estado
  - Alto fijo de 50 puntos
  - Radio de esquinas de 8 puntos

- **CustomLabel**: Etiqueta personalizada con estilos predefinidos
  - Estilos: título (24pt bold) y subtítulo (16pt regular)
  - Soporte para múltiples líneas
  - Alineación centrada automática

- **CustomTextField**: Campo de texto avanzado con múltiples tipos
  - Tipos soportados: normal, teléfono, cédula, fecha
  - Máscaras automáticas por tipo
  - Etiqueta integrada
  - Botones contextuales (cámara, calendario)
  - Validación automática de entrada

- **CustomProgressView**: Barra de progreso personalizable
  - Animación suave de progreso
  - Opción de mostrar porcentaje
  - Colores personalizables
  - Radio de esquinas ajustable

- **StepView**: Indicador de progreso multipasos
  - Integración con CustomProgressView
  - Etiqueta de paso (X/Y)
  - Altura personalizable

- **OTPView**: Componente de entrada de códigos OTP
  - Número de dígitos configurable (default: 6)
  - Navegación automática entre campos
  - Soporte para autofill de OTP del sistema
  - Callbacks para completitud y cambios

- **TermsView**: Checkbox de términos y condiciones
  - Checkbox visual
  - Texto con enlace integrado
  - Callbacks para cambios y taps
  - Múltiples líneas de texto

- **ProgressHUDView**: HUD de carga con animaciones Lottie
  - Efecto blur personalizable
  - Carga de animaciones Lottie
  - Thread-safe
  - Bloqueo de interacción automático

#### Animaciones

- **Loader.json**: Animación Lottie para indicadores de carga
  - Integrada con ProgressHUDView
  - Tamaño personalizable
  - Velocidad ajustable

#### Documentación

- **Documentation.docc**: Documentación completa con DocC
  - Guía de inicio rápido
  - Páginas individuales para cada componente
  - Ejemplos de uso en Swift
  - Tablas de API
  - Notas sobre personalización

- **README.md**: Documentación general del proyecto
- **CONTRIBUTING.md**: Pautas para contribuyentes
- **CHANGELOG.md**: Este archivo

### Features Comunes

- ✅ Auto Layout (sin Storyboards)
- ✅ Accesibilidad (VoiceOver compatible)
- ✅ Animaciones suaves
- ✅ Personalización completa
- ✅ Localización en español

### Requisitos

- iOS 12.0+
- Swift 5.0+
- Xcode 12.0+

### Dependencias

- lottie-ios 4.4.0+

### Notas

- Primera versión estable
- Todos los componentes completamente funcionales
- Documentación completa
- Tests incluidos

---

## Formato de Versiones Futuras

Para futuras versiones, mantén este formato:

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- Nueva funcionalidad

### Changed
- Cambios en funcionalidad existente

### Deprecated
- Funcionalidad a deprecar

### Removed
- Funcionalidad removida

### Fixed
- Correcciones de bugs

### Security
- Arreglos de seguridad
```

---

**Última actualización**: 2025-12-16
