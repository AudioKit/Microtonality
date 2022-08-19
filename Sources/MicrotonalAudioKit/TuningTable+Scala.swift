// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import Foundation

public extension TuningTable {
    /// Use a Scala file to write the tuning table. Returns notes per octave or nil when file couldn't be read.
    func scalaFile(_ filePath: String) -> Int? {
        guard
            let contentData = FileManager.default.contents(atPath: filePath),
            let contentStr = String(data: contentData, encoding: .utf8)
        else {
            Log("can't read filePath: \(filePath)")
            return nil
        }

        let scalaFrequencies = frequencies(fromScalaString: contentStr)
        let npo = tuningTable(fromFrequencies: scalaFrequencies)
        return npo
    }

    fileprivate func stringTrimmedForLeadingAndTrailingWhiteSpacesFromString(_ inputString: String?) -> String? {
        guard let string = inputString else {
            return nil
        }

        let leadingTrailingWhiteSpacesPattern = "(?:^\\s+)|(?:\\s+$)"
        let regex: NSRegularExpression

        do {
            try regex = NSRegularExpression(pattern: leadingTrailingWhiteSpacesPattern,
                                            options: .caseInsensitive)
        } catch let error as NSError {
            Log("ERROR: create regex: \(error)")
            return nil
        }

        let stringRange = NSRange(location: 0, length: string.count)
        let trimmedString = regex.stringByReplacingMatches(in: string,
                                                           options: .reportProgress,
                                                           range: stringRange,
                                                           withTemplate: "$1")

        return trimmedString
    }

    /// Get frequencies from a Scala string
    func frequencies(fromScalaString rawStr: String?) -> [Frequency] {
        guard let inputStr = rawStr else {
            return []
        }

        // default return value is [1.0]
        var scalaFrequencies = [Frequency(1)]
        var actualFrequencyCount = 1
        var frequencyCount = 1

        var parsedScala = true
        var parsedFirstCommentLine = false
        let values = inputStr.components(separatedBy: .newlines)
        var parsedFirstNonCommentLine = false
        var parsedAllFrequencies = false

        // REGEX match for a cents or ratio
        //              (RATIO      |CENTS                                  )
        //              (  a   /  b |-   a   .  b |-   .  b |-   a   .|-   a )
        let regexStr = "(\\d+\\/\\d+|-?\\d+\\.\\d+|-?\\.\\d+|-?\\d+\\.|-?\\d+)"
        let regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: regexStr,
                                            options: .caseInsensitive)
        } catch let error as NSError {
            Log("ERROR: cannot parse scala file: \(error)")
            return scalaFrequencies
        }

        for rawLineStr in values {
            var lineStr = stringTrimmedForLeadingAndTrailingWhiteSpacesFromString(rawLineStr) ?? rawLineStr

            if lineStr.isEmpty { continue }

            if lineStr.hasPrefix("!") {
                if !parsedFirstCommentLine {
                    parsedFirstCommentLine = true
                    #if false
                        // currently not using the scala file name embedded in the file
                        let components = lineStr.components(separatedBy: "!")
                        if components.count > 1 {
                            proposedScalaFilename = components[1]
                        }
                    #endif
                }
                continue
            }

            if !parsedFirstNonCommentLine {
                parsedFirstNonCommentLine = true
                #if false
                    // currently not using the scala short description embedded in the file
                    scalaShortDescription = lineStr
                #endif
                continue
            }

            if parsedFirstNonCommentLine, !parsedAllFrequencies {
                if let newFrequencyCount = Int(lineStr) {
                    frequencyCount = newFrequencyCount
                    if frequencyCount == 0 || frequencyCount > 127 {
                        // #warning SPEC SAYS 0 notes is okay because 1/1 is implicit
                        Log("ERROR: number of notes in scala file: \(frequencyCount)")
                        parsedScala = false
                        break
                    } else {
                        parsedAllFrequencies = true
                        continue
                    }
                }
            }

            if actualFrequencyCount > frequencyCount {
                Log("actual frequency cont: \(actualFrequencyCount) > frequency count: \(frequencyCount)")
            }

            /* The first note of 1/1 or 0.0 cents is implicit and not in the files.*/

            // REGEX defined above this loop
            let rangeOfFirstMatch = regex.rangeOfFirstMatch(
                in: lineStr,
                options: .anchored,
                range: NSRange(location: 0, length: lineStr.count)
            )

            if NSEqualRanges(rangeOfFirstMatch, NSRange(location: NSNotFound, length: 0)) == false {
                let nsLineStr = lineStr as NSString?
                let substringForFirstMatch = nsLineStr?.substring(with: rangeOfFirstMatch) as NSString? ?? ""
                if substringForFirstMatch.range(of: ".").length != 0 {
                    if var scaleDegree = Frequency(lineStr) {
                        // ignore 0.0...same as 1.0, 2.0, etc.
                        if scaleDegree != 0 {
                            scaleDegree = fabs(scaleDegree)
                            // convert from cents to frequency
                            scaleDegree /= 1200
                            scaleDegree = pow(2, scaleDegree)
                            scalaFrequencies.append(scaleDegree)
                            actualFrequencyCount += 1
                            continue
                        }
                    }
                } else {
                    if substringForFirstMatch.range(of: "/").length != 0 {
                        if substringForFirstMatch.range(of: "-").length != 0 {
                            Log("ERROR: invalid ratio: \(substringForFirstMatch)")
                            parsedScala = false
                            break
                        }
                        // Parse rational numerator/denominator
                        let slashPos = substringForFirstMatch.range(of: "/")
                        let numeratorStr = substringForFirstMatch.substring(to: slashPos.location)
                        let numerator = Int(numeratorStr) ?? 0
                        let denominatorStr = substringForFirstMatch.substring(from: slashPos.location + 1)
                        let denominator = Int(denominatorStr) ?? 0
                        if denominator == 0 {
                            Log("ERROR: invalid ratio: \(substringForFirstMatch)")
                            parsedScala = false
                            break
                        } else {
                            let mt = Frequency(numerator) / Frequency(denominator)
                            if mt == 1.0 || mt == 2.0 {
                                // skip 1/1, 2/1
                                continue
                            } else {
                                scalaFrequencies.append(mt)
                                actualFrequencyCount += 1
                                continue
                            }
                        }
                    } else {
                        // a whole number, treated as a rational with a denominator of 1
                        if let whole = Int(substringForFirstMatch as String) {
                            if whole <= 0 {
                                Log("ERROR: invalid ratio: \(substringForFirstMatch)")
                                parsedScala = false
                                break
                            } else if whole == 1 || whole == 2 {
                                // skip degrees of 1 or 2
                                continue
                            } else {
                                scalaFrequencies.append(Frequency(whole))
                                actualFrequencyCount += 1
                                continue
                            }
                        }
                    }
                }
            } else {
                Log("ERROR: error parsing: \(lineStr)")
                continue
            }
        }

        if !parsedScala {
            Log("FATAL ERROR: cannot parse Scala file")
            return []
        }

        Log("frequencies: \(scalaFrequencies)")
        return scalaFrequencies
    }
}
