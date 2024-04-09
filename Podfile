# Uncomment the next line to define a global platform for your project
platform :ios, '17.0'

target 'GrotonApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Secrets

end

plugin 'cocoapods-keys', {
  #change for app title
  :project => "org.groton.GrotonApp",
  :keys => [
    "clientID",
    "clientSecret",
    "redirectURI",
    "subscriptionAccessKey"
  ]}

# reset the `Keys` target to ios 17.0
keys_pod_names = ['Keys']
post_install do |installer_representation|
  targets = installer_representation.pods_project.targets.select { |target|
    keys_pod_names.select { |name|
      target.display_name.eql? name
    }.count > 0
  }
  targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
    end
  end
end
