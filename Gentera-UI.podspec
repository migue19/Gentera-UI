Pod::Spec.new do |s|
  s.name         = 'Gentera-UI'
  s.version      = '0.1.0'
  s.summary      = 'Componentes de UI reutilizables para Gentera.'
  s.homepage     = 'https://github.com/migue19/Gentera-UI'

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Miguel Mexicano Herrera' => 'e-mmexicano@compartamos.com' }

  s.source       = { :git => 'https://github.com/migue19/Gentera-UI.git', :tag => s.version }

  s.platform     = :ios, '16.0'
  s.swift_version = '5.0'

  # Incluye todos los archivos Swift del módulo
  s.source_files = 'Gentera-UI/**/*.swift'
  s.dependency 'lottie-ios'

  s.requires_arc = true
end
