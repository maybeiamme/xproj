//
//  main.swift
//  xproj
//
//  Created by Jin Hyong Park on 13/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Foundation

print("Hello, World!")

//struct File {
//    static func read( path : String, encoding : String.Encoding = String.Encoding.utf8 ) -> String? {
//        
//    }
//}

struct SectionAnnotation: Hashable {
    var key : String
    var hashValue: Int { return key.hashValue }
    var contents : Dictionary<AnyHashable, Any>
}

func ==(lhs: SectionAnnotation, rhs: SectionAnnotation) -> Bool {
    return lhs.key == rhs.key
}

public struct Parse {
    static func isOperator( value : String ) -> Bool {
        let regex = try? NSRegularExpression(pattern: "[=|{|}|;]", options: NSRegularExpression.Options.useUnixLineSeparators)
        
        guard let result = regex?.numberOfMatches(in: value, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: value.characters.count) ) else {
            return false
        }
        return result > 0 ? true : false
    }
    
    static func ignore( value : String ) -> Bool {
        let regex = try? NSRegularExpression(pattern: "[\n|\t]", options: NSRegularExpression.Options.useUnixLineSeparators)
        
        guard let result = regex?.numberOfMatches(in: value, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: value.characters.count) ) else {
            return false
        }
        return result > 0 ? true : false
    }
    
    static func parseAnnotations( string : String ) -> [NSTextCheckingResult]? {
        let regex = try? NSRegularExpression(pattern: "\\/\\* Begin [a-zA-Z]{1,} section \\/\\*", options: NSRegularExpression.Options.useUnixLineSeparators)
        
        let matches = regex?.matches(in: string, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: string.characters.count) )
        return matches
    }
    
    static func generateParsable( string : String ) -> Array<String> {
        
        let stack = string.characters.map{ String( $0 ) }.filter{ Parse.ignore(value: $0) == false }
        
        var newstack = Array<String>()
        var valuestack = Array<String>()
        for s in stack {
            if Parse.isOperator(value: s) == true {
                while valuestack.isEmpty == false && valuestack.last == " " {
                    _ = valuestack.popLast()
                }
                newstack.append( valuestack.joined(separator: "") )
                valuestack = Array<String>()
                newstack.append(s)
            } else {
                if valuestack.isEmpty == true && s == " " {
                    
                } else {
                    if s == "/" && valuestack.isEmpty == false && valuestack.last == "*" {
                        valuestack.append(s)
                        if let generated = AnnotationParser.generateDataFromAnnotation(value: valuestack) {
                            generated.forEach{ newstack.append($0) }
                            valuestack = Array<String>()
                        }
                    } else {
                        valuestack.append(s)
                    }
                }
            }
        }
        
        return newstack.filter{ $0 != "" }
    }
    
    static func semicolonDelemeter( string : String ) -> Array<String> {
        let filter: Set<Character> = Set( "\t\n".characters )
        let result = String(string.characters.filter{ filter.contains($0) == false })
//
//        return newstack.filter{ $0 != "" }
        
        return result.components(separatedBy: ";" )
    }
    
    static func parse( string : String ) -> Any? {
        var parsable = Parse.generateParsable(string: string)
        return ""
    }
}

