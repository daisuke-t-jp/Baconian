Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name         = "SysInfo"
  spec.version      = "1.0.0"
  spec.summary      = "System info reporter."

  spec.description  = <<-DESC
                   System info reporter framework in Swift.
                   DESC

  spec.homepage     = "https://github.com/daisuke-t-jp/SysInfo"
  spec.screenshots  = "https://raw.githubusercontent.com/daisuke-t-jp/SysInfo/master/images/header.png"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author       = { "daisuke-t-jp" => "daisuke.t.jp@gmail.com" }


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.osx.deployment_target = "10.12"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source       = { :git => "https://github.com/daisuke-t-jp/SysInfo.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files = 'SysInfo/Extension/*.{swift}', 'SysInfo/Mach/*.{swift}', 'SysInfo/SysInfoReporter/*.{swift}'


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.swift_version = "4.2"
  spec.requires_arc = true

end
