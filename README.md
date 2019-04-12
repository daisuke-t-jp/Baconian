# Baconian
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20-blue.svg)
[![Language Swift%205.0](https://img.shields.io/badge/Language-Swift%205.0-orange.svg)](https://developer.apple.com/swift)
[![Build Status](https://travis-ci.org/daisuke-t-jp/Baconian.svg?branch=master)](https://travis-ci.org/daisuke-t-jp/Baconian)
[![Cocoapods](https://img.shields.io/cocoapods/v/Baconian.svg)](https://cocoapods.org/pods/Baconian)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-green.svg)](https://github.com/Carthage/Carthage)


<img src="https://raw.githubusercontent.com/daisuke-t-jp/Baconian/master/images/DemoMovie-iOS.gif" width="400">  
<img src="https://raw.githubusercontent.com/daisuke-t-jp/Baconian/master/images/DemoMovie-macOS.gif" width="600">  

## Introduction

**Baconian** is system information reporter framework in Swift.  
The reporter([Reporter](https://github.com/daisuke-t-jp/Baconian/blob/master/Baconian/Reporter/Reporter.swift)) provides the following information.  

- [x] OS Memory pressure
- [x] OS CPU load
- [x] OS Processors load
- [x] App Memory pressure
- [x] App CPU load
- [x] App Thread Information

And you can also see the load graphically by the view.([ReporterCompactView](https://github.com/daisuke-t-jp/Baconian/blob/master/Baconian/UI/ReporterCompactView/ReporterCompactView.swift))

<img src="https://raw.githubusercontent.com/daisuke-t-jp/Baconian/master/images/ReporterCompactView.png" width="300">  

Table of View's symbol meaning.  

|Symbol|Meaning|
|:---|:---|
| 🍎 | OS load line |
| 🍏 | Process(App) load line |
| 🐏 | Memory usage. 🐏 is RAM(U+1F40F) |
| 🤖 | CPU usage(0 - 100%) |

## Requirements
- Platforms
  - iOS 10.0+
  - macOS 10.12+
- Swift 5.0


## Installation
### Carthage
```
github "daisuke-t-jp/Baconian"
```

### CocoaPods
```
use_frameworks!

target 'target' do
pod 'Baconian'
end
```


## Usage
### Import framework
```swift
import Baconian
```

### Reporter class

#### 1. Confirm ReporterDelegate protocol
```swift
class ViewController: ReporterDelegate {
```

#### 2. Setup and start reporter
```swift
let reporter = Reporter()
reporter.delegate = self
reporter.start()
```

#### 3. Implement delegate
```swift
func reporter(_ manager: Reporter, didUpdate data: Reporter.Data) {
    print("# Report")
    
    print("## OS")
    print("### Memory")
    print("- physicalSize: \(data.osMemory.physicalSize.memoryByteFormatString)")
    print("- freeSize: \(data.osMemory.freeSize.memoryByteFormatString)")
    print("- inactiveSize: \(data.osMemory.inactiveSize.memoryByteFormatString)")
    print("- wireSize: \(data.osMemory.wireSize.memoryByteFormatString)")
    print("- usedSize: \(data.osMemory.usedSize.memoryByteFormatString)")
    print("- unusedSize: \(data.osMemory.unusedSize.memoryByteFormatString)")
    print("")
    
    print("### CPU")
    print(String.init(format: "- userUsage: %.2f", data.osCPU.userUsage))
    print(String.init(format: "- systemUsage: %.2f", data.osCPU.systemUsage))
    print(String.init(format: "- idleUsage: %.2f", data.osCPU.idleUsage))
    print(String.init(format: "- niceUsage: %.2f", data.osCPU.niceUsage))
    print(String.init(format: "- usage: %.2f", data.osCPU.usage))
    print("")
    
    print("### Processors")
    for i in 0..<data.osProcessors.count {
        print("- Core No.\(i)")
        print(String.init(format: "    - userUsage: %.2f", data.osCPU.userUsage))
        print(String.init(format: "    - systemUsage: %.2f", data.osCPU.systemUsage))
        print(String.init(format: "    - idleUsage: %.2f", data.osCPU.idleUsage))
        print(String.init(format: "    - niceUsage: %.2f", data.osCPU.niceUsage))
        print(String.init(format: "    - usage: %.2f", data.osCPU.usage))
        print("")
    }
    
    
    print("## Process")
    print("### Memory")
    print("- residentSize: \(data.processMemory.residentSize.memoryByteFormatString)")
    print("")
    
    print("### CPU")
    print(String.init(format: "- usage: %.2f", data.processCPU.usage))
    print(String.init(format: "- time: %.2f", data.processCPU.time))
    print("")
    
    print("### Thread")
    print("- totalNum: \(data.processThread.totalNum)")
    print("- busyNum: \(data.processThread.busyNum)")
    print("- idleNum: \(data.processThread.idleNum)")
    print("")
}
```

#### 4. Stop reporter
```swift
reporter.stop()
```


### ReporterCompactView class
#### Add ReporterCompactView by Programmatically
```swift
let reporterView = ReporterCompactView(frame: CrossPlatformRect(x: 0, 
                                                                y: 0, 
                                                            width: ReporterCompactView.xibWidth,
                                                            height: ReporterCompactView.xibHeight))

self.view.addSubview(reporterView)
```

#### Add ReporterCompactView by Interface Builder
##### 1. Set UIView's custom class to ReporterCompactView
<img src="https://raw.githubusercontent.com/daisuke-t-jp/Baconian/master/images/ReporterCompactView_Add_Storyboard.png" width="700">  


##### 2. Set ReporterCompactView frame
<img src="https://raw.githubusercontent.com/daisuke-t-jp/Baconian/master/images/ReporterCompactView_Add_Storyboard-2.png" width="300">  

Width is 260 and Height is 50.


## Demo
There are demos.
- [iOS](https://github.com/daisuke-t-jp/Baconian/tree/master/demo/BaconianDemo-iOS) 
- [macOS](https://github.com/daisuke-t-jp/Baconian/tree/master/demo/BaconianDemo-macOS) 
