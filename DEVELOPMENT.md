# Guía de Desarrollo - Gentera-UI

Guía completa para desarrolladores que trabajan con Gentera-UI.

## 🔧 Configuración del Entorno

### Requisitos

- Xcode 12.0+
- Swift 5.0+
- iOS 12.0+ (mínimo)
- CocoaPods 1.10+

### Configuración Inicial

1. **Clone el repositorio**:
```bash
git clone https://github.com/tu-repo/Gentera-UI.git
cd Gentera-UI
```

2. **Instale las dependencias**:
```bash
pod install
```

3. **Abra el workspace**:
```bash
open Gentera-UI.xcworkspace
```

## 📁 Estructura de Archivos

```
Gentera-UI/
├── Gentera-UI/                          # Componentes principales
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
│       └── ... (más documentación)
├── Gentera-UITests/                     # Tests unitarios
│   └── Gentera_UITests.swift
├── Pods/                                # Dependencias CocoaPods
├── Gentera-UI.podspec                   # Especificación de pod
├── Podfile                              # Configuración de dependencias
├── README.md
├── CONTRIBUTING.md
├── CHANGELOG.md
└── FAQ.md
```

## 🏗️ Arquitectura

### Patrones de Diseño

Todos los componentes siguen el patrón de:

1. **Inicialización**:
```swift
public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
}

required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
}

private func commonInit() {
    // Configuración compartida
    translatesAutoresizingMaskIntoConstraints = false
    setupViews()
    setupConstraints()
}
```

2. **Estructura de Vistas**:
- Subviews privadas creadas como propiedades lazy
- Constraints configuradas en `setupConstraints()`
- Accesibilidad configurada en `commonInit()`

3. **API Pública**:
- Métodos y propiedades claramente definidas
- Callbacks para eventos
- Enums para estilos/tipos

### Ejemplo: Crear un Nuevo Componente

```swift
import UIKit

public class CustomComponent: UIView {
    // MARK: - Callbacks
    public var onValueChanged: ((String) -> Void)?
    
    // MARK: - Subviews
    private lazy var label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 14)
        return l
    }()
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupConstraints()
        setupAccessibility()
    }
    
    // MARK: - Setup
    private func setupViews() {
        addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupAccessibility() {
        isAccessibilityElement = true
        accessibilityLabel = "Mi Componente"
    }
    
    // MARK: - Public API
    public func setValue(_ value: String) {
        label.text = value
        onValueChanged?(value)
    }
}
```

## 📚 Guía de Documentación

### Estructura de Documentación

Cada componente debe tener:

1. **Archivo markdown en `Gentera_UI.docc/`**:
   - Overview (1-3 frases)
   - Usos
   - Ejemplo de uso
   - Inicializadores
   - API Pública (tabla)
   - Personalización
   - Comportamiento
   - Notas importantes

2. **Comentarios de código**:
```swift
/// Establece el valor del componente.
/// - Parameter value: El nuevo valor
public func setValue(_ value: String) {
    // Implementación
}
```

3. **DocC Documentation**:
```swift
/// # CustomButton
/// 
/// Un botón personalizable con múltiples estilos.
/// 
/// ## Overview
/// `CustomButton` proporciona tres estilos...
```

### Plantilla de Documentación

```markdown
# ComponentName

Una breve descripción de qué hace el componente.

## Overview

Descripción detallada (1-3 frases).

## Usos

Casos de uso donde utilizar este componente.

## Ejemplo de Uso

\`\`\`swift
import Gentera_UI

let component = ComponentName()
view.addSubview(component)
\`\`\`

## Inicializadores

### init(...)

Descripción del inicializador.

## API Pública

| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| | | |

## Personalización

Cómo personalizar el componente.

## Notas Importantes

- Puntos clave a recordar
```

## ✅ Testing

### Estructura de Tests

```swift
import XCTest
@testable import Gentera_UI

class CustomComponentTests: XCTestCase {
    var component: CustomComponent!
    
    override func setUp() {
        super.setUp()
        component = CustomComponent()
    }
    
    override func tearDown() {
        component = nil
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertNotNil(component)
    }
    
    func testValueSetting() {
        component.setValue("test")
        XCTAssertEqual(component.getValue(), "test")
    }
}
```

### Ejecutar Tests

```bash
# Todos los tests
xcodebuild test -workspace Gentera-UI.xcworkspace -scheme Gentera-UI

# Tests específicos
xcodebuild test -workspace Gentera-UI.xcworkspace -scheme Gentera-UI -testMethod ComponentNameTests/testName
```

## 🎨 Accesibilidad

### Requisitos de Accesibilidad

Todos los componentes deben:

1. **Tener labels accesibles**:
```swift
isAccessibilityElement = true
accessibilityLabel = "Descripción clara"
accessibilityHint = "Instrucciones adicionales"
```

2. **Ser interactuables con VoiceOver**:
- Botones de 44x44 mínimo
- Texto legible
- Contraste adecuado

3. **Soportar aumento de texto**:
```swift
label.font = UIFont.preferredFont(forTextStyle: .body)
```

## 🚀 Publicación y Versionamiento

### Actualizar Versión

1. **Actualizar `podspec`**:
```ruby
s.version = "1.1.0"
```

2. **Actualizar `CHANGELOG.md`**:
```markdown
## [1.1.0] - 2025-12-20

### Added
- Nueva funcionalidad
```

3. **Hacer commit y tag**:
```bash
git add .
git commit -m "Version 1.1.0"
git tag 1.1.0
git push origin main --tags
```

4. **Publicar a CocoaPods**:
```bash
pod repo push --allow-warnings
```

## 🐛 Debugging

### Ver Jerarquía de Vistas

```swift
print(view.recursiveDescription)
```

### Inspeccion de Constraints

```swift
// En AppDelegate o ViewController
view.translatesAutoresizingMaskIntoConstraints = false
// Xcode mostrará conflictos de constraints
```

### Debug de Accesibilidad

```swift
// En Simulator: Accesibilidad > Inspector
// Verifica que los elementos sean accesibles
```

## 📱 Simulador

### Configurar Simulador

```bash
# Listar simuladores disponibles
xcrun simctl list devices

# Crear nuevo simulador
xcrun simctl create "iPhone 14" com.apple.CoreSimulator.SimDeviceType.iPhone-14 com.apple.CoreSimulator.SimRuntime.iOS-16-2
```

### Ejecutar en Simulador

```bash
xcodebuild build -workspace Gentera-UI.xcworkspace \
  -scheme Gentera-UI \
  -destination 'platform=iOS Simulator,name=iPhone 14'
```

## 🔄 Workflow de Desarrollo

1. **Crear rama para feature**:
```bash
git checkout -b feature/nombre-feature
```

2. **Realizar cambios y commits**:
```bash
git commit -m "Add: descripción del cambio"
```

3. **Ejecutar tests**:
```bash
xcodebuild test -workspace Gentera-UI.xcworkspace
```

4. **Crear Pull Request**:
```bash
git push origin feature/nombre-feature
# Abre PR en GitHub
```

5. **Merge después de aprobación**:
```bash
git checkout main
git pull origin main
git merge feature/nombre-feature
git push origin main
```

## 📖 Recursos Útiles

- [Swift UI Guidelines](https://developer.apple.com/design/tips/)
- [Accessibility Guidelines](https://developer.apple.com/accessibility/ios/)
- [Auto Layout Guide](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/)
- [Lottie Documentation](https://github.com/airbnb/lottie-ios)

## ⚡ Tips de Performance

1. **Lazy Loading**:
   - Usa propiedades lazy para subviews
   - Reduce carga inicial

2. **Constraints Optimization**:
   - Evita constraints redundantes
   - Usa prioridades correctas

3. **Animaciones**:
   - Mantén animaciones suaves (0.18-0.25s)
   - Evita animaciones complejas

4. **Memory**:
   - Usa `[weak self]` en closures
   - Desuscribete de observers

## 🎯 Checklist antes de Commit

- [ ] Código compilable sin warnings
- [ ] Tests pasando
- [ ] Documentación actualizada
- [ ] Cambios en CHANGELOG.md
- [ ] Constraints sin conflictos
- [ ] Accesibilidad verificada
- [ ] Commits descriptivos

---

**¡Feliz desarrollo!** 🚀
