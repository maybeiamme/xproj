//
//  PBXBuildFile.swift
//  xproj
//
//  Created by Jin Hyong Park on 25/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

internal struct PBXBuildFileContainer {
    internal static func parse( string: String ) -> Array<String>? {
        do {
            let regex = try NSRegularExpression(pattern: ".*isa = PBXBuildFile.*", options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: string, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: string.characters.count) )
            
            let nsstring = string as NSString
            return matches.map{ nsstring.substring(with: $0.range) }
        } catch {
            print( error )
            return nil
        }
    }
}

enum Status {
    case key
    case value
    case openDictionary
    case closeDictionary
}

internal struct PBXBuildFile {
    internal static func parse( string: String? ) -> PBXBuildFile? {
        guard let string = string else { return nil }
        guard let annotationRemoved = PBXBuildFile.removeAnnotation(string: string) else { return nil }
        let spaceRemoved = String( annotationRemoved.characters.filter{ $0 != " " } )
        let readyToParse = "{" + spaceRemoved + "}"

        
        return nil
    }

    internal static func removeAnnotation( string: String ) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: "\\/\\*([^*]|[\\r\\n]|(\\*+([^*/]|[\\r\\n])))*\\*+\\/", options: NSRegularExpression.Options.caseInsensitive)
            return regex.stringByReplacingMatches(in: string, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: string.characters.count), withTemplate: "")
        } catch {
            print( error )
            return nil
        }
    }
    
    let uuid: String
    let isa = "PBXBuildFile"
    let fileRef: String
}
