  
Pod::Spec.new do |s|

 s.name = "Helpers"
 s.version = "0.0.4"
 s.summary = "Helpers Framework"
 s.description = "Framework with helpers objects"
 s.homepage = "https://github.com/crisbarril/Helpers"
 s.license = { :type => 'MIT', :file => 'LICENSE' }
 s.platform = :ios, '11.0'
 s.author = { "Cristian Barril" => "crisbarril@hotmail.com" }
 s.swift_version = '4.0'
 
 # Platforms
 s.ios.deployment_target = '10.0'
 s.watchos.deployment_target = '4.0'

 # Source
 s.source = { :git => "https://github.com/crisbarril/Helpers.git", :tag => s.version }

 s.default_subspecs = 'Full'

 s.subspec 'Full' do |ss|
  ss.dependency 'Helpers/Error'
  ss.dependency 'Helpers/Style'
  ss.dependency 'Helpers/Utility'
  ss.dependency 'Helpers/Device'
 end

 s.subspec 'Error' do |ss|
  ss.source_files  = "Helpers/MultiPlatform/Error/**/*.swift"
 end

 s.subspec 'Style' do |ss|
  ss.dependency 'Helpers/Utility'
  ss.source_files  = "Helpers/MultiPlatform/Style/**/*.swift"
  ss.resources = "Helpers/MultiPlatform/Style/**/*.json"
 end

 s.subspec 'Utility' do |ss|
  ss.dependency 'Helpers/Error'
  ss.source_files  = "Helpers/MultiPlatform/Utility/**/*.swift"
 end

s.subspec 'Device' do |ss|
  ss.source_files  = "Helpers/MultiPlatform/Device/**/*.swift"
  ss.ios.source_files  = "Helpers/iOS/Device/**/*.swift"
  ss.watchos.source_files  = "Helpers/watchOS/Device/**/*.swift"
 end

end