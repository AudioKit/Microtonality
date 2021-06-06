# Microtonal Tuning Tables for AudioKit

[![Build Status](https://github.com/AudioKit/MicrotonalAudioKit/workflows/CI/badge.svg)](https://github.com/AudioKit/MicrotonalAudioKit/actions?query=workflow%3ACI)
[![License](https://img.shields.io/github/license/AudioKit/MicrotonalAudioKit)](https://github.com/AudioKit/MicrotonalAudioKit/blob/main/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/AudioKit)](https://github.com/AudioKit/AudioKit/wiki)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)
[![Twitter Follow](https://img.shields.io/twitter/follow/AudioKitPro.svg?style=social)](https://twitter.com/AudioKitPro)

These tuning tables were developed by Marcus Hobbs and used in the AudioKit Synth One iOS app.

## Installation via Swift Package Manager

To add MicrotonalAudioKit to your Xcode project, select File -> Swift Packages -> Add Package Depedancy. Enter `https://github.com/AudioKit/MicrotonalAudioKit` for the URL. 


## Documentation

  - [TuningTableETNN](https://github.com/AudioKit/MicrotonalAudioKit/wiki//TuningTableETNN):
    helper object to simulate a Swift tuple for ObjC interoperability
  - [TuningTableDelta12ET](https://github.com/AudioKit/MicrotonalAudioKit/wiki//TuningTableDelta12ET):
    helper object to simulate a Swift tuple for ObjC interoperability
  - [TuningTable](https://github.com/AudioKit/MicrotonalAudioKit/wiki//TuningTable):
    TuningTable provides high-level methods to create musically useful tuning tables
  - [TuningTableBase](https://github.com/AudioKit/MicrotonalAudioKit/wiki//TuningTableBase):
    TuningTableBase provides low-level methods for creating
    arbitrary mappings of midi note numbers to musical frequencies
    The default behavior is "12-tone equal temperament" so
    we can integrate in non-microtonal settings with backwards compatibility
