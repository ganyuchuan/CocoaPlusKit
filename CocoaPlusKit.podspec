Pod::Spec.new do |s|

  s.name         = "CocoaPlusKit"
  s.version      = "1.0.0"
  s.summary      = "A collection of CocoaTouch framework categories"
  s.homepage     = "https://github.com/ganyuchuan/CocoaPlusKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "ganyuchuan" => "ganyuchuan@huxiu.com" }

  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/ganyuchuan/CocoaPlusKit.git", :tag => "#{s.version}" }
  s.source_files  = "Framework/**/*.{h,m}"
  s.public_header_files = "Framework/**/*.h"

  s.frameworks = "Foundation", "UIKit", "CoreGraphics"
  s.requires_arc = true

end
