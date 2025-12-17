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
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
