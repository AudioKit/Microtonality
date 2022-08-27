<div align=center>
<img src="https://github.com/AudioKit/Microtonality/blob/main/images/synthone.jpg"/>
 
# Microtonality

[![Build Status](https://github.com/AudioKit/Microtonality/workflows/CI/badge.svg)](https://github.com/AudioKit/Microtonality/actions?query=workflow%3ACI)
[![License](https://img.shields.io/github/license/AudioKit/Microtonality)](https://github.com/AudioKit/Microtonality/blob/main/LICENSE)
    [![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)
[![Twitter Follow](https://img.shields.io/twitter/follow/AudioKitPro.svg?style=social)](https://twitter.com/AudioKitPro)

 </div>

Tuning tables developed by Marcus Hobbs and used in the AudioKit Synth One iOS app.

## Installation in Xcode 13

You can AudioKit and any of the other AudioKit libraries using Collections

1. Select File -> Add Packages...
2. Click the `+` icon on the bottom left of the Collections sidebar on the left.
3. Choose `Add Swift Package Collection` from the pop-up menu.
4. In the `Add Package Collection` dialog box, enter `https://swiftpackageindex.com/AudioKit/collection.json` as the URL and click the "Load" button.
5. It will warn you that the collection is not signed, but it is fine, click "Add Unsigned Collection".
6. Now you can add any of the AudioKit Swift Packages you need and read about what they do, right from within Xcode.

## Documentation

  - [TuningTableETNN](https://audiokit.io/Microtonality/documentation/microtonality/tuningtableetnn):
    helper object to simulate a Swift tuple for ObjC interoperability
  - [TuningTableDelta12ET](https://audiokit.io/Microtonality/documentation/microtonality/tuningtabledelta12et):
    helper object to simulate a Swift tuple for ObjC interoperability
  - [TuningTable](https://audiokit.io/Microtonality/documentation/microtonality/tuningtable):
    TuningTable provides high-level methods to create musically useful tuning tables
  - [TuningTableBase](https://audiokit.io/Microtonality/documentation/microtonality/tuningtablebase):
    TuningTableBase provides low-level methods for creating
    arbitrary mappings of midi note numbers to musical frequencies
    The default behavior is "12-tone equal temperament" so
    we can integrate in non-microtonal settings with backwards compatibility
