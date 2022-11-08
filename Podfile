# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'Gapo-Login' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Gapo-Login
pod 'Alamofire'
pod 'SDWebImage', :modular_headers => true
pod 'ObjectMapper'
pod 'RxSwift'
pod 'RxCocoa'
pod 'PureLayout'
pod 'Action'
  target 'Gapo-LoginTests' do
    inherit! :search_paths
    # Pods for testing
  end
  target 'Gapo-LoginUITests' do
    # Pods for testing
  end
end

post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      config.build_settings['SWIFT_VERSION'] = '5'
    end
  end
end
