source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

def depend_pods
    pod 'Mach-Swift','~> 1.0.3'
end

target 'Baconian-macOS' do
    platform :osx, '10.12'
    depend_pods

    target 'BaconianTests-macOS' do
        inherit! :search_paths
        depend_pods
    end
end

target 'Baconian-iOS' do
    platform :ios, '10.0'
    depend_pods

    target 'BaconianTests-iOS' do
        inherit! :search_paths
        depend_pods
    end
end
