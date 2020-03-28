# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace "breakpoint"

def development_pods
  pod 'Firebase/Analytics'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  pod 'Firebase/Core'
end

target 'breakpoint' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  development_pods
end

target 'core' do
  use_frameworks!
  
  project "Module/core/core"

  development_pods
end
