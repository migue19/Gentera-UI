# CONTRIBUTING.md

Gracias por tu interés en contribuir a Gentera-UI. Este documento proporciona orientación y pautas para contribuir.

## Código de Conducta

Todos los contribuyentes deben adherirse a un código de conducta profesional y respetuoso.

## Cómo Contribuir

### Reportar Bugs

Antes de crear un reporte de bug, verifica que el problema no haya sido reportado. Cuando reportes un bug, incluye:

- Descripción clara del problema
- Pasos específicos para reproducir
- Comportamiento observado
- Comportamiento esperado
- Screenshots si es aplicable
- Versión de iOS y Xcode

### Sugerir Mejoras

Las sugerencias de mejora se pueden enviar como issues. Incluye:

- Descripción clara de la mejora
- Motivación y casos de uso
- Ejemplos de cómo funcionaría

### Pull Requests

1. **Antes de comenzar**: Discute cambios mayores en un issue primero
2. **Fork** el repositorio
3. **Crea** una rama para tu feature:
   ```bash
   git checkout -b feature/DescripcionDelFeature
   ```
4. **Realiza** tus cambios
5. **Agrega** tests si es necesario
6. **Commit** con mensajes descriptivos:
   ```bash
   git commit -m 'Add: nueva funcionalidad'
   ```
7. **Push** a tu fork:
   ```bash
   git push origin feature/DescripcionDelFeature
   ```
8. **Abre** un Pull Request con descripción clara

## Pautas de Desarrollo

### Estilo de Código

- Sigue las convenciones de Swift
- Usa nombres descriptivos para variables y métodos
- Documenta funciones públicas con comentarios
- Usa tipos explícitos cuando sea necesario

### Componentes Nuevos

Si estás creando un componente nuevo:

1. Hereda de `UIView` (preferiblemente)
2. Usa `translatesAutoresizingMaskIntoConstraints = false`
3. Implementa `commonInit()` para inicialización
4. Proporciona callbacks públicos para eventos
5. Incluye documentación DocC
6. Agrega ejemplos de uso

### Ejemplo de Nuevo Componente

```swift
public class CustomComponent: UIView {
    // MARK: - Callbacks
    public var onValueChange: ((String) -> Void)?
    
    // MARK: - Lifecycle
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
        // Configurar subviews aquí
    }
    
    // MARK: - Public API
    public func setValue(_ value: String) {
        // Implementar
    }
}
```

### Documentación

- Documenta funciones públicas con comentarios DocC
- Incluye ejemplos de uso
- Describe parámetros y valores de retorno
- Agrega una página markdown en `Gentera_UI.docc/`

### Tests

- Escribe tests para funcionalidad crítica
- Actualiza tests cuando modifiques código existente
- Mantén una cobertura de pruebas del 70%+

### Accesibilidad

- Todos los componentes deben ser accesibles
- Incluye `accessibilityLabel` y `accessibilityHint`
- Prueba con VoiceOver
- Mantén tamaños mínimos de 44x44 puntos

## Proceso de Review

1. Un mantenedor revisará tu PR
2. Se pueden solicitar cambios
3. Una vez aprobado, se hará merge
4. Se agregará a la siguiente versión

## Versionamiento

Este proyecto sigue [Semantic Versioning](https://semver.org/):

- **MAJOR**: Cambios incompatibles
- **MINOR**: Nuevas funcionalidades compatibles
- **PATCH**: Correcciones de bugs

## Publicación

Los mantenedores manejan la publicación:

1. Actualizar `CHANGELOG.md`
2. Actualizar versión en `podspec`
3. Crear tag en git
4. Publicar a CocoaPods

## Preguntas

Si tienes preguntas, abre un issue o contacta al equipo de desarrollo.

## Licencia

Al contribuir, aceptas que tus contribuciones se licencien bajo la misma licencia del proyecto.

---

Gracias por contribuir a mejorar Gentera-UI! 🙌
