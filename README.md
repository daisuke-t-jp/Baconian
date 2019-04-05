# Baconian
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20-blue.svg)
[![Language Swift%205.0](https://img.shields.io/badge/Language-Swift%205.0-orange.svg)](https://developer.apple.com/swift)
[![Build Status](https://travis-ci.org/daisuke-t-jp/Baconian.svg?branch=master)](https://travis-ci.org/daisuke-t-jp/Baconian)


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
- [ ] TODO


## Usage
### Import framework
```swift
import Baconian
```

### Reporter class

#### 1. Adopt ReporterDelegate protocol
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
	// OS load
	print(data.osMemory)  // Memory load
	print(data.osCPU)     // CPU load
	print(data.osProcessors)  // Processors load

	// Process(App) load
	print(data.processMemory) // Memory load
	print(data.processCPU)    // CPU load
	print(data.processThread) // Thread Information
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
