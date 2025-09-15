platform :ios, '14.0'
use_frameworks!

target 'Finances' do
  # Pods for Finances
  pod 'Firebase/Auth'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # Força todos os pods a usar no mínimo iOS 14.0
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end