//
//  main.swift
//  xproj
//
//  Created by Jin Hyong Park on 13/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Foundation

print("Hello, World!")

/* if add new file as group then
add PBXBuildFile as
 {SOURCEUUID} = { ... fileRef = {FILEUUID} }
 
 
and add SOURCEUUID to
 PBXNativeTarget which name is {TARGET}
 {BUILDPHASEKEY} of PBXSourcesBuildPhase must be in PBXNativeTarget.buildPhases
 and {BUILDPHASEKEY} = { ... file = ( SOURCEUUID ) }
 
 and add FILEUUID to
 PBXFileReference as
 {FILEUUID} = { isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = {FILENAME}; sourceTree = "<group>";  }
 
 also
 PBXGroup as
 {GROUP_UUID} = { isa=PBXGroup; children = ( {FILEUUID} ); path = {LAST_PATH_COMPONENT} ... }
 
 */

/* if add new directory as group then 
 ROOT = PBXProject.mainGroup
 SOURCEROOT = one of PBXGroup[{ROOT}].children
 
 anyway
 
 add group to A/B/C/D
 search PBXGroup which name is A
 not exist, wrong name. error
 find {MATCHED_UUID} in {A_UUID} = PBXGroup.children with name B
 if exist, find MATCES_UUID in {B_UUID} = PBXGroup.children with name C
 not exist, create new one as
 NEW_UUID = { children = (); path=C; sourceTree="<group>"
 recursive to end
 
 */

struct main {
    init(args:Array<String>) {
        do {
            let arguments = try Arguments(args: args)

            
            let projectfile = try File.read(path: (arguments.project as NSString).appendingPathComponent("project.pbxproj") )
            
            if arguments.recursive == true {
                
            }
            
        } catch {
            Errors.handle(error: error)
        }
    }
}

let _ = main( args: CommandLine.arguments )
