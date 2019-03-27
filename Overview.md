# Overview
## Goal
- App can get system load.
- User can watch system load on view.

## Platforms
- [x] Swift 5
- [ ] macOS
- [ ] iOS

## Function
- [ ] macOS Framework
- [ ] macOS UI(View)
- [ ] iOS Framework
- [ ] iOS UI(View)

## Load info
### Mach Layer
#### Host
- [x] Virtual Memory(Mach.Host.VMStatics)
  - Free size
  - Active size
  - Inactive size
  - Wire size
- [x] Physical Memory(Mach.Host.BasicInfo)
  - Physical size
- [x] CPU(Mach.Host.CPULoadInfo)
  - User time
  - System time
  - Idle time
  - Nice time
- [x] Processors(Mach.Host.ProcessorInfo) 
  - CPU load per core
#### Task
- [x] Memory(Mach.Task.BasicInfo)
  - Resident size
- [x] CPU(Mach.Task.ThreadBasicInfo)
  - Usage percent
  - Time
- [x] Thread(Mach.Task.ThreadBasicInfo)
  - Thread state and num

### Report Layer
#### OS
- [x] Memory(Report.OS.Memory)
  - Physical size
  - Used size
  - Unused size
  - Free size
  - Active size
  - Inactive size
  - Wire size
- [x] CPU(Report.OS.CPU)
  - User usage percent
  - System usage percent
  - Idle usage percent
- [x] Processors(Report.OS.Processors)
  - CPU load per core
#### Process
- [x] Memory(Report.Process.Memory)
  - Resident size
- [x] CPU(Report.Process.CPU)
  - Usage percent
  - time
- [x] Processors(Report.Process.Thread)
  - Total num
  - Busy num
  - Idle num

## TODO
### General
  - Framework(iOS)
### Reporter
  - OS version
  - Device type
### UI
  - Reporter View(mac OS)
  - Reporter View(iOS)
### Tester
  - macOS GUI
  - iOS GUI
### Demo
  - podspec
  - macOS
  - iOS
### Facility
  - Documentation comments
  - README
  - jazzy

## Day2
### Reporter
  - Immediate get data
  - High load delegate
    - OS Low memory
    - OS CPU High load
    - Process Memory High
    - Process CPU High load
