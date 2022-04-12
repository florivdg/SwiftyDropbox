Pod::Spec.new do |s|
  s.name         = 'SwiftyDropbox'
  s.version      = '8.2.1'
  s.summary      = 'Dropbox Swift SDK for API v2'
  s.homepage     = 'https://dropbox.com/developers/'
  s.license      = 'MIT'
  s.author       = { 'Stephen Cobbe' => 'scobbe@dropbox.com' }
  s.source       = { :git => 'https://github.com/dropbox/SwiftyDropbox.git', :tag => s.version }

  s.source_files = 'Source/SwiftyDropbox/Shared/**/*.{swift,h,m}'
  s.osx.source_files = 'Source/SwiftyDropbox/Platform/SwiftyDropbox_macOS/**/*.{swift,h,m}'
  s.ios.source_files = 'Source/SwiftyDropbox/Platform/SwiftyDropbox_iOS/**/*.{swift,h,m}'
  s.tvos.source_files = 'Source/SwiftyDropbox/SwiftyDropbox/SwiftyDropbox.h', 'Source/SwiftyDropbox/PlatformNeutral/*.{h,m,swift}', 'Source/SwiftyDropbox/PlatformDependent/tvOS/*.{h,m,swift}'

  s.requires_arc = true
  s.swift_version = '5.1'

  s.osx.deployment_target = '10.12'
  s.ios.deployment_target = '10.0'
  s.tvos.deployment_target = '14.0'

  s.osx.frameworks = 'AppKit', 'WebKit', 'SystemConfiguration', 'Foundation'
  s.ios.frameworks = 'UIKit', 'WebKit', 'SystemConfiguration', 'Foundation'
  s.tvos.frameworks = 'Foundation'

  s.dependency       'Alamofire', '~> 5.4.3'
end
