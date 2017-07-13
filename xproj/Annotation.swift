//
//  AnnotationParser.swift
//  xproj
//
//  Created by Jin Hyong Park on 13/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//
import Foundation

internal struct AnnotationParser {
    internal static func parseAnnotations( string : String ) -> [NSTextCheckingResult]? {
//        let regex = try? NSRegularExpression(pattern: "\\/\\* Begin [a-zA-Z]{1,} section \\/\\*", options: NSRegularExpression.Options.useUnixLineSeparators)
        
        let regex = try? NSRegularExpression(pattern: "Begin", options: NSRegularExpression.Options.anchorsMatchLines)
        
        let matches = regex?.matches(in: string, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: string.characters.count) )
        return matches
    }
    
//    func matches(for regex: String, in text: String) -> [String] {
//        
//        do {
//            let regex = try NSRegularExpression(pattern: regex)
//            let results = regex.matches(in: text,
//                                        range: NSRange(text.startIndex..., in: text))
//            return results.map {
//                text.substring(with: Range($0.range, in: text)!)
//            }
//        } catch let error {
//            print("invalid regex: \(error.localizedDescription)")
//            return []
//        }
//    }
    
}
