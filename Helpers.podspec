  
Pod::Spec.new do |s|

 s.name = "Helpers"
 s.version = "0.0.2"
 s.summary = "Helpers Framework"
 s.description = "Framework with helpers objects"
 s.homepage = "https://github.com/crisbarril/Helpers"
 s.license = { :type => 'MIT', :file => 'LICENSE' }
 s.platform = :ios, '11.0'
 s.author = { "Cristian Barril" => "crisbarril@hotmail.com" }
 s.swift_version = '4.0'
 
 s.source = { :git => "https://github.com/crisbarril/Helpers.git", :tag => s.version }

 s.default_subspecs = 'Full'

 s.subspec 'Full' do |ss|
  ss.dependency 'Helpers/Error'
  ss.dependency 'Helpers/Style'
  ss.dependency 'Helpers/Utility'
 end

 s.subspec 'Error' do |ss|
  ss.source_files  = "Helpers/Error/**/*.swift"
 end

 s.subspec 'Style' do |ss|
  ss.dependency 'Helpers/Utility'
  ss.source_files  = "Helpers/Style/**/*.swift"
  ss.resources = "Helpers/Style/**/*.json"
 end

 s.subspec 'Utility' do |ss|
  ss.dependency 'Helpers/Error'
  ss.source_files  = "Helpers/Utility/**/*.swift"
 end

end