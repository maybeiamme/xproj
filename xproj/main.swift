//
//  main.swift
//  xproj
//
//  Created by Jin Hyong Park on 13/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Foundation

struct main {
    init(args:Array<String>) {
        do {
            let arguments = try Arguments(args: args)
            var core = Core(argument: arguments)
            core.fileManager = File.self
            core.processArgument()
        } catch {
            Errors.handle(error: error)
        }
        
    }
}

let _ = main( args: CommandLine.arguments )
