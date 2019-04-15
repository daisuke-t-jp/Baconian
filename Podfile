use_frameworks!

def depend_pods
    pod 'Mach-Swift', :git => 'https://github.com/daisuke-t-jp/Mach-Swift.git'
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
