// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import Foundation

extension TuningTable {
    // Viggo Brun algorithm
    // return (numerator, denominator) approximation to generator after level iterations
    fileprivate static func brunLevel_0_1_1_0(level l: Int, generator g: Double) -> (numerator: Int, denominator: Int) {
        var zn = 0, zd = 1, infn = 1, infd = 0, fn = 0, fd = 0

        for _ in 0 ..< l {
            fn = zn + infn
            fd = zd + infd
            if g > Double(fn) / Double(fd) {
                zn = fn
                zd = fd
            } else {
                infn = fn
                infd = fd
            }
        }
        return (numerator: fn, denominator: fd)
    }

    /// Creates a "Nested 2-interval pattern", or "Moment of Symmetry"
    /// From Erv Wilson.  See http://anaphoria.com/wilsonintroMOS.html
    ///
    /// - parameter gInput: A Double on [0, 1]
    /// - parameter lInput: An Int on [0, 7]
    /// - parameter mInput: The mode of the scale...degrees are normalized by the frequency at this index
    /// - returns: Number of notes per octave
    ///
    public func momentOfSymmetry(generator gInput: Double = 7.0 / 12.0,
                                 level lInput: Int = 5,
                                 murchana mInput: Int = 0) -> Int
    {
        // CLAMP
        let g = (gInput > 1.0) ? 1.0 : ((gInput < 0) ? 0.0 : gInput)
        let l = (lInput > 7) ? 7 : ((lInput < 0) ? 0 : lInput)
        let d = TuningTable.brunLevel_0_1_1_0(level: l, generator: g)

        // NPO number of notes per octave
        let den = d.denominator
        var f = [Frequency]()
        for i in 0 ..< den {
            let p = exp2((Double(i) * g).truncatingRemainder(dividingBy: 1.0))
            f.append(Frequency(p))
        }

        // apply murchana then octave reduce
        let m = (mInput > den) ? (den - 1) : ((mInput < 0) ? 0 : mInput)
        let murchana = f[m]
        f = f.map { (frequency: Frequency) -> Frequency in
            // murchana = index of modulation == normalize by this scale degree
            var ff = frequency / murchana
            // octave reduce.  Assumes octave = 2
            while ff < 1.0 {
                ff *= 2.0
            }
            while ff >= 2.0 {
                ff /= 2.0
            }
            return ff
        }
        f.sort()

        // update tuning table
        _ = tuningTable(fromFrequencies: f)

        return den
    }

    // Examples:
    //
    // 12ET:
    // PolyphonicNode.tuningTable.momentOfSymmetry(generator: 0.583333, level: 6) -> 12

    // 9-tone scale
    // PolyphonicNode.tuningTable.momentOfSymmetry(generator: 0.238186, level: 5) -> 9

    // 9-tone scale
    // PolyphonicNode.tuningTable.momentOfSymmetry(generator: 0.264100, level: 5) -> 9
}
