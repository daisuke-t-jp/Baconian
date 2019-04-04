Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name         = "SysInfo"
  spec.version      = "1.0.0"
  spec.summary      = "System information reporter in Swift."

  spec.description  = <<-DESC
                   System information reporter in Swift.
                   The reporter provide CPU load and memory pressure information.
                   DESC

  spec.homepage     = "https://github.com/daisuke-t-jp/SysInfo"
  # spec.screenshots  = "https://raw.githubusercontent.com/daisuke-t-jp/SysInfo/master/images/header.png"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author       = { "daisuke-t-jp" => "daisuke.t.jp@gmail.com" }


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.ios.deployment_target = "10.0"
  spec.osx.deployment_target = "10.12"
  # spec.tvos.deployment_target = "12.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source       = { :git => "https://github.com/daisuke-t-jp/SysInfo.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files  = "SysInfo/**/*.{swift}"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.swift_version = "5.0"
  spec.requires_arc = true

end
