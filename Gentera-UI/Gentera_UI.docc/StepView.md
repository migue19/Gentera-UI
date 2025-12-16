# StepView

Un componente para mostrar el progreso de un proceso de varios pasos.

## Overview

`StepView` combina una barra de progreso con una etiqueta de paso, proporcionando una forma clara de visualizar el progreso dentro de un flujo de múltiples pasos. Ideal para procesos de onboarding, formularios multipasos o wizards.

## Usos

Utiliza `StepView` para:
- Mostrar el progreso en formularios multipasos
- Indicar el paso actual en un proceso
- Proporcionar contexto de progreso en wizards
- Flujos de onboarding

## Ejemplo de Uso

```swift
import Gentera_UI

// Crear StepView
let stepView = StepView()
stepView.progressHeight = 8
view.addSubview(stepView)

// Actualizar progreso
stepView.progress.setProgress(0.33, animated: true)
stepView.setStepLabel(currentStep: 1, totalSteps: 3)

// Personalizar colores
stepView.progress.progressTintColor = .systemBlue
stepView.progress.trackTintColor = UIColor(white: 0.93, alpha: 1)

// Constraints
NSLayoutConstraint.activate([
    stepView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    stepView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    stepView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
])
```

## Inicializadores

### init(frame:)

```swift
public override init(frame: CGRect)
```

Crea un nuevo StepView con el frame especificado.

### init(coder:)

```swift
required init?(coder: NSCoder)
```

Crea un StepView desde un archivo de interfaz (Storyboard/XIB).

## API Pública

### Propiedades

| Propiedad | Tipo | Default | Descripción |
|-----------|------|---------|-------------|
| `progress` | `CustomProgressView` | - | Barra de progreso (acceso completo) |
| `progressHeight` | `CGFloat` | `8` | Alto de la barra de progreso |

### Métodos

#### setStepLabel(currentStep:totalSteps:)

```swift
public func setStepLabel(currentStep: Int, totalSteps: Int)
```

Actualiza la etiqueta mostrando el paso actual y total.

**Parámetros:**
- `currentStep`: Número del paso actual (ej: 1)
- `totalSteps`: Total de pasos (ej: 3)

**Ejemplo:**
```swift
stepView.setStepLabel(currentStep: 2, totalSteps: 5)  // Muestra "2/5"
```

## Características

- **Barra de progreso integrada**: Acceso directo a `CustomProgressView`
- **Etiqueta de paso**: Muestra formato "X/Y"
- **Altura personalizable**: Controla el grosor de la barra
- **Alineación derecha**: La etiqueta está alineada a la derecha
- **Auto Layout**: Compatible con constraints
- **Accesibilidad**: Compatible con VoiceOver

## Comportamiento

- **Layout**: Barra de progreso arriba, etiqueta de paso abajo
- **Altura fija**: 46 puntos por defecto
- **Espaciado**: 8 puntos entre la barra y la etiqueta
- **Alineación**: Texto alineado a la derecha

## Ejemplo Avanzado

```swift
// Flujo de pasos
class MultiStepViewController: UIViewController {
    let stepView = StepView()
    var currentStep = 1
    let totalSteps = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stepView)
        updateStepView()
    }
    
    func updateStepView() {
        // Calcular progreso
        let progress = CGFloat(currentStep) / CGFloat(totalSteps)
        
        // Animar progreso
        stepView.progress.setProgress(progress, animated: true)
        
        // Actualizar etiqueta
        stepView.setStepLabel(currentStep: currentStep, totalSteps: totalSteps)
    }
    
    func nextStep() {
        if currentStep < totalSteps {
            currentStep += 1
            updateStepView()
        }
    }
    
    func previousStep() {
        if currentStep > 1 {
            currentStep -= 1
            updateStepView()
        }
    }
}
```

## Personalización

### Cambiar altura de la barra

```swift
stepView.progressHeight = 6  // Más delgada
stepView.progressHeight = 12  // Más gruesa
```

### Personalizar colores del progreso

```swift
stepView.progress.progressTintColor = .systemGreen
stepView.progress.trackTintColor = UIColor(white: 0.95, alpha: 1)
```

### Personalizar radio de esquinas

```swift
stepView.progress.cornerRadius = 4
```

### Mostrar porcentaje

```swift
stepView.progress.showsPercentage = true
```

## Relación con otros componentes

- **CustomProgressView**: `StepView` contiene internamente una `CustomProgressView`
- **Uso conjunto**: Puedes usar `StepView` para mostrar progreso general y tener `CustomProgressView` individual para detalles

## Notas Importantes

- El componente usa `translatesAutoresizingMaskIntoConstraints = false`, requiere constraints
- La altura del StepView es fija (46 puntos) pero se puede personalizar
- Compatible con iOS 12+
- La etiqueta de paso muestra solo el formato "X/Y", personaliza manualmente si necesitas otro formato
