//
//  Repository.swift
//  TetrisJson
//
//  Created by  on 06.02.17.
//  Copyright © 2017 Matthias Zarzecki. All rights reserved.
//

import Foundation

class Repository {
    
    var name = ""
    var userLoginName = ""
    var hasWiki = false
    
    func getDisplayName() -> String {
        return (name != "" && userLoginName != "") ? "\(userLoginName), \(name)" : ""
    }
    
}
