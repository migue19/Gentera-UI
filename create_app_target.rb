#!/usr/bin/env ruby
require 'xcodeproj'

project_path = 'Gentera-UI.xcodeproj'
project = Xcodeproj::Project.open(project_path)

# Get the main group
main_group = project.main_group

# Create app group
app_group = main_group.find_subpath('Gentera-UI-App', true)

# Create the app target
app_target = project.new_target(:application, 'Gentera-UI-App', :ios)
app_target.product_name = 'Gentera-UI-App'

# Set platform
app_target.build_configurations.each do |config|
  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
  config.build_settings['SWIFT_VERSION'] = '5.0'
  config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = 'com.gentera.app'
  config.build_settings['CODE_SIGN_STYLE'] = 'Automatic'
end

# Add the library framework as a dependency
lib_target = project.targets.find { |t| t.name == 'Gentera-UI' }
if lib_target
  app_target.add_dependency(lib_target)
end

# Add app files to target
app_files = Dir.glob('Gentera-UI-App/**/*.swift')
app_files.each do |file|
  file_ref = main_group.find_file_by_path(file)
  unless file_ref
    file_ref = main_group.new_reference(file)
  end
  app_target.add_file_references([file_ref])
end

# Add storyboards and assets
['Gentera-UI-App/Base.lproj/Main.storyboard', 'Gentera-UI-App/Base.lproj/LaunchScreen.storyboard'].each do |file|
  file_ref = main_group.find_file_by_path(file)
  unless file_ref
    file_ref = main_group.new_reference(file)
  end
  app_target.add_file_references([file_ref])
end

# Add assets
assets = main_group.find_subpath('Gentera-UI-App/Assets.xcassets', false)
if assets
  app_target.add_resources([assets])
end

# Add Info.plist
info_plist = main_group.find_file_by_path('Gentera-UI-App/Info.plist')
unless info_plist
  info_plist = main_group.new_reference('Gentera-UI-App/Info.plist')
end

project.save

puts "✅ Target Gentera-UI-App creado exitosamente!"
