//
//  Repository.swift
//  TetrisJson
//
//  Created by  on 06.02.17.
//  Copyright © 2017 Matthias Zarzecki. All rights reserved.
//

import Foundation

class Repository {
    
    var repositoryName: String
    var userLoginName: String
    var hasWiki: Bool
    var displayName: String = ""
    
    init(repositoryName: String = "", userLoginName: String = "", hasWiki: Bool = false) {
        self.repositoryName = repositoryName
        self.userLoginName = userLoginName
        self.hasWiki = hasWiki
        displayName = "\(userLoginName), \(repositoryName)"
    }
}
