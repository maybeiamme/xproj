//
//  PBXParser.swift
//  xproj
//
//  Created by Jin Hyong Park on 26/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

public protocol AutoEquatable {}
public protocol AutoHashable {}
public protocol AutoMockable {}

internal struct PBXCollection: NODE {
    var array: Array<KEYVALUE>
    var dictionary: Dictionary<String,Any>
    var group: GROUP { return .component }
    var content: Any? { return self }
}

internal struct Parser: PBXParserProtocol {
    
    internal func start( string: String ) throws -> PBXCollection {
        let cleaned = Parser.clear(string: string)
        var stack = Array<NODE>()
        var doublequat = false
        
        for s in cleaned.characters {
            if s == "\"" {
                doublequat = !doublequat
                
                if doublequat == true {
                    var node = STRING()
                    node.content = String("")
                    stack.append(node)
                }
                continue
            }
            if doublequat == true {
                if var stringNode = stack.last as? STRING {
                    stringNode.content = (stringNode.content as? String ?? "") + String(s)
                    let _ = stack.popLast()
                    stack.append(stringNode)
                } else {
                    var node = STRING()
                    node.content = String("")
                    stack.append(node)
                }
                continue
            }

            if s.group == .unknown { throw ParseError.unknownNode }
            
            if s.group == .delimiter {
                if s == "=" {
                    guard let node = stack.popLast() as? STRING else { throw ParseError.expectedSTRING }
                    let key = KEY(node: node)
                    stack.append(key)
                } else if s == ";" {
                    guard let value = stack.popLast() else { throw ParseError.expectedNODE }
                    guard let key = stack.popLast() as? KEY else { throw ParseError.expectedKEY }
                    let keyvalue = try KEYVALUE(key: key, value: value)
                    stack.append(keyvalue)
                } else if s == "," {
                    var node = STRING()
                    node.content = ""
                    stack.append(node)
                }
            } else if s.group == .start {
                stack.append(s)
            } else if s.group == .string {
                if var stringNode = stack.last as? STRING {
                    stringNode.content = (stringNode.content as? String ?? "") + String(s)
                    let _ = stack.popLast()
                    stack.append(stringNode)
                } else {
                    var node = STRING()
                    node.content = String(s)
                    stack.append(node)
                }
            } else if s.group == .closer {
                if s == "}" {
                    var dictionary: Dictionary<String,Any> = Dictionary<String,Any>()
                    var array: Array<KEYVALUE> = Array<KEYVALUE>()
                    while (stack.last as? Character) != "{" {
                        guard let keyvalue = stack.popLast() as? KEYVALUE else {
                            print( "current stack is : [\(stack)]")
                            throw ParseError.expectedKEYVALUE
                        }
                        dictionary[keyvalue.key] = keyvalue.value
                        array.append(keyvalue)
                    }
                    let _ = stack.popLast()
                    
                    stack.append(PBXCollection(array: array.reversed(), dictionary: dictionary))
                } else if s == ")" {
                    var array: Array<Any> = Array<Any>()
                    while (stack.last as? Character) != "(" {
                        guard let node = stack.popLast(), let content = node.content else { throw ParseError.expectedNODE }
                        if let value = content as? String {
                            if value.characters.count > 0 {
                                array.append(value)
                            }
                        } else {
                            array.append(content)
                        }
                    }
                    let _ = stack.popLast()
                    stack.append(array)
                }
            }
        }
        
        guard let last = stack.last as? PBXCollection else { throw ParseError.brokenSyntax }
        return last
    }
    
    internal static func clear( string: String ) -> String {
        guard let annotationRemoved = Parser.removeAnnotation(string: string) else { return "" }
        guard let removeCommentedOut = Parser.removeCommentedOut(string: annotationRemoved) else { return "" }
        var betweenDoublequat = false
        var cleanString = ""
        for c in removeCommentedOut.characters {
            if c == "\"" {
                betweenDoublequat = !betweenDoublequat
            }
            if betweenDoublequat == true {
                cleanString += String(c)
            } else {
                if c != " " && c != "\t" && c != "\n" {
                    
                } else {
                    cleanString += String(c)
                }
            }
        }
//        let cleanString = String( removeCommentedOut.characters.filter{ $0 != " " && $0 != "\t" && $0 != "\n" } )
        return cleanString
    }
    
    internal static func removeAnnotation( string: String ) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: "\\/\\*([^*]|[\\r\\n]|(\\*+([^*/]|[\\r\\n])))*\\*+\\/", options: NSRegularExpression.Options.caseInsensitive)
            return regex.stringByReplacingMatches(in: string, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: string.characters.count), withTemplate: "")
        } catch {
            Errors.handle(error: error)
            return nil
        }
    }
    
    internal static func removeCommentedOut( string: String ) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: "\\/\\/.*", options: NSRegularExpression.Options.caseInsensitive)
            return regex.stringByReplacingMatches(in: string, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: string.characters.count), withTemplate: "")
        } catch {
            Errors.handle(error: error)
            return nil
        }
    }
}
