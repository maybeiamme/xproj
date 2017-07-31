//
//  Entity.swift
//  xproj
//
//  Created by Jin Hyong Park on 27/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//
import Cocoa

struct STRING: NODE {
    var group: GROUP { return .component }
    var content: Any?
}

struct KEYVALUE: NODE {
    var key: String
    var value: Any
    var group: GROUP { return .component }
    var content: Any? { return nil }
    
    init( key: NODE, value: NODE ) throws {
        guard let key = key.content as? String, let value = value.content else {
            throw ParseError.expectedNODE
        }
        self.key = key
        self.value = value
    }
}

struct KEY: NODE {
    var content: Any?
    init( node: NODE ) {
        content = node.content
    }
    var group: GROUP { return .component }
}



enum GROUP {
    case delimiter
    case closer
    case start
    case string
    case component
    case unknown
}

protocol NODE {
    var group: GROUP { get }
    var content: Any? { get }
}

extension Dictionary: NODE {
    var group: GROUP { return .component }
    var content: Any? {
        return self
    }
}

extension Array: NODE {
    var group: GROUP { return .component }
    var content: Any? {
        return self
    }
}

extension Character: NODE {
    private var delimiters: String { return "=,;" }
    private var closers: String { return "})" }
    private var starters: String { return "{(" }
    private var string: String { return delimiters + closers + starters }
    var group: GROUP {
        if String( self ).rangeOfCharacter(from: CharacterSet(charactersIn: delimiters)) != nil {
            return .delimiter
        } else if String( self ).rangeOfCharacter(from: CharacterSet(charactersIn: closers)) != nil {
            return .closer
        } else if String( self ).rangeOfCharacter(from: CharacterSet(charactersIn: starters)) != nil {
            return .start
        } else if String( self ).rangeOfCharacter(from: CharacterSet(charactersIn: string).inverted ) != nil {
            return .string
        }
        else { return .unknown }
    }
    var content: Any? { return self }
}
