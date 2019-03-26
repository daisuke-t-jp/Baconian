# Task
## Goal
- App can get system load.
- User can watch system load on view.

## Load info
### Mach Layer
#### Host
- [x] Virtual Memory(MachHostVMStatics)
  - Free size
  - Active size
  - Inactive size
  - Wire size
- [x] Physical Memory(MachHostBasicInfo)
  - Physical size
- [x] CPU(MachHostCPULoadInfo)
  - User time
  - System time
  - Idle time
  - Nice time
- [x] Processors(MachHostProcessorInfo) 
  - CPU load per core
#### Task
- [x] Memory(MachTaskBasicInfo)
  - Resident size
- [x] CPU(MachTaskThreadBasicInfo)
  - Usage percent
  - Time
- [x] Thread(MachTaskThreadBasicInfo)
  - Thread state and num

### Report Layer
#### OS
- [x] Memory(ReportOSMemory)
  - Physical size
  - Used size
  - Unused size
  - Free size
  - Active size
  - Inactive size
  - Wire size
- [x] CPU(ReportOSCPU)
  - User usage percent
  - System usage percent
  - Idle usage percent
- [x] Processors(ReportOSProcessors)
  - CPU load per core
#### Process
- [x] Memory(ReportProcessMemory)
  - Resident size
- [x] CPU(ReportProcessCPU)
  - Usage percent
  - time
- [x] Processors(ReportProcessThread)
  - Total num
  - Busy num
  - Idle num

## TODO
### General
  - Swift 5
  - Framework(iOS)
### Reporter
  - Immediate get data
  - High load delegate
    - OS Low memory
    - OS CPU High load
    - Process Memory High
    - Process CPU High load
### UI
  - Reporter View
### Tester
  - Mac GUI
  - iOS GUI
### Demo
  - podspec
  - macOS
  - iOS
### Facility
  - Documentation comments
  - README
  - jazzy
