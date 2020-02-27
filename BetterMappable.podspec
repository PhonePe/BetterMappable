Pod::Spec.new do |s|
  s.name             = 'BetterMappable'
  s.version          = '1.0.1'
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.summary          = 'Better Mappable through Property Wrappers'
  s.homepage         = 'https://github.com/PhonePe/BetterMappable'
  s.author           = { 'Srikanth KV' => 'srikanth.gundaz@gmail.com' }
  s.source           = { :git => 'https://github.com/PhonePe/BetterMappable.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.watchos.deployment_target = '3.0'
  s.tvos.deployment_target = '10.0'
  
  s.swift_version = '5.0'
  
  s.source_files = 'Source/*.swift'
  
  s.dependency 'ObjectMapper', '~> 3.5.1'
end
