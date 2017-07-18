//
//  AnnotationParser.swift
//  xproj
//
//  Created by Jin Hyong Park on 13/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//
import Foundation

internal struct AnnotationParser {
    internal static func generateDataFromAnnotation( value : [String] ) -> [String]? {
        let whole = value.joined(separator: "").components(separatedBy: " ")
        
        if whole.contains("Begin") {
            return ["___" + whole[2] + "___", "=", "{"]
        } else if whole.contains("End") {
            return ["}", ";"]
        } else {
            return nil
        }
    }
    internal static func parseAnnotations( string : String ) -> [NSTextCheckingResult]? {
        let regex = try? NSRegularExpression(pattern: "\\/\\* Begin [a-zA-Z]{1,} section \\/\\*", options: NSRegularExpression.Options.useUnixLineSeparators)
        
        let matches = regex?.matches(in: string, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: string.characters.count) )
        return matches
    }
}

internal struct DICTIONARY {
    
}
