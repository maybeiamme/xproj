//
//  PBXParser.swift
//  xproj
//
//  Created by Jin Hyong Park on 26/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

protocol AutoEquatable {}
protocol AutoHashable {}

protocol PBXParserProtocol {
    func start( string: String ) throws -> NODE
}

struct Parser: PBXParserProtocol {
    func start( string: String ) throws -> NODE {
        var stack = Array<NODE>()
        for s in string.characters {
            if s.group == .unknown { throw ParseError.unexpectedNode }
            
            if s.group == .delimiter {
                if s == "=" {
                    var key: String = ""
                    while stack.isEmpty == false && stack.last?.group == .alphanumeric {
                        if let part = stack.popLast() as? Character {
                            let frag = String( part )
                            key += frag
                        }
                    }
                    stack.append(KEY(string: String(key.characters.reversed())))
                } else if s == "," {
                    var key: String = ""
                    while stack.isEmpty == false && stack.last?.group == .alphanumeric {
                        if let part = stack.popLast() as? Character {
                            let frag = String( part )
                            key += frag
                        }
                    }
                    stack.append(ELEMENT(value: String(key.characters.reversed())))
                } else {
                    stack.append(s)
                }
            } else if s.group == .alphanumeric {
                stack.append(s)
            } else if s.group == .terminator {
                if stack.last?.group == .alphanumeric {
                    var value: String = ""
                    while stack.isEmpty == false && (stack.last is KEY) == false {
                        if stack.last?.group != .alphanumeric { throw ParseError.unexpectedNode }
                        
                        if let part = stack.popLast() as? Character {
                            let frag = String( part )
                            value += frag
                        }
                    }
                    let component = VALUE(content: String(value.characters.reversed()))
                    guard let key = stack.popLast() as? KEY else { throw ParseError.unexpectedNode }
                    let keyvalue = KEYVALUE(key: key.content, value: component.content)
                    stack.append(keyvalue)
                } else if stack.last?.group == .delimiter && (stack.last as? Character) == "}" {
                    var result = Dictionary<String, Any>()
                    let _ = stack.popLast() // dispose start
                    while stack.isEmpty == false && (stack.last as? Character) != "{" {
                        guard let node = stack.popLast() as? KEYVALUE else { throw ParseError.unexpectedNode }
                        result[node.key] = node.value
                    }
                    let _ = stack.popLast() // dispose end
                    let component = VALUE(content: result)
                    if let key = stack.last as? KEY {
                        let keyvalue = KEYVALUE(key: key.content, value: component.content)
                        let _ = stack.popLast()
                        stack.append(keyvalue)
                    } else {
                        stack.append(result)
                    }
                } else if stack.last?.group == .delimiter && (stack.last as? Character) == ")" {
                    var array = Array<String>()
                    let _ = stack.popLast() // dispose start
                    while stack.isEmpty == false && (stack.last as? Character) != "(" {
                        guard let node = stack.popLast() as? ELEMENT else { throw ParseError.unexpectedNode }
                        array.append(node.value)
                    }
                    let _ = stack.popLast() // dispose end
                    let component = VALUE(content: array.reversed() as Array<String> )
                    guard let key = stack.popLast() as? KEY else { throw ParseError.unexpectedNode }
                    let keyvalue = KEYVALUE(key: key.content, value: component.content)
                    stack.append(keyvalue)
                }
            }
        }
        if let last = stack.last as? VALUE, let content = last.content as? Dictionary<String,Any> { return content }
        guard let anytype = stack.last else { throw ParseError.unexpectedNode }
        return anytype
    }
    
    static func isAcceptedDelimiters( value: Character ) -> Bool {
        return String( value ).rangeOfCharacter(from: CharacterSet(charactersIn: "{}=(),")) != nil ? true : false
    }
    
    static func isAlphaNumeric( value: Character ) -> Bool {
        var alphanumericSet = CharacterSet.alphanumerics
        alphanumericSet.insert(charactersIn:".")
        
        return String( value ).rangeOfCharacter(from: CharacterSet(charactersIn: "{}=();,").inverted) != nil ? true : false
    }
    
    static func clear( string: String ) -> String {
        guard let annotationRemoved = Parser.removeAnnotation(string: string) else { return "" }
        let cleanString = String( annotationRemoved.characters.filter{ $0 != " " && $0 != "\t" && $0 != "\n" } )
        return cleanString
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
}

struct ELEMENT: NODE {
    var value: String
    var group: GROUP { return .component }
}

struct ARRAY: NODE {
    var elements: Array<String>
    var group: GROUP { return .component }
}

struct KEYVALUE: NODE {
    var key: String
    var value: Any
    var group: GROUP { return .component }
}

struct KEY: NODE {
    var content: String
    init( string: String ) {
        content = string
    }
    var group: GROUP { return .component }
}

struct VALUE: NODE {
    var content: Any
    var group: GROUP { return .component }
    
    init( content: Any ) {
        self.content = content
    }
}

enum ParseError: Error {
    case unexpectedNode
    case brokenSyntax
}

enum GROUP {
    case delimiter
    case alphanumeric
    case component
    case dictionary
    case array
    case terminator
    case unknown
}

protocol NODE {
    var group: GROUP { get }
}

extension Dictionary: NODE {
    var group: GROUP { return .dictionary }
}

extension Array: NODE {
    var group: GROUP { return .array }
}

extension Character: NODE {
    var group: GROUP {
        if Parser.isAlphaNumeric(value: self) == true { return .alphanumeric }
        else if self == ";" { return .terminator }
        else if Parser.isAcceptedDelimiters(value: self) == true { return .delimiter }
        else { return .unknown }
    }
}
