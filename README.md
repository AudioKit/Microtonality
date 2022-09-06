<div align=center>

# Microtonality

[![Build Status](https://github.com/AudioKit/Microtonality/workflows/CI/badge.svg)](https://github.com/AudioKit/Microtonality/actions?query=workflow%3ACI)
[![License](https://img.shields.io/github/license/AudioKit/Microtonality)](https://github.com/AudioKit/Microtonality/blob/main/LICENSE)
    [![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)
[![Twitter Follow](https://img.shields.io/twitter/follow/AudioKitPro.svg?style=social)](https://twitter.com/AudioKitPro)

https://user-images.githubusercontent.com/13122/188533099-b09ced85-089c-4a86-8313-46c7d97819c9.mov
 
 </div>

Tuning tables developed by Marcus Hobbs and used in the AudioKit Synth One iOS app.

## Installation

Install with Swift Package Manager.

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
