def depend_pods
    pod 'Mach-Swift', '1.0.2'
end

target 'Baconian-macOS' do
    platform :osx, '10.12'
    use_frameworks!
    depend_pods

    target 'BaconianTests-macOS' do
        inherit! :search_paths
        use_frameworks!
        depend_pods
    end
end

target 'Baconian-iOS' do
    platform :ios, '10.0'
    use_frameworks!
    depend_pods

    target 'BaconianTests-iOS' do
        inherit! :search_paths
        use_frameworks!
        depend_pods
    end
end