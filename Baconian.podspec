Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name         = "Baconian"
  spec.version      = "1.0.0"
  spec.summary      = "System information reporter in Swift."
  spec.description  = <<-DESC
                   **Baconian** is system information reporter framework in Swift.  
                   The reporter provides memory pressure and cpu load.  
                   DESC

  spec.homepage     = "https://github.com/daisuke-t-jp/Baconian"
  spec.screenshots  = "https://raw.githubusercontent.com/daisuke-t-jp/Baconian/master/images/DemoMovie-iOS.gif", "https://raw.githubusercontent.com/daisuke-t-jp/Baconian/master/images/DemoMovie-macOS.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author       = { "daisuke-t-jp" => "daisuke.t.jp@gmail.com" }


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.ios.deployment_target = "10.0"
  spec.osx.deployment_target = "10.12"
  # spec.tvos.deployment_target = "12.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source       = { :git => "https://github.com/daisuke-t-jp/Baconian.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files  = "Baconian/**/*.{swift}"


  # ――― Resource ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.ios.resources = "Baconian/UI/ReporterCompactView/iOS/*.{xib}"
  spec.osx.resources = "Baconian/UI/ReporterCompactView/macOS/*.{xib}"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.swift_version = "5.0"
  spec.requires_arc = true
  spec.ios.framework = 'UIKit'
  spec.osx.framework = 'AppKit'

end
