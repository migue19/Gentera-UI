# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
platform :ios, '13.0'

target 'Gentera-UI' do
  use_frameworks!
  pod 'lottie-ios'
  
  target 'Gentera-UITests' do
    # Tests
  end
end

target 'Gentera-UI-App' do
  use_frameworks!
  pod 'lottie-ios'
  
  # Post install to fix framework copying issues
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SKIP_INSTALL'] = 'NO'
      end
    end
  end
end
