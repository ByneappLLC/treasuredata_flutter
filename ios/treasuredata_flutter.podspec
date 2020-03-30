#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint treasuredata_flutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'treasuredata_flutter'
  s.version          = '1.0.0'
  s.summary          = 'A wrapper for TreasureData SDK.'
  s.description      = 'A wrapper for TreasureData SDK.'
  s.homepage         = 'https://www.treasuredata.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Edgar' => 'edgar@byneapp.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency = 'TreasureData-iOS-SDK', '0.4.0'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
