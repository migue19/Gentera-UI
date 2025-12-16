# Índice de Documentación - Gentera-UI

Guía completa de toda la documentación disponible en Gentera-UI.

## 📄 Documentación del Proyecto

### Archivos Raíz

1. **[README.md](README.md)** - Descripción general del proyecto
   - Características principales
   - Instalación
   - Requisitos
   - Ejemplos básicos

2. **[CHANGELOG.md](CHANGELOG.md)** - Historial de cambios
   - Versiones
   - Características agregadas
   - Bugs corregidos
   - Cambios importantes

3. **[CONTRIBUTING.md](CONTRIBUTING.md)** - Guía para contribuyentes
   - Cómo reportar bugs
   - Cómo sugerir mejoras
   - Proceso de Pull Request
   - Pautas de desarrollo

4. **[DEVELOPMENT.md](DEVELOPMENT.md)** - Guía para desarrolladores
   - Configuración del entorno
   - Estructura del proyecto
   - Patrones de diseño
   - Testing
   - Debugging

5. **[FAQ.md](FAQ.md)** - Preguntas frecuentes
   - Instalación
   - Uso general
   - Preguntas por componente
   - Problemas comunes

## 📚 Documentación de DocC

### Índice Principal

- **[Documentation.md](Gentera-UI/Documentation.docc/Documentation.md)** - Página principal de DocC
  - Overview del proyecto
  - Navegación a componentes

### Guía de Inicio

- **[GettingStarted.md](Gentera-UI/Documentation.docc/GettingStarted.md)** - Guía rápida
  - Instalación paso a paso
  - Primeros pasos
  - Ejemplos comunes
  - Personalización

## 🧩 Documentación de Componentes

### Controles Básicos

1. **[CustomButton.md](Gentera-UI/Documentation.docc/CustomButton.md)**
   - Descripción: Botón personalizable con 3 estilos
   - Estilos: primary, secondary, link
   - Ejemplo de uso
   - API completa

2. **[CustomLabel.md](Gentera-UI/Documentation.docc/CustomLabel.md)**
   - Descripción: Etiqueta con estilos predefinidos
   - Estilos: title, subtitle
   - Ejemplo de uso
   - API completa

### Entrada de Datos

3. **[CustomTextField.md](Gentera-UI/Documentation.docc/CustomTextField.md)**
   - Descripción: Campo de texto avanzado
   - Tipos: normal, phone, idCard, date
   - Máscaras automáticas
   - Callbacks y validación

4. **[OTPView.md](Gentera-UI/Documentation.docc/OTPView.md)**
   - Descripción: Entrada de códigos OTP
   - Configuración de dígitos
   - Autofill automático
   - API de control

### Indicadores de Progreso

5. **[CustomProgress.md](Gentera-UI/Documentation.docc/CustomProgress.md)**
   - Descripción: Barra de progreso personalizable
   - Animaciones
   - Mostrar porcentaje
   - Personalización de colores

6. **[StepView.md](Gentera-UI/Documentation.docc/StepView.md)**
   - Descripción: Indicador multipasos
   - Integración con progreso
   - Etiqueta de paso
   - Ejemplo de flujo

### Vistas Especializadas

7. **[TermsView.md](Gentera-UI/Documentation.docc/TermsView.md)**
   - Descripción: Checkbox de términos
   - Texto con enlace
   - Estados visuales
   - Validación

8. **[ProgressHUDView.md](Gentera-UI/Documentation.docc/ProgressHUDView.md)**
   - Descripción: HUD de carga
   - Animaciones Lottie
   - Thread-safe
   - Personalización de blur

### Animaciones

9. **[Animation-Loader.md](Gentera-UI/Documentation.docc/Animation-Loader.md)**
   - Descripción: Animación Lottie de carga
   - Ubicación del archivo
   - Integración con ProgressHUDView
   - Personalización

## 🗂️ Estructura de Documentación

```
Gentera-UI/
├── README.md                    # Descripción general
├── CHANGELOG.md                 # Historial de versiones
├── CONTRIBUTING.md              # Guía para contribuir
├── DEVELOPMENT.md               # Guía de desarrollo
├── FAQ.md                        # Preguntas frecuentes
├── DOCUMENTATION_INDEX.md        # Este archivo
│
└── Gentera-UI/Documentation.docc/
    ├── Documentation.md          # Página principal
    ├── GettingStarted.md         # Guía rápida
    ├── CustomButton.md           # Componente
    ├── CustomLabel.md            # Componente
    ├── CustomTextField.md        # Componente
    ├── CustomProgress.md         # Componente
    ├── StepView.md               # Componente
    ├── OTPView.md                # Componente
    ├── TermsView.md              # Componente
    ├── ProgressHUDView.md        # Componente
    └── Animation-Loader.md       # Animación
```

## 🔍 Búsqueda Rápida

### Por Tipo de Documento

**Para comenzar:**
- README.md - Vista general
- GettingStarted.md - Primeros pasos
- FAQ.md - Preguntas comunes

**Para desarrollar:**
- DEVELOPMENT.md - Guía completa
- CONTRIBUTING.md - Cómo contribuir
- Documentación de componentes - Especificaciones

**Para referencia:**
- CHANGELOG.md - Cambios
- FAQ.md - Solución de problemas

### Por Componente

| Componente | Archivo | Tipo |
|-----------|---------|------|
| CustomButton | CustomButton.md | Control |
| CustomLabel | CustomLabel.md | Control |
| CustomTextField | CustomTextField.md | Entrada |
| OTPView | OTPView.md | Entrada |
| CustomProgress | CustomProgress.md | Progreso |
| StepView | StepView.md | Progreso |
| TermsView | TermsView.md | Especializado |
| ProgressHUDView | ProgressHUDView.md | Especializado |
| Loader | Animation-Loader.md | Animación |

## 📖 Recomendaciones de Lectura

### Para Nuevos Usuarios

1. Leer: **README.md** (5 min)
2. Leer: **GettingStarted.md** (10 min)
3. Consultar: Documentación de componentes específicos (según necesidad)
4. Referencia: **FAQ.md** para problemas comunes

### Para Desarrolladores

1. Leer: **DEVELOPMENT.md** (20 min)
2. Leer: **CONTRIBUTING.md** (10 min)
3. Estudiar: Código de componentes
4. Consultar: CHANGELOG.md para historial

### Para Mantenedores

1. Leer: **CONTRIBUTING.md** (referencia)
2. Leer: **DEVELOPMENT.md** (referencia)
3. Mantener: CHANGELOG.md actualizado
4. Revisar: Pull Requests

## 💡 Tips de Documentación

- **Búsqueda rápida en DocC**: Usa Cmd+K en Xcode
- **Ejemplos interactivos**: Los ejemplos en markdown se pueden copiar directamente
- **Accesibilidad**: Toda la documentación es accesible
- **Actualización**: La documentación se mantiene sincronizada con el código

## 📱 Acceso a Documentación

### En Xcode

1. Abre el proyecto workspace
2. Selecciona un componente
3. Option+Click para ver documentación
4. O abre "Developer Documentation" (Cmd+Option+?)

### En GitHub

1. Clona el repositorio
2. Los archivos .md están en la raíz y en `Gentera-UI/Documentation.docc/`
3. Visualiza directamente en GitHub

## 🔗 Enlaces Útiles

- [Swift Official Documentation](https://developer.apple.com/documentation/swift)
- [UIKit Documentation](https://developer.apple.com/documentation/uikit)
- [DocC Documentation](https://www.swift.org/documentation/docc)
- [Lottie iOS](https://github.com/airbnb/lottie-ios)

## 📝 Cómo Actualizar la Documentación

1. Identifica el componente o área que necesita actualización
2. Localiza el archivo .md correspondiente
3. Realiza los cambios
4. Verifica que se renderice correctamente
5. Haz commit con mensaje descriptivo

Ejemplo:
```bash
git commit -m "Docs: actualizar ejemplo en CustomButton.md"
```

## ✅ Checklist de Documentación Completa

- [x] README.md
- [x] CHANGELOG.md
- [x] CONTRIBUTING.md
- [x] DEVELOPMENT.md
- [x] FAQ.md
- [x] Documentation.md (DocC)
- [x] GettingStarted.md
- [x] CustomButton.md
- [x] CustomLabel.md
- [x] CustomTextField.md
- [x] CustomProgress.md
- [x] StepView.md
- [x] OTPView.md
- [x] TermsView.md
- [x] ProgressHUDView.md
- [x] Animation-Loader.md

---

**Última actualización**: 2025-12-16

Para reportar problemas en la documentación, abre un issue en el repositorio.
