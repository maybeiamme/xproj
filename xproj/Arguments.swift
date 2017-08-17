//
//  Arguments.swift
//  xproj
//
//  Created by Jin Hyong Park on 31/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

//sourcery: needParamInitalizer = "true"
protocol ArgumentsProtocol: AutoMockable {
    var target: String { get }
    var destination: String { get }
    var recursive: Bool { get }
    var verbose: Bool { get }
    var files: Array<String> { get }
    var project: String { get }
}

struct Arguments: ArgumentsProtocol {
    var target: String {
        return values[ArgumentOption.target] as! String
    }
    var destination: String {
        return values[ArgumentOption.destination] as! String
    }
    var recursive: Bool {
        return values[ArgumentOption.recursive] as! Bool
    }
    var verbose: Bool {
        return values[ArgumentOption.verbose] as! Bool
    }
    var files: Array<String> {
        return values[ArgumentOption.files] as! Array<String>
    }
    var project: String {
        return values[ArgumentOption.project] as! String
    }
    
    fileprivate var values: Dictionary<ArgumentOption, Any>
    
    init( args: Array<String> ) throws {
        guard let currentDirectory = args.first?.components(separatedBy: "/").dropLast().joined(separator: "/") else {
            throw ArgumentError.wrongargument
        }
        var arguments = args.dropFirst().reversed() as Array<String>
        values = Dictionary<ArgumentOption, Any>()
        values[ArgumentOption.verbose] = false
        values[ArgumentOption.recursive] = false
        while arguments.isEmpty == false {
            if let argument = arguments.popLast(), Arguments.isOption(argument: argument) == true {
                switch Arguments.whichOption(argument: argument) {
                case .verbose:
                    values[ArgumentOption.verbose] = true
                case .recursive:
                    values[ArgumentOption.recursive] = true
                case .files:
                    var files = Array<String>()
                    while arguments.isEmpty == false, let file = arguments.last, Arguments.isOption(argument: file) == false {
                        files.append(file.replacingOccurrences(of: "./", with: currentDirectory + "/" ))
                        let _ = arguments.popLast()
                    }
                    values[ArgumentOption.files] = files
                case .target:
                    guard let target = arguments.popLast() else { throw ArgumentError.emptytarget }
                    values[ArgumentOption.target] = target
                case .project:
                    guard let project = arguments.popLast() else { throw ArgumentError.wrongargument }
                    values[ArgumentOption.project] = project.replacingOccurrences(of: "./", with: currentDirectory + "/" )
                case .destination:
                    guard let destination = arguments.popLast() else { throw ArgumentError.emptydestination }
                    values[ArgumentOption.destination] = destination
                case .help:
                    values[ArgumentOption.help] = true
                default:
                    throw ArgumentError.wrongargument
                }
            }
        }
        
        if values[ArgumentOption.help] != nil {
            throw ArgumentError.helpme
        }
        
        if values[ArgumentOption.destination] == nil {
            throw ArgumentError.emptydestination
        }
        
        if values[ArgumentOption.target] == nil {
            throw ArgumentError.emptytarget
        }
        
        if values[ArgumentOption.files] == nil {
            throw ArgumentError.emptyfiles
        }
        
        if values[ArgumentOption.project] == nil {
            throw ArgumentError.emptyproject
        }
    }
    
    static func isOption( argument: String ) -> Bool {
        if argument.hasPrefix("-") || argument.hasPrefix("--") { return true }
        else { return false }
    }
    
    static func whichOption( argument: String ) -> ArgumentOption {
        if argument == "-v" || argument == "--verbose" {
            return .verbose
        } else if argument == "-t" || argument == "--target" {
            return .target
        } else if argument == "-f" || argument == "--files" {
            return .files
        } else if argument == "-d" || argument == "--destination" {
            return .destination
        } else if argument == "-r" || argument == "--recursive" {
            return .recursive
        } else if argument == "-p" || argument == "--project" {
            return .project
        } else if argument == "-h" || argument == "--help" {
            return .help
        } else {
            return .unknown
        }
    }
}

public enum ArgumentOption: AutoHashable {
    case verbose
    case target
    case files
    case destination
    case recursive
    case project
    case unknown
    case help
}
