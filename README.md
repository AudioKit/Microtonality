<div align=center>
<img src="https://github.com/AudioKit/MicrotonalAudioKit/blob/main/images/synthone.jpg"/>
 
# Microtonal Tuning Tables for AudioKit

[![Build Status](https://github.com/AudioKit/MicrotonalAudioKit/workflows/CI/badge.svg)](https://github.com/AudioKit/MicrotonalAudioKit/actions?query=workflow%3ACI)
[![License](https://img.shields.io/github/license/AudioKit/MicrotonalAudioKit)](https://github.com/AudioKit/MicrotonalAudioKit/blob/main/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/AudioKit)](https://github.com/AudioKit/AudioKit/wiki)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)
[![Twitter Follow](https://img.shields.io/twitter/follow/AudioKitPro.svg?style=social)](https://twitter.com/AudioKitPro)

 </div>

These tuning tables were developed by Marcus Hobbs and used in the AudioKit Synth One iOS app.

## Installation in Xcode 13

You can AudioKit and any of the other AudioKit libraries using Collections

1. Select File -> Add Packages...
2. Click the `+` icon on the bottom left of the Collections sidebar on the left.
3. Choose `Add Swift Package Collection` from the pop-up menu.
4. In the `Add Package Collection` dialog box, enter `https://swiftpackageindex.com/AudioKit/collection.json` as the URL and click the "Load" button.
5. It will warn you that the collection is not signed, but it is fine, click "Add Unsigned Collection".
6. Now you can add any of the AudioKit Swift Packages you need and read about what they do, right from within Xcode.

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
